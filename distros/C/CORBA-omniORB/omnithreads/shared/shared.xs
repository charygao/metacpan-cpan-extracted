/*    shared.xs
 *
 *    Copyright (c) 2001-2002, 2006 Larry Wall
 *
 *    You may distribute under the terms of either the GNU General Public
 *    License or the Artistic License, as specified in the README file.
 *
 * "Hand any two wizards a piece of rope and they would instinctively pull in
 * opposite directions."
 *                         --Sourcery
 *
 * Contributed by Arthur Bergman arthur@contiller.se
 * pulled in the (an)other direction by Nick Ing-Simmons nick@ing-simmons.net
 */

/*
 * Shared variables are implemented by a scheme similar to tieing.
 * Each thread has a proxy SV with attached magic -- "private SVs" --
 * which all point to a single SV in a separate shared interpreter
 * (PL_sharedsv_space) -- "shared SVs".
 *
 * The shared SV holds the variable's true values, and its state is
 * copied between the shared and private SVs with the usual
 * mg_get()/mg_set() arrangement.
 *
 * Aggregates (AVs and HVs) are implemented using tie magic, except that
 * the vtable used is one defined in this file rather than the standard one.
 * This means that where a tie function like is FETCH is normally invoked by
 * the tie magic's mg_get() function, we completely bypass the calling of a
 * perl-level function, and directly call C-level code to handle it. On
 * the other hand. calls to functions like PUSH are done directly by code
 * in av.c etc, which we can't bypass. So the best we can do is to provide
 * XS versions of these functions. We also have to attach a tie object,
 * blessed into the class threads::shared::tie, to keep the method-calling
 * code happy.
 *
 * Access to aggregate elements is done the usual tied way by returning a
 * proxy PVLV element with attached element magic.
 *
 * Pointers to the shared SV are squirrelled away in the mg->mg_ptr field
 * of magic (with mg_len == 0), and in the IV2PTR(SvIV(sv)) field of tied
 * object SVs. These pointers have to be hidden like this because they
 * cross interpreter boundaries, and we don't want sv_clear() and friends
 * following them.
 *
 * The three basic shared types look like the following:
 *
 * -----------------
 *
 * Shared scalar (my $s : shared):
 *
 *  SV = PVMG(0x7ba238) at 0x7387a8
 *   FLAGS = (PADMY,GMG,SMG)
 *   MAGIC = 0x824d88
 *     MG_TYPE = PERL_MAGIC_shared_scalar(n)
 *     MG_PTR = 0x810358		<<<< pointer to the shared SV
 *
 * -----------------
 *
 * Shared aggregate (my @a : shared;  my %h : shared):
 *
 * SV = PVAV(0x7175d0) at 0x738708
 *   FLAGS = (PADMY,RMG)
 *   MAGIC = 0x824e48
 *     MG_TYPE = PERL_MAGIC_tied(P)
 *     MG_OBJ = 0x7136e0		<<<< ref to the tied object
 *     SV = RV(0x7136f0) at 0x7136e0
 *       RV = 0x738640
 *       SV = PVMG(0x7ba238) at 0x738640 <<<< the tied object
 *         FLAGS = (OBJECT,IOK,pIOK)
 *         IV = 8455000			<<<< pointer to the shared AV
 *         STASH = 0x80abf0 "omnithreads::shared::tie"
 *     MG_PTR = 0x810358 ""		<<<< another pointer to the shared AV
 *   ARRAY = 0x0
 *
 * -----------------
 *
 * Aggregate element (my @a : shared; $a[0])
 *
 * SV = PVLV(0x77f628) at 0x713550
 *   FLAGS = (GMG,SMG,RMG,pIOK)
 *   MAGIC = 0x72bd58
 *     MG_TYPE = PERL_MAGIC_shared_scalar(n)
 *     MG_PTR = 0x8103c0 ""		<<<< pointer to the shared element
 *   MAGIC = 0x72bd18
 *     MG_TYPE = PERL_MAGIC_tiedelem(p)
 *     MG_OBJ = 0x7136e0		<<<< ref to the tied object
 *     SV = RV(0x7136f0) at 0x7136e0
 *       RV = 0x738660
 *       SV = PVMG(0x7ba278) at 0x738660 <<<< the tied object
 *         FLAGS = (OBJECT,IOK,pIOK)
 *         IV = 8455064			<<<< pointer to the shared AV
 *         STASH = 0x80ac30 "omnithreads::shared::tie"
 *   TYPE = t
 *
 * Note that PERL_MAGIC_tiedelem(p) magic doesn't have a pointer to a
 * shared SV in mg_ptr; instead this is used to store the hash key,
 * if any, like normal tied elements. Note also that element SVs may have
 * pointers to both the shared aggregate and the shared element
 *
 *
 * Userland locks:
 *
 * if a shared variable is used as a perl-level lock or condition
 * variable, then PERL_MAGIC_ext magic is attached to the associated
 * *shared* SV, whose mg_ptr field points to a malloced structure
 * containing the necessary mutexes and condition variables.
 *
 * Nomenclature:
 *
 * In this file, any variable name prefixed with 's', eg ssv, stmp or sobj,
 * usually represents a shared SV which correspondis to a private SV named
 * without the prefix, eg sv, tmp or obj.
 */

#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#ifdef HAS_PPPORT_H
#  define NEED_vnewSVpvf
#  define NEED_warner
#  include "ppport.h"
#endif

#ifndef HvNAME_get
#define HvNAME_get HvNAME
#endif

#ifndef DPTR2FPTR
#define DPTR2FPTR(t,p) ((t)(PTRV)(p))
#endif 

#if !defined(USE_ITHREADS)
#error Unsupported threading model
#endif

static UV
S_dummy_unlock(pTHX)
{
  return 0UL;
}

static UV (*unlock_interpreter)(pTHX) = S_dummy_unlock;

static void
S_dummy_relock(pTHX_ UV token)
{
}

static void (*relock_interpreter)(pTHX, UV token) = S_dummy_relock;

/*
 * The shared things need an intepreter to live in ...
 */
PerlInterpreter *PL_sharedsv_space;             /* The shared sv space */
/* To access shared space we fake aTHX in this scope and thread's context */

/* bug #24255: we include ENTER+SAVETMPS/FREETMPS+LEAVE with
 * SHARED_CONTEXT/CALLER_CONTEXT macros, so that any mortals etc created
 * while in the shared interpreter context don't languish */

#define SHARED_CONTEXT \
    STMT_START {					\
	PERL_SET_CONTEXT((aTHX = PL_sharedsv_space));	\
	ENTER;						\
	SAVETMPS;					\
    } STMT_END

/* So we need a way to switch back to the caller's context... */
/* So we declare _another_ copy of the aTHX variable ... */
#define dTHXc PerlInterpreter *caller_perl = aTHX

/* and use it to switch back */
#define CALLER_CONTEXT					\
    STMT_START {					\
    	FREETMPS;					\
	LEAVE;						\
	PERL_SET_CONTEXT((aTHX = caller_perl));		\
    } STMT_END

/*
 * Only one thread at a time is allowed to mess with shared space.
 */

typedef struct
{
 perl_mutex		 mutex;
 PerlInterpreter	*owner;
 I32			 locks;
 perl_cond		 cond;
#ifdef DEBUG_LOCKS
 char *			 file;
 int			 line;
#endif
} recursive_lock_t;

recursive_lock_t PL_sharedsv_lock;       /* Mutex protecting the shared sv space */

void
recursive_lock_init(pTHX_ recursive_lock_t *lock)
{
    Zero(lock,1,recursive_lock_t);
    MUTEX_INIT(&lock->mutex);
    COND_INIT(&lock->cond);
}

void
recursive_lock_destroy(pTHX_ recursive_lock_t *lock)
{
    MUTEX_DESTROY(&lock->mutex);
    COND_DESTROY(&lock->cond);
}

void
recursive_lock_release(pTHX_ recursive_lock_t *lock)
{
    MUTEX_LOCK(&lock->mutex);
    if (lock->owner != aTHX) {
	MUTEX_UNLOCK(&lock->mutex);
    }
    else {
	if (--lock->locks == 0) {
	    lock->owner = NULL;
	    COND_SIGNAL(&lock->cond);
	}
    }
    MUTEX_UNLOCK(&lock->mutex);
}

void
recursive_lock_acquire(pTHX_ recursive_lock_t *lock,char *file,int line)
{
    assert(aTHX);
    MUTEX_LOCK(&lock->mutex);
    if (lock->owner == aTHX) {
	lock->locks++;
    }
    else {
        UV token = unlock_interpreter(aTHX);
	while (lock->owner) {
#ifdef DEBUG_LOCKS
	    Perl_warn(aTHX_ " %p waiting - owned by %p %s:%d\n",
		      aTHX, lock->owner, lock->file, lock->line);
#endif
	    COND_WAIT(&lock->cond,&lock->mutex);
        }
	lock->locks = 1;
	lock->owner = aTHX;
#ifdef DEBUG_LOCKS
	lock->file  = file;
	lock->line  = line;
#endif
        relock_interpreter(aTHX_ token);
    }
    MUTEX_UNLOCK(&lock->mutex);
    SAVEDESTRUCTOR_X(recursive_lock_release,lock);
}

#define ENTER_LOCK         STMT_START { \
			      ENTER; \
			      recursive_lock_acquire(aTHX_ &PL_sharedsv_lock, __FILE__, __LINE__);   \
                            } STMT_END

/* the unlocking is done automatically at scope exit */
#define LEAVE_LOCK       LEAVE


/* A common idiom is to acquire access and switch in ... */
#define SHARED_EDIT	    STMT_START {	\
				ENTER_LOCK;	\
				SHARED_CONTEXT;	\
			    } STMT_END

/* then switch out and release access. */
#define SHARED_RELEASE     STMT_START {	\
		                CALLER_CONTEXT;	\
				LEAVE_LOCK;	\
			    } STMT_END


/* user-level locks:
   This structure is attached (using ext magic) to any shared SV that
   is used by user-level locking or condition code
*/

typedef struct {
    recursive_lock_t    lock;		/* for user-levl locks */
    perl_cond           user_cond;      /* For user-level conditions */
} user_lock;

/* magic used for attaching user_lock structs to shared SVs

   The vtable used has just one entry - when the SV goes away
   we free the memory for the above.
 */

int
sharedsv_userlock_free(pTHX_ SV *sv, MAGIC *mg)
{
    user_lock *ul = (user_lock *) mg->mg_ptr;
    assert(aTHX == PL_sharedsv_space);
    if (ul) {
	recursive_lock_destroy(aTHX_ &ul->lock);
	COND_DESTROY(&ul->user_cond);
	PerlMemShared_free(ul);
	mg->mg_ptr = NULL;
    }
    return 0;
}

MGVTBL sharedsv_uesrlock_vtbl = {
 0,				/* get */
 0,				/* set */
 0,				/* len */
 0,				/* clear */
 sharedsv_userlock_free,	/* free */
 0,				/* copy */
 0,				/* dup */
#ifdef MGf_LOCAL
 0				/* local */
#endif
};

/* Access to shared things is heavily based on MAGIC - in mg.h/mg.c/sv.c sense */

/* In any thread that has access to a shared thing there is a "proxy"
   for it in its own space which has 'MAGIC' associated which accesses
   the shared thing.
 */

MGVTBL sharedsv_scalar_vtbl;    /* scalars have this vtable */
MGVTBL sharedsv_array_vtbl;     /* hashes and arrays have this - like 'tie' */
MGVTBL sharedsv_elem_vtbl;      /* elements of hashes and arrays have this
				   _AS WELL AS_ the scalar magic:
   The sharedsv_elem_vtbl associates the element with the array/hash and
   the sharedsv_scalar_vtbl associates it with the value
 */


/* get shared aggregate SV pointed to by threads::shared::tie magic object */

STATIC SV *
S_sharedsv_from_obj(pTHX_ SV *sv)
{
     return SvROK(sv) ? INT2PTR(SV *, SvIV(SvRV(sv))) : NULL;
}


/* Return the user_lock structure (if any) associated with a shared SV.
 * If create is true, create one if it doesn't exist */

STATIC user_lock *
S_get_userlock(pTHX_ SV* ssv, bool create)
{
    MAGIC *mg;
    user_lock *ul = NULL;

    assert(ssv);
    /* XXX redsign the storage of user locks so we dont need a global
     * lock to access them ???? DAPM */
    ENTER_LOCK;
    mg = mg_find(ssv, PERL_MAGIC_ext);
    if (mg)
	ul = (user_lock*)(mg->mg_ptr);
    else if (create) {
	dTHXc;
	SHARED_CONTEXT;
	ul = (user_lock *) PerlMemShared_malloc(sizeof(user_lock));
	Zero(ul, 1, user_lock);
	/* attach to shared SV using ext magic */
	sv_magicext(ssv, NULL, PERL_MAGIC_ext, &sharedsv_uesrlock_vtbl,
	       (char *)ul, 0);
	recursive_lock_init(aTHX_ &ul->lock);
	COND_INIT(&ul->user_cond);
	CALLER_CONTEXT;
    }
    LEAVE_LOCK;
    return ul;
}


=for apidoc sharedsv_find

Given a private side SV tries to find if the SV has a shared backend,
by looking for the magic.

=cut

SV *
Perl_sharedsv_find(pTHX_ SV *sv)
{
    MAGIC *mg;
    if (SvTYPE(sv) >= SVt_PVMG) {
	switch(SvTYPE(sv)) {
	case SVt_PVAV:
	case SVt_PVHV:
	    if ((mg = mg_find(sv, PERL_MAGIC_tied))
		&& mg->mg_virtual == &sharedsv_array_vtbl) {
		return (SV *) mg->mg_ptr;
	    }
	    break;
	default:
	    /* This should work for elements as well as they
	     * have scalar magic as well as their element magic
	     */
	    if ((mg = mg_find(sv, PERL_MAGIC_shared_scalar))
		&& mg->mg_virtual == &sharedsv_scalar_vtbl) {
		return (SV *) mg->mg_ptr;
	    }
	    break;
	}
    }
    /* Just for tidyness of API also handle tie objects */
    if (SvROK(sv) && sv_derived_from(sv, "omnithreads::shared::tie")) {
	return S_sharedsv_from_obj(aTHX_ sv);
    }
    return NULL;
}


/* associate a private SV  with a shared SV by pointing the appropriate
 * magics at it.  Assumes lock is held */

void
Perl_sharedsv_associate(pTHX_ SV *sv, SV *ssv)
{
    dTHXc;
    MAGIC *mg = 0;

    /* If we are asked for any private ops we need a thread */
    assert ( aTHX !=  PL_sharedsv_space );

    /* To avoid need for recursive locks require caller to hold lock */
    assert ( PL_sharedsv_lock.owner == aTHX );

    switch(SvTYPE(sv)) {
    case SVt_PVAV:
    case SVt_PVHV:
	if (!(mg = mg_find(sv, PERL_MAGIC_tied))
	    || mg->mg_virtual != &sharedsv_array_vtbl
	    || (SV*) mg->mg_ptr != ssv)
	{
	    SV *obj = newSV(0);
	    sv_setref_iv(obj, "omnithreads::shared::tie",PTR2IV(ssv));
	    if (mg) {
		sv_unmagic(sv, PERL_MAGIC_tied);
	    }
	    mg = sv_magicext(sv, obj, PERL_MAGIC_tied, &sharedsv_array_vtbl,
			    (char *) ssv, 0);
	    mg->mg_flags |= (MGf_COPY|MGf_DUP);
	    SvREFCNT_inc(ssv);
	    SvREFCNT_dec(obj);
	}
	break;

    default:
	if ((SvTYPE(sv) < SVt_PVMG)
	    || !(mg = mg_find(sv, PERL_MAGIC_shared_scalar))
	    || mg->mg_virtual != &sharedsv_scalar_vtbl
	    || (SV*) mg->mg_ptr != ssv)
	{
	    if (mg) {
		sv_unmagic(sv, PERL_MAGIC_shared_scalar);
	    }
	    mg = sv_magicext(sv, Nullsv, PERL_MAGIC_shared_scalar,
			    &sharedsv_scalar_vtbl, (char *)ssv, 0);
	    mg->mg_flags |= (MGf_DUP
#ifdef MGf_LOCAL
			     |MGf_LOCAL
#endif
			     );
	    SvREFCNT_inc(ssv);
	}
	break;
    }
    assert ( Perl_sharedsv_find(aTHX_ sv) == ssv );
}


/* Given a private SV, create and return an associated shared SV.
 * Assumes lock is held */

STATIC SV *
S_sharedsv_new_shared(pTHX_ SV *sv)
{
    dTHXc;
    SV *ssv;

    assert(PL_sharedsv_lock.owner == aTHX);
    assert(aTHX !=  PL_sharedsv_space);

    SHARED_CONTEXT;
    ssv = newSV(0);
    SvREFCNT(ssv) = 0; /* will be upped to 1 by Perl_sharedsv_associate */
    sv_upgrade(ssv, SvTYPE(sv));
    CALLER_CONTEXT;
    Perl_sharedsv_associate(aTHX_ sv, ssv);
    return ssv;
}


/* Given a shared SV, create and return an associated private SV.
 * Assumes lock is held */

STATIC SV *
S_sharedsv_new_private(pTHX_ SV *ssv)
{
    SV *sv;

    assert(PL_sharedsv_lock.owner == aTHX);
    assert(aTHX !=  PL_sharedsv_space);

    sv = newSV(0);
    sv_upgrade(sv, SvTYPE(ssv));
    Perl_sharedsv_associate(aTHX_ sv, ssv);
    return sv;
}


/* a threadsafe version of SvREFCNT_dec(ssv) */

STATIC void
S_sharedsv_dec(pTHX_ SV* ssv)
{
    if (!ssv)
	return;
    ENTER_LOCK;
    if (SvREFCNT(ssv) > 1) {
	/* no side effects, so can do it lightweight */
	SvREFCNT_dec(ssv);
    }
    else {
	dTHXc;
	SHARED_CONTEXT;
	SvREFCNT_dec(ssv);
	CALLER_CONTEXT;
    }
    LEAVE_LOCK;
}

/* implements Perl-level share() and :shared */

void
Perl_sharedsv_share(pTHX_ SV *sv)
{
    switch(SvTYPE(sv)) {
    case SVt_PVGV:
	Perl_croak(aTHX_ "Cannot share globs yet");
	break;

    case SVt_PVCV:
	Perl_croak(aTHX_ "Cannot share subs yet");
	break;

    default:
	ENTER_LOCK;
	(void) S_sharedsv_new_shared(aTHX_ sv);
	LEAVE_LOCK;
	SvSETMAGIC(sv);
	break;
    }
}

#if defined(WIN32) || defined(OS2)
#  define ABS2RELMILLI(abs)        \
    do {                                \
        abs -= (double)time(NULL);      \
        if (abs > 0) { abs *= 1000; }   \
        else         { abs  = 0;    }   \
    } while (0)
#endif /* WIN32 || OS2 */

/* do OS-specific condition timed wait */

bool
Perl_sharedsv_cond_timedwait(perl_cond *cond, perl_mutex *mut, double abs)
{
#  ifdef WIN32
    int got_it = 0;

    ABS2RELMILLI(abs);

    cond->waiters++;
    MUTEX_UNLOCK(mut);
    /* See comments in win32/win32thread.h COND_WAIT vis-a-vis race */
    switch (WaitForSingleObject(cond->sem, (DWORD)abs)) {
        case WAIT_OBJECT_0:   got_it = 1; break;
        case WAIT_TIMEOUT:                break;
        default:
            /* WAIT_FAILED? WAIT_ABANDONED? others? */
            Perl_croak_nocontext("panic: cond_timedwait (%ld)",GetLastError());
            break;
    }
    MUTEX_LOCK(mut);
    cond->waiters--;
    return got_it;
#  else
#    ifdef OS2
    int rc, got_it = 0;
    STRLEN n_a;

    ABS2RELMILLI(abs);

    if ((rc = DosResetEventSem(*cond,&n_a)) && (rc != ERROR_ALREADY_RESET))
        Perl_rc = rc, croak_with_os2error("panic: cond_timedwait-reset");
    MUTEX_UNLOCK(mut);
    if (CheckOSError(DosWaitEventSem(*cond,abs))
        && (rc != ERROR_INTERRUPT))
        croak_with_os2error("panic: cond_timedwait");
    if (rc == ERROR_INTERRUPT) errno = EINTR;
    MUTEX_LOCK(mut);
    return got_it;
#    else         /* hope you're I_PTHREAD! */
    struct timespec ts;
    int got_it = 0;

    ts.tv_sec = (long)abs;
    abs -= (NV)ts.tv_sec;
    ts.tv_nsec = (long)(abs * 1000000000.0);

    switch (pthread_cond_timedwait(cond, mut, &ts)) {
        case 0:         got_it = 1; break;
        case ETIMEDOUT:             break;
#ifdef OEMVS
        case -1:
	  if (errno == ETIMEDOUT || errno == EAGAIN)
	    break;
#endif
        default:
            Perl_croak_nocontext("panic: cond_timedwait");
            break;
    }
    return got_it;
#    endif /* OS2 */
#  endif /* WIN32 */
}


/* given a shared RV, copy it's value to a private RV, also coping the
 * object status of the referent.
 * If the private side is already an appropriate RV->SV combination, keep
 * it if possible.
 */

STATIC void
S_get_RV(pTHX_ SV *sv, SV *ssv) {
    SV *sobj = SvRV(ssv);
    SV *obj;
    if ( ! (   SvROK(sv)
	    && ((obj = SvRV(sv)))
	    && (Perl_sharedsv_find(aTHX_ obj) == sobj)
	    && (SvTYPE(obj) == SvTYPE(sobj))
	    )
	)
    {
    	/* can't reuse obj */
	if (SvROK(sv))  {
	    SvREFCNT_dec(SvRV(sv));
	}
	else {
	    assert(SvTYPE(sv) >= SVt_RV);
	    sv_setsv_nomg(sv, &PL_sv_undef);
	    SvROK_on(sv);
	}
	obj = S_sharedsv_new_private(aTHX_ SvRV(ssv));
	SvRV_set(sv, obj);
    }

    if (SvOBJECT(obj)) {
	/* remove any old blessing */
	SvREFCNT_dec(SvSTASH(obj));
	SvOBJECT_off(obj);
    }
    if (SvOBJECT(sobj)) {
	/* add any new old blessing */
	STRLEN len;
	char* stash_ptr = SvPV((SV*) SvSTASH(sobj), len);
	HV* stash = gv_stashpvn(stash_ptr, len, TRUE);
	SvOBJECT_on(obj);
	SvSTASH_set(obj, (HV*)SvREFCNT_inc(stash));
    }
}


/* ------------ PERL_MAGIC_shared_scalar(n) functions -------------- */

/* get magic for PERL_MAGIC_shared_scalar(n) */

int
sharedsv_scalar_mg_get(pTHX_ SV *sv, MAGIC *mg)
{
    SV *ssv = (SV *) mg->mg_ptr;
    assert(ssv);

    ENTER_LOCK;
    if (SvROK(ssv)) {
	S_get_RV(aTHX_ sv, ssv);
    }
    else {
	sv_setsv_nomg(sv, ssv);
    }
    LEAVE_LOCK;
    return 0;
}

/* copy the contents of a private SV to a shared SV:
 * used by various mg_set()-type functions.
 * Assumes lock is held */

void
sharedsv_scalar_store(pTHX_ SV *sv, SV *ssv)
{
    dTHXc;
    bool allowed = TRUE;

    assert(PL_sharedsv_lock.owner == aTHX);
    if (SvROK(sv)) {
	SV *obj = SvRV(sv);
	SV *sobj = Perl_sharedsv_find(aTHX_ obj);
	if (sobj) {
	    SHARED_CONTEXT;
	    SvUPGRADE(ssv, SVt_RV);
	    sv_setsv_nomg(ssv, &PL_sv_undef);
	    
	    SvRV_set(ssv, SvREFCNT_inc(sobj));
	    SvROK_on(ssv);
	    if(SvOBJECT(obj)) {
	      SV* fake_stash = newSVpv(HvNAME_get(SvSTASH(obj)),0);
	      SvOBJECT_on(sobj);
	      SvSTASH_set(sobj, (HV*)fake_stash);
	    }
	    CALLER_CONTEXT;
	}
	else {
	    allowed = FALSE;
	}
    }
    else {
        SvTEMP_off(sv);
	SHARED_CONTEXT;
	sv_setsv_nomg(ssv, sv);
	if(SvOBJECT(sv)) {
	  SV* fake_stash = newSVpv(HvNAME_get(SvSTASH(sv)),0);
	  SvOBJECT_on(ssv);
	  SvSTASH_set(ssv, (HV*)fake_stash);
	}
	CALLER_CONTEXT;
    }
    if (!allowed) {
	Perl_croak(aTHX_ "Invalid value for shared scalar");
    }
}

/* set magic for PERL_MAGIC_shared_scalar(n) */

int
sharedsv_scalar_mg_set(pTHX_ SV *sv, MAGIC *mg)
{
    SV *ssv = (SV*)(mg->mg_ptr);
    assert(ssv);
    ENTER_LOCK;
    if (SvTYPE(ssv) < SvTYPE(sv)) {
	dTHXc;
	SHARED_CONTEXT;
	sv_upgrade(ssv, SvTYPE(sv));
	CALLER_CONTEXT;
    }
    sharedsv_scalar_store(aTHX_ sv, ssv);
    LEAVE_LOCK;
    return 0;
}

/* free magic for PERL_MAGIC_shared_scalar(n) */

int
sharedsv_scalar_mg_free(pTHX_ SV *sv, MAGIC *mg)
{
    S_sharedsv_dec(aTHX_ (SV*)mg->mg_ptr);
    return 0;
}

/*
 * Called during cloning of PERL_MAGIC_shared_scalar(n) magic in new thread
 */
int
sharedsv_scalar_mg_dup(pTHX_ MAGIC *mg, CLONE_PARAMS *param)
{
    SvREFCNT_inc(mg->mg_ptr);
    return 0;
}

/*
 * Called during local $shared
 */
int
sharedsv_scalar_mg_local(pTHX_ SV* nsv, MAGIC *mg)
{
    MAGIC *nmg;
    SV *ssv = (SV *) mg->mg_ptr;
    if (ssv) {
	ENTER_LOCK;
	SvREFCNT_inc(ssv);
	LEAVE_LOCK;
    }
    nmg = sv_magicext(nsv, mg->mg_obj, mg->mg_type, mg->mg_virtual,
			    mg->mg_ptr, mg->mg_len);
    nmg->mg_flags   = mg->mg_flags;
    nmg->mg_private = mg->mg_private;

    return 0;
}

MGVTBL sharedsv_scalar_vtbl = {
 sharedsv_scalar_mg_get,	/* get */
 sharedsv_scalar_mg_set,	/* set */
 0,				/* len */
 0,				/* clear */
 sharedsv_scalar_mg_free,	/* free */
 0,				/* copy */
 sharedsv_scalar_mg_dup,	/* dup */
#ifdef MGf_LOCAL
 sharedsv_scalar_mg_local	/* local */
#endif
};

/* ------------ PERL_MAGIC_tiedelem(p) functions -------------- */

/* get magic for PERL_MAGIC_tiedelem(p) */

int
sharedsv_elem_mg_FETCH(pTHX_ SV *sv, MAGIC *mg)
{
    dTHXc;
    SV *saggregate = S_sharedsv_from_obj(aTHX_ mg->mg_obj);
    SV** svp;

    ENTER_LOCK;
    if (SvTYPE(saggregate) == SVt_PVAV) {
	assert ( mg->mg_ptr == 0 );
	SHARED_CONTEXT;
	svp = av_fetch((AV*) saggregate, mg->mg_len, 0);
    }
    else {
	char *key = mg->mg_ptr;
	STRLEN len = mg->mg_len;
	assert ( mg->mg_ptr != 0 );
	if (mg->mg_len == HEf_SVKEY) {
	   key = SvPV((SV *) mg->mg_ptr, len);
	}
	SHARED_CONTEXT;
	svp = hv_fetch((HV*) saggregate, key, len, 0);
    }
    CALLER_CONTEXT;
    if (svp) {
	/* Exists in the array */
	if (SvROK(*svp)) {
	    S_get_RV(aTHX_ sv, *svp);
	}
	else {
	    /* XXX can this branch ever happen? DAPM */
	    /* XXX assert("no such branch"); */
	    Perl_sharedsv_associate(aTHX_ sv, *svp);
	    sv_setsv(sv, *svp);
	}
    }
    else {
	/* Not in the array */
	sv_setsv(sv, &PL_sv_undef);
    }
    LEAVE_LOCK;
    return 0;
}

/* set magic for PERL_MAGIC_tiedelem(p) */

int
sharedsv_elem_mg_STORE(pTHX_ SV *sv, MAGIC *mg)
{
    dTHXc;
    SV *saggregate = S_sharedsv_from_obj(aTHX_ mg->mg_obj);
    SV **svp;
    /* Theory - SV itself is magically shared - and we have ordered the
       magic such that by the time we get here it has been stored
       to its shared counterpart
     */
    ENTER_LOCK;
    assert(saggregate);
    if (SvTYPE(saggregate) == SVt_PVAV) {
	assert ( mg->mg_ptr == 0 );
	SHARED_CONTEXT;
	svp = av_fetch((AV*) saggregate, mg->mg_len, 1);
    }
    else {
	char *key = mg->mg_ptr;
	STRLEN len = mg->mg_len;
	assert ( mg->mg_ptr != 0 );
	if (mg->mg_len == HEf_SVKEY)
	   key = SvPV((SV *) mg->mg_ptr, len);
	SHARED_CONTEXT;
	svp = hv_fetch((HV*) saggregate, key, len, 1);
    }
    CALLER_CONTEXT;
    Perl_sharedsv_associate(aTHX_ sv, *svp);
    sharedsv_scalar_store(aTHX_ sv, *svp);
    LEAVE_LOCK;
    return 0;
}

/* clear magic for PERL_MAGIC_tiedelem(p) */

int
sharedsv_elem_mg_DELETE(pTHX_ SV *sv, MAGIC *mg)
{
    dTHXc;
    MAGIC *shmg;
    SV *saggregate = S_sharedsv_from_obj(aTHX_ mg->mg_obj);
    ENTER_LOCK;
    sharedsv_elem_mg_FETCH(aTHX_ sv, mg);
    if ((shmg = mg_find(sv, PERL_MAGIC_shared_scalar)))
	sharedsv_scalar_mg_get(aTHX_ sv, shmg);
    if (SvTYPE(saggregate) == SVt_PVAV) {
	SHARED_CONTEXT;
	av_delete((AV*) saggregate, mg->mg_len, G_DISCARD);
    }
    else {
	char *key = mg->mg_ptr;
	STRLEN len = mg->mg_len;
	assert ( mg->mg_ptr != 0 );
	if (mg->mg_len == HEf_SVKEY)
	   key = SvPV((SV *) mg->mg_ptr, len);
	SHARED_CONTEXT;
	hv_delete((HV*) saggregate, key, len, G_DISCARD);
    }
    CALLER_CONTEXT;
    LEAVE_LOCK;
    return 0;
}

/* Called during cloning of PERL_MAGIC_tiedelem(p) magic in new
 * thread */

int
sharedsv_elem_mg_dup(pTHX_ MAGIC *mg, CLONE_PARAMS *param)
{
    SvREFCNT_inc(S_sharedsv_from_obj(aTHX_ mg->mg_obj));
    assert(mg->mg_flags & MGf_DUP);
    return 0;
}

MGVTBL sharedsv_elem_vtbl = {
 sharedsv_elem_mg_FETCH,	/* get */
 sharedsv_elem_mg_STORE,	/* set */
 0,				/* len */
 sharedsv_elem_mg_DELETE,	/* clear */
 0,				/* free */
 0,				/* copy */
 sharedsv_elem_mg_dup,		/* dup */
#ifdef MGf_LOCAL
 0				/* local */
#endif
};

/* ------------ PERL_MAGIC_tied(P) functions -------------- */

/* len magic for PERL_MAGIC_tied(P) */

U32
sharedsv_array_mg_FETCHSIZE(pTHX_ SV *sv, MAGIC *mg)
{
    dTHXc;
    SV *ssv = (SV *) mg->mg_ptr;
    U32 val;
    SHARED_EDIT;
    if (SvTYPE(ssv) == SVt_PVAV) {
	val = av_len((AV*) ssv);
    }
    else {
	/* not actually defined by tie API but ... */
	val = HvKEYS((HV*) ssv);
    }
    SHARED_RELEASE;
    return val;
}

/* clear magic for PERL_MAGIC_tied(P) */

int
sharedsv_array_mg_CLEAR(pTHX_ SV *sv, MAGIC *mg)
{
    dTHXc;
    SV *ssv = (SV *) mg->mg_ptr;
    SHARED_EDIT;
    if (SvTYPE(ssv) == SVt_PVAV) {
	av_clear((AV*) ssv);
    }
    else {
	hv_clear((HV*) ssv);
    }
    SHARED_RELEASE;
    return 0;
}

/* free magic for PERL_MAGIC_tied(P) */

int
sharedsv_array_mg_free(pTHX_ SV *sv, MAGIC *mg)
{
    S_sharedsv_dec(aTHX_ (SV*)mg->mg_ptr);
    return 0;
}

/*
 * copy magic for PERL_MAGIC_tied(P)
 * This is called when perl is about to access an element of
 * the array -
 */
int
sharedsv_array_mg_copy(pTHX_ SV *sv, MAGIC* mg,
		       SV *nsv, const char *name, int namlen)
{
    MAGIC *nmg = sv_magicext(nsv,mg->mg_obj,
			    toLOWER(mg->mg_type),&sharedsv_elem_vtbl,
			    name, namlen);
    nmg->mg_flags |= MGf_DUP;
    return 1;
}

/* Called during cloning of PERL_MAGIC_tied(P) magic in new thread */

int
sharedsv_array_mg_dup(pTHX_ MAGIC *mg, CLONE_PARAMS *param)
{
    SvREFCNT_inc((SV*)mg->mg_ptr);
    assert(mg->mg_flags & MGf_DUP);
    return 0;
}

MGVTBL sharedsv_array_vtbl = {
 0,				/* get */
 0,				/* set */
 sharedsv_array_mg_FETCHSIZE,	/* len */
 sharedsv_array_mg_CLEAR,	/* clear */
 sharedsv_array_mg_free,	/* free */
 sharedsv_array_mg_copy,	/* copy */
 sharedsv_array_mg_dup,		/* dup */
#ifdef MGf_LOCAL
 0				/* local */
#endif
};

=for apidoc sharedsv_unlock

Recursively unlocks a shared sv.

=cut

void
Perl_sharedsv_unlock(pTHX_ SV *ssv)
{
    user_lock *ul = S_get_userlock(aTHX_ ssv, 0);
    assert(ul);
    recursive_lock_release(aTHX_ &ul->lock);
}

=for apidoc sharedsv_lock

Recursive locks on a sharedsv.
Locks are dynamically scoped at the level of the first lock.

=cut

void
Perl_sharedsv_lock(pTHX_ SV *ssv)
{
    user_lock *ul;
    if (!ssv)
	return;
    ul = S_get_userlock(aTHX_ ssv, 1);
    recursive_lock_acquire(aTHX_ &ul->lock, __FILE__, __LINE__);
}

/* handles calls from lock() builtin via PL_lockhook */

void
Perl_sharedsv_locksv(pTHX_ SV *sv)
{
    SV *ssv;

    if(SvROK(sv))
	sv = SvRV(sv);
    ssv = Perl_sharedsv_find(aTHX_ sv);
    if(!ssv)
       croak("lock can only be used on shared values");
    Perl_sharedsv_lock(aTHX_ ssv);
}

=head1 Shared SV Functions

=for apidoc sharedsv_init

Saves a space for keeping SVs wider than an interpreter,

=cut

void
Perl_sharedsv_init(pTHX)
{
  dTHXc;
  /* This pair leaves us in shared context ... */
  PL_sharedsv_space = perl_alloc();
  perl_construct(PL_sharedsv_space);
  CALLER_CONTEXT;
  recursive_lock_init(aTHX_ &PL_sharedsv_lock);
  PL_lockhook = &Perl_sharedsv_locksv;
  PL_sharehook = &Perl_sharedsv_share;
}

MODULE = omnithreads::shared	PACKAGE = omnithreads::shared::tie

PROTOTYPES: DISABLE

void
PUSH(SV *obj, ...)
CODE:
	dTHXc;
	SV *sobj = S_sharedsv_from_obj(aTHX_ obj);
	int i;
	for(i = 1; i < items; i++) {
	    SV* tmp = newSVsv(ST(i));
	    SV *stmp;
	    ENTER_LOCK;
	    stmp = S_sharedsv_new_shared(aTHX_ tmp);
	    sharedsv_scalar_store(aTHX_ tmp, stmp);
	    SHARED_CONTEXT;
	    av_push((AV*) sobj, stmp);
	    SvREFCNT_inc(stmp);
	    SHARED_RELEASE;
	    SvREFCNT_dec(tmp);
	}

void
UNSHIFT(SV *obj, ...)
CODE:
	dTHXc;
	SV *sobj = S_sharedsv_from_obj(aTHX_ obj);
	int i;
	ENTER_LOCK;
	SHARED_CONTEXT;
	av_unshift((AV*)sobj, items - 1);
	CALLER_CONTEXT;
	for(i = 1; i < items; i++) {
	    SV *tmp = newSVsv(ST(i));
	    SV *stmp = S_sharedsv_new_shared(aTHX_ tmp);
	    sharedsv_scalar_store(aTHX_ tmp, stmp);
	    SHARED_CONTEXT;
	    av_store((AV*) sobj, i - 1, stmp);
	    SvREFCNT_inc(stmp);
	    CALLER_CONTEXT;
	    SvREFCNT_dec(tmp);
	}
	LEAVE_LOCK;

void
POP(SV *obj)
CODE:
	dTHXc;
	SV *sobj = S_sharedsv_from_obj(aTHX_ obj);
	SV* ssv;
	ENTER_LOCK;
	SHARED_CONTEXT;
	ssv = av_pop((AV*)sobj);
	CALLER_CONTEXT;
	ST(0) = sv_newmortal();
	Perl_sharedsv_associate(aTHX_ ST(0), ssv);
	SvREFCNT_dec(ssv);
	LEAVE_LOCK;
	XSRETURN(1);

void
SHIFT(SV *obj)
CODE:
	dTHXc;
	SV *sobj = S_sharedsv_from_obj(aTHX_ obj);
	SV* ssv;
	ENTER_LOCK;
	SHARED_CONTEXT;
	ssv = av_shift((AV*)sobj);
	CALLER_CONTEXT;
	ST(0) = sv_newmortal();
	Perl_sharedsv_associate(aTHX_ ST(0), ssv);
	SvREFCNT_dec(ssv);
	LEAVE_LOCK;
	XSRETURN(1);

void
EXTEND(SV *obj, IV count)
CODE:
	dTHXc;
	SV *sobj = S_sharedsv_from_obj(aTHX_ obj);
	SHARED_EDIT;
	av_extend((AV*)sobj, count);
	SHARED_RELEASE;

void
STORESIZE(SV *obj,IV count)
CODE:
	dTHXc;
	SV *sobj = S_sharedsv_from_obj(aTHX_ obj);
	SHARED_EDIT;
	av_fill((AV*) sobj, count);
	SHARED_RELEASE;




void
EXISTS(SV *obj, SV *index)
CODE:
	dTHXc;
	SV *sobj = S_sharedsv_from_obj(aTHX_ obj);
	bool exists;
	if (SvTYPE(sobj) == SVt_PVAV) {
	    SHARED_EDIT;
	    exists = av_exists((AV*) sobj, SvIV(index));
	}
	else {
	    STRLEN len;
	    char *key = SvPV(index,len);
	    SHARED_EDIT;
	    exists = hv_exists((HV*) sobj, key, len);
	}
	SHARED_RELEASE;
	ST(0) = (exists) ? &PL_sv_yes : &PL_sv_no;
	XSRETURN(1);


void
FIRSTKEY(SV *obj)
CODE:
	dTHXc;
	SV *sobj = S_sharedsv_from_obj(aTHX_ obj);
	char* key = NULL;
	I32 len = 0;
	HE* entry;
	ENTER_LOCK;
	SHARED_CONTEXT;
	hv_iterinit((HV*) sobj);
	entry = hv_iternext((HV*) sobj);
	if (entry) {
		key = hv_iterkey(entry,&len);
		CALLER_CONTEXT;
		ST(0) = sv_2mortal(newSVpv(key, len));
	} else {
	     CALLER_CONTEXT;
	     ST(0) = &PL_sv_undef;
	}
	LEAVE_LOCK;
	XSRETURN(1);

void
NEXTKEY(SV *obj, SV *oldkey)
CODE:
	dTHXc;
	SV *sobj = S_sharedsv_from_obj(aTHX_ obj);
	char* key = NULL;
	I32 len = 0;
	HE* entry;
	ENTER_LOCK;
	SHARED_CONTEXT;
	entry = hv_iternext((HV*) sobj);
	if (entry) {
		key = hv_iterkey(entry,&len);
		CALLER_CONTEXT;
		ST(0) = sv_2mortal(newSVpv(key, len));
	} else {
	     CALLER_CONTEXT;
	     ST(0) = &PL_sv_undef;
	}
	LEAVE_LOCK;
	XSRETURN(1);

MODULE = omnithreads::shared                PACKAGE = omnithreads::shared

PROTOTYPES: ENABLE

void
_id(SV *ref)
	PROTOTYPE: \[$@%]
CODE:
	SV *ssv;
	ref = SvRV(ref);
	if(SvROK(ref))
	    ref = SvRV(ref);
	if( (ssv = Perl_sharedsv_find(aTHX_ ref)) ){
	    ST(0) = sv_2mortal(newSViv(PTR2IV(ssv)));
	    XSRETURN(1);
	}
	XSRETURN_UNDEF;


void
_refcnt(SV *ref)
	PROTOTYPE: \[$@%]
CODE:
	SV *ssv;
	ref = SvRV(ref);
	if(SvROK(ref))
	    ref = SvRV(ref);
	if( (ssv = Perl_sharedsv_find(aTHX_ ref)) ) {
	    ST(0) = sv_2mortal(newSViv(SvREFCNT(ssv)));
	    XSRETURN(1);
	}
	else {
	     Perl_warn(aTHX_ "%" SVf " is not shared",ST(0));
	}
	XSRETURN_UNDEF;

SV*
share(SV *ref)
	PROTOTYPE: \[$@%]
	CODE:
	if(!SvROK(ref))
            Perl_croak(aTHX_ "Argument to share needs to be passed as ref");
	ref = SvRV(ref);
	if(SvROK(ref))
	    ref = SvRV(ref);
	Perl_sharedsv_share(aTHX_ ref);
	RETVAL = newRV(ref);
    	OUTPUT:
	RETVAL

void
lock_enabled(SV *ref)
	PROTOTYPE: \[$@%]
	CODE:
	SV *ssv;
	if(!SvROK(ref))
            Perl_croak(aTHX_ "Argument to lock needs to be passed as ref");
	ref = SvRV(ref);
	if(SvROK(ref))
	    ref = SvRV(ref);
 	ssv = Perl_sharedsv_find(aTHX_ ref);
	if(!ssv)
	   croak("lock can only be used on shared values");
	Perl_sharedsv_lock(aTHX_ ssv);

void
cond_wait_enabled(SV *ref_cond, SV *ref_lock = 0)
	PROTOTYPE: \[$@%];\[$@%]
	PREINIT:
	SV *ssv;
	perl_cond* user_condition;
	int locks;
	int same = 0;
	user_lock *ul;

	CODE:
	if (!ref_lock || ref_lock == ref_cond) same = 1;

	if(!SvROK(ref_cond))
            Perl_croak(aTHX_ "Argument to cond_wait needs to be passed as ref");
	ref_cond = SvRV(ref_cond);
	if(SvROK(ref_cond))
	    ref_cond = SvRV(ref_cond);
	ssv = Perl_sharedsv_find(aTHX_ ref_cond);
	if(!ssv)
	    croak("cond_wait can only be used on shared values");
	ul = S_get_userlock(aTHX_ ssv, 1);

	user_condition = &ul->user_cond;
	if (! same) {
	    if (!SvROK(ref_lock))
	        Perl_croak(aTHX_ "cond_wait lock needs to be passed as ref");
	    ref_lock = SvRV(ref_lock);
	    if (SvROK(ref_lock)) ref_lock = SvRV(ref_lock);
	    ssv = Perl_sharedsv_find(aTHX_ ref_lock);
	    if (!ssv)
	        croak("cond_wait lock must be a shared value");
	    ul = S_get_userlock(aTHX_ ssv, 1);
	}
	if(ul->lock.owner != aTHX)
	    croak("You need a lock before you can cond_wait");
	/* since we are releasing the lock here we need to tell other
	people that is ok to go ahead and use it */
        PUTBACK;
        {
	    UV token = unlock_interpreter(aTHX);

	    /* Stealing the members of the lock object worries me - NI-S */
	    MUTEX_LOCK(&ul->lock.mutex);
	    ul->lock.owner = NULL;
	    locks = ul->lock.locks;
	    ul->lock.locks = 0;
	    
	    COND_SIGNAL(&ul->lock.cond);
	    COND_WAIT(user_condition, &ul->lock.mutex);
	    while(ul->lock.owner != NULL) {
		/* OK -- must reacquire the lock */
		COND_WAIT(&ul->lock.cond, &ul->lock.mutex);
	    }
	    ul->lock.owner = aTHX;
	    ul->lock.locks = locks;
	    MUTEX_UNLOCK(&ul->lock.mutex);

	    relock_interpreter(aTHX_ token);
	}
        SPAGAIN;

int
cond_timedwait_enabled(SV *ref_cond, double abs, SV *ref_lock = 0)
	PROTOTYPE: \[$@%]$;\[$@%]
	PREINIT:
	SV *ssv;
	perl_cond* user_condition;
	int locks;
	int same = 0;
	user_lock *ul;

	CODE:
	if (!ref_lock || ref_cond == ref_lock) same = 1;

	if(!SvROK(ref_cond))
	    Perl_croak(aTHX_ "Argument to cond_timedwait needs to be passed as ref");
	ref_cond = SvRV(ref_cond);
	if(SvROK(ref_cond))
	    ref_cond = SvRV(ref_cond);
	ssv = Perl_sharedsv_find(aTHX_ ref_cond);
	if(!ssv)
	    croak("cond_timedwait can only be used on shared values");
	ul = S_get_userlock(aTHX_ ssv, 1);
    
	user_condition = &ul->user_cond;
	if (! same) {
	    if (!SvROK(ref_lock))
	        Perl_croak(aTHX_ "cond_timedwait lock needs to be passed as ref");
	    ref_lock = SvRV(ref_lock);
	    if (SvROK(ref_lock)) ref_lock = SvRV(ref_lock);
	    ssv = Perl_sharedsv_find(aTHX_ ref_lock);
	    if (!ssv)
	        croak("cond_timedwait lock must be a shared value");
	    ul = S_get_userlock(aTHX_ ssv, 1);
	}
	if(ul->lock.owner != aTHX)
	    croak("You need a lock before you can cond_wait");

        PUTBACK;
        {
	    UV token = unlock_interpreter(aTHX);

	    MUTEX_LOCK(&ul->lock.mutex);
	    ul->lock.owner = NULL;
	    locks = ul->lock.locks;
	    ul->lock.locks = 0;
	    /* since we are releasing the lock here we need to tell other
	       people that is ok to go ahead and use it */
	    COND_SIGNAL(&ul->lock.cond);
	    RETVAL = Perl_sharedsv_cond_timedwait(user_condition,
						  &ul->lock.mutex, abs);
	    while (ul->lock.owner != NULL) {
		/* OK -- must reacquire the lock... */
		COND_WAIT(&ul->lock.cond, &ul->lock.mutex);
	    }
	    ul->lock.owner = aTHX;
	    ul->lock.locks = locks;
	    MUTEX_UNLOCK(&ul->lock.mutex);
	    
	    relock_interpreter(aTHX_ token);
	}
        SPAGAIN;

	if (RETVAL == 0)
            XSRETURN_UNDEF;
	OUTPUT:
	RETVAL

void
cond_signal_enabled(SV *ref)
	PROTOTYPE: \[$@%]
	CODE:
	SV *ssv;
	user_lock *ul;

	if(!SvROK(ref))
            Perl_croak(aTHX_ "Argument to cond_signal needs to be passed as ref");
	ref = SvRV(ref);
	if(SvROK(ref))
	    ref = SvRV(ref);
	ssv = Perl_sharedsv_find(aTHX_ ref);
	if(!ssv)
	    croak("cond_signal can only be used on shared values");
	ul = S_get_userlock(aTHX_ ssv, 1);
	if (ckWARN(WARN_THREADS) && ul->lock.owner != aTHX)
	    Perl_warner(aTHX_ packWARN(WARN_THREADS),
			    "cond_signal() called on unlocked variable");
	COND_SIGNAL(&ul->user_cond);

void
cond_broadcast_enabled(SV *ref)
	PROTOTYPE: \[$@%]
	CODE:
	SV *ssv;
	user_lock *ul;

	if(!SvROK(ref))
            Perl_croak(aTHX_ "Argument to cond_broadcast needs to be passed as ref");
	ref = SvRV(ref);
	if(SvROK(ref))
	    ref = SvRV(ref);
	ssv = Perl_sharedsv_find(aTHX_ ref);
	if(!ssv)
	    croak("cond_broadcast can only be used on shared values");
	ul = S_get_userlock(aTHX_ ssv, 1);
	if (ckWARN(WARN_THREADS) && ul->lock.owner != aTHX)
	    Perl_warner(aTHX_ packWARN(WARN_THREADS),
			    "cond_broadcast() called on unlocked variable");
	COND_BROADCAST(&ul->user_cond);


SV*
bless(SV* ref, ...);
	PROTOTYPE: $;$
	CODE:
        {
	  HV* stash;
	  SV *ssv;
	  if (items == 1)
	    stash = CopSTASH(PL_curcop);
	  else {
	    SV* classname = ST(1);
	    STRLEN len;
	    char *ptr;
	    
	    if (classname && !SvGMAGICAL(classname) &&
			!SvAMAGIC(classname) && SvROK(classname))
	      Perl_croak(aTHX_ "Attempt to bless into a reference");
	    ptr = SvPV(classname,len);
	    if (ckWARN(WARN_MISC) && len == 0)
	      Perl_warner(aTHX_ packWARN(WARN_MISC),
			  "Explicit blessing to '' (assuming package main)");
	    stash = gv_stashpvn(ptr, len, TRUE);
	  }
	  SvREFCNT_inc(ref);
	  (void)sv_bless(ref, stash);
	  RETVAL = ref;
	  ssv = Perl_sharedsv_find(aTHX_ ref);
	  if(ssv) {
	    dTHXc;
	    ENTER_LOCK;
	    SHARED_CONTEXT;
	    {
	      SV* fake_stash = newSVpv(HvNAME_get(stash),0);
	      (void)sv_bless(ssv,(HV*)fake_stash);
	    }
	    CALLER_CONTEXT;
	    LEAVE_LOCK;
	  }
	}
    	OUTPUT:
	RETVAL		

BOOT:
{
    int count;

    Perl_sharedsv_init(aTHX);

    ENTER;
    SAVETMPS;
    
    PUSHMARK(SP);
    count = call_pv("CORBA::omniORB::_entry_lock_hooks", G_ARRAY | G_EVAL);
    SPAGAIN;
    if (count == 2) {
	relock_interpreter = DPTR2FPTR(void (*)(pTHX, UV token), POPu);
	unlock_interpreter = DPTR2FPTR(UV (*)(pTHX), POPu);
	
	PUTBACK;
    }
    else {
	warn("Couldn't obtain CORBA::omniORB entry lock hooks");
    }

    FREETMPS;
    LEAVE;
}
