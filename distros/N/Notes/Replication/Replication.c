/*
 * This file was generated automatically by xsubpp version 1.9508 from the 
 * contents of Replication.xs. Do not edit this file, edit Replication.xs instead.
 *
 *	ANY CHANGES MADE HERE WILL BE LOST! 
 *
 */

#line 1 "Replication.xs"
#define BLOCK Perl_BLOCK

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "notesreplication.h"

#line 19 "Replication.c"
XS(XS_Notes__Database_replication_info)
{
    dXSARGS;
    dXSI32;
    if (items != 1)
       Perl_croak(aTHX_ "Usage: %s(db)", GvNAME(CvGV(cv)));
    SP -= items;
    {
	LN_Database *	db;
#line 18 "Replication.xs"
      d_LN_XSVARS;
      STATUS          ln_rc;
      DBREPLICAINFO * ri;
#line 33 "Replication.c"

   /* NOTE: ALL O_LN_OBJECT C-types MUST be typedef'ed to SV  */
   if ( sv_isobject( ST(0) ) && ( SvTYPE( SvRV( ST(0) ) ) == SVt_PVMG) ) {
      db = (LN_Database *) ST(0);
   } else {
     warn( "Notes::Database::replication_info() -- db is not a blessed SV reference" );
     XSRETURN_UNDEF;
   }   ;
#line 24 "Replication.xs"
   	  Newz(1, ri, 1, DBREPLICAINFO);
      ln_rc = NSFDbReplicaInfoGet( LN_DB_HANDLE(NOTESDATABASE,db), ri );
      LN_PUSH_NEW_OBJ( "Notes::Replication", db );
      LN_INIT_OBJ_STRUCT(NOTESREPLICATION, ln_obj);
      //printf("SETTING DBHANDLE = %ld\n", LN_DB_HANDLE(NOTESDATABASE,db));
      LN_SET_DB_HANDLE(NOTESREPLICATION, ln_obj, LN_DB_HANDLE(NOTESDATABASE,db));
      //printf("STORED DBHANDLE = %ld\n", LN_DB_HANDLE(NOTESREPLICATION,ln_obj));
      //printf("SETTING DBREPLICAINFO = %ld\n", ri);
      LN_SET_DB_REPL_INFO(NOTESREPLICATION, ln_obj, ri);
      //printf("STORED DBREPLICAINFO = %ld\n", LN_DB_REPL_INFO(NOTESREPLICATION,ln_obj));
      LN_SET_OK      ( ln_obj );
      XSRETURN       ( 1 );
#line 55 "Replication.c"
	PUTBACK;
	return;
    }
}

XS(XS_Notes__Replication_DESTROY)
{
    dXSARGS;
    if (items != 1)
	Perl_croak(aTHX_ "Usage: Notes::Replication::DESTROY(repl)");
    SP -= items;
    {
	LN_Replication *	repl;

   /* NOTE: ALL O_LN_OBJECT C-types MUST be typedef'ed to SV  */
   if ( sv_isobject( ST(0) ) && ( SvTYPE( SvRV( ST(0) ) ) == SVt_PVMG) ) {
      repl = (LN_Replication *) ST(0);
   } else {
     warn( "Notes::Replication::DESTROY() -- repl is not a blessed SV reference" );
     XSRETURN_UNDEF;
   }   ;
#line 44 "Replication.xs"
   	  Safefree( LN_DB_REPL_INFO(NOTESREPLICATION, repl) );
   	  LN_FREE_OBJ_STRUCT(NOTESREPLICATION, repl);
  	  //LN_SET_PARENT_IVX( repl, ln_rc );
      XSRETURN( 0 );
#line 82 "Replication.c"
	PUTBACK;
	return;
    }
}

XS(XS_Notes__Replication_is_browsable)
{
    dXSARGS;
    dXSI32;
    if (items != 1)
       Perl_croak(aTHX_ "Usage: %s(repl)", GvNAME(CvGV(cv)));
    SP -= items;
    {
	LN_Replication *	repl;
#line 54 "Replication.xs"
      int             ln_query;
      DBREPLICAINFO * ri;
#line 100 "Replication.c"

   /* NOTE: ALL O_LN_OBJECT C-types MUST be typedef'ed to SV  */
   if ( sv_isobject( ST(0) ) && ( SvTYPE( SvRV( ST(0) ) ) == SVt_PVMG) ) {
      repl = (LN_Replication *) ST(0);
   } else {
     warn( "Notes::Replication::is_browsable() -- repl is not a blessed SV reference" );
     XSRETURN_UNDEF;
   }   ;
#line 66 "Replication.xs"
      if ( LN_IS_OK(repl) )
      {
		 ri = LN_DB_REPL_INFO(NOTESREPLICATION, repl);
         switch( ix )
         {
            case 0:   ln_query = !(ri->Flags & REPLFLG_DO_NOT_BROWSE);
                      break;
            case 1:   ln_query = !(ri->Flags & REPLFLG_DO_NOT_CATALOG);
                      break;
                      break;
            default:  XSRETURN_NOT_OK;
            		  break;
         }
         if (ln_query)
         {
			 XSRETURN_YES;
		 }
		 else
		 {
			 XSRETURN_NO;
		 }
       }
       else
       {
		   DEBUG(("Notes::Database object is not OK at line %d", __LINE__));
		   XSRETURN_NOT_OK;
	   }
#line 137 "Replication.c"
	PUTBACK;
	return;
    }
}

XS(XS_Notes__Replication_set_browsable)
{
    dXSARGS;
    dXSI32;
    if (items != 1)
       Perl_croak(aTHX_ "Usage: %s(repl)", GvNAME(CvGV(cv)));
    SP -= items;
    {
	LN_Replication *	repl;
#line 99 "Replication.xs"
      DBREPLICAINFO  * ri;
#line 154 "Replication.c"

   /* NOTE: ALL O_LN_OBJECT C-types MUST be typedef'ed to SV  */
   if ( sv_isobject( ST(0) ) && ( SvTYPE( SvRV( ST(0) ) ) == SVt_PVMG) ) {
      repl = (LN_Replication *) ST(0);
   } else {
     warn( "Notes::Replication::set_browsable() -- repl is not a blessed SV reference" );
     XSRETURN_UNDEF;
   }   ;
#line 118 "Replication.xs"
      if ( LN_IS_OK(repl) )
      {
		 ri = LN_DB_REPL_INFO(NOTESREPLICATION, repl);
         switch( ix )
         {
            case 0:  ri->Flags &= ~REPLFLG_DO_NOT_BROWSE;
            break;
            case 1:  ri->Flags |=  REPLFLG_DO_NOT_BROWSE;
            break;
            case 2:  ri->Flags &= ~REPLFLG_DO_NOT_CATALOG;
            break;
            case 3:  ri->Flags |=  REPLFLG_DO_NOT_CATALOG;
            break;
            default: XSRETURN(0);
            break;
         }
         NSFDbReplicaInfoSet(LN_DB_HANDLE(NOTESREPLICATION,repl), ri );
      }
      XSRETURN_OK;
#line 183 "Replication.c"
	PUTBACK;
	return;
    }
}

XS(XS_Notes__Replication_cutoff_interval_days)
{
    dXSARGS;
    if (items != 1)
	Perl_croak(aTHX_ "Usage: Notes::Replication::cutoff_interval_days(repl)");
    SP -= items;
    {
	LN_Replication *	repl;
#line 143 "Replication.xs"
      DBREPLICAINFO  * ri;
#line 199 "Replication.c"

   /* NOTE: ALL O_LN_OBJECT C-types MUST be typedef'ed to SV  */
   if ( sv_isobject( ST(0) ) && ( SvTYPE( SvRV( ST(0) ) ) == SVt_PVMG) ) {
      repl = (LN_Replication *) ST(0);
   } else {
     warn( "Notes::Replication::cutoff_interval_days() -- repl is not a blessed SV reference" );
     XSRETURN_UNDEF;
   }   ;
#line 145 "Replication.xs"
      if (LN_IS_OK(repl))
      {
		  ri = LN_DB_REPL_INFO(NOTESREPLICATION, repl);
		  XSRETURN_IV( (IV) ri->CutoffInterval );
	  }
      else
      {
		  DEBUG(("Notes::Database object is not OK at line %d", __LINE__));
	  	  XSRETURN_NOT_OK;
	  }
#line 219 "Replication.c"
	PUTBACK;
	return;
    }
}

XS(XS_Notes__Replication_set_cutoff_interval_days)
{
    dXSARGS;
    if (items != 2)
	Perl_croak(aTHX_ "Usage: Notes::Replication::set_cutoff_interval_days(repl, ln_cutoff_interval_days)");
    SP -= items;
    {
	LN_Replication *	repl;
	IV	ln_cutoff_interval_days = (IV)SvIV(ST(1));
#line 162 "Replication.xs"
      DBREPLICAINFO  * ri;
#line 236 "Replication.c"

   /* NOTE: ALL O_LN_OBJECT C-types MUST be typedef'ed to SV  */
   if ( sv_isobject( ST(0) ) && ( SvTYPE( SvRV( ST(0) ) ) == SVt_PVMG) ) {
      repl = (LN_Replication *) ST(0);
   } else {
     warn( "Notes::Replication::set_cutoff_interval_days() -- repl is not a blessed SV reference" );
     XSRETURN_UNDEF;
   }   ;
#line 164 "Replication.xs"
      if ( LN_IS_OK(repl) )
      {
		 ri = LN_DB_REPL_INFO(NOTESREPLICATION, repl);
         ri->CutoffInterval = (WORD) ln_cutoff_interval_days;
         NSFDbReplicaInfoSet(LN_DB_HANDLE(NOTESREPLICATION,repl), ri );
      }
      XSRETURN_OK;
#line 253 "Replication.c"
	PUTBACK;
	return;
    }
}

XS(XS_Notes__Replication_gethistory)
{
    dXSARGS;
    if (items != 1)
	Perl_croak(aTHX_ "Usage: Notes::Replication::gethistory(repl)");
    SP -= items;
    {
	LN_Replication *	repl;
#line 176 "Replication.xs"
      STATUS 	         error = NOERROR;				 /* error code from API calls */
      HANDLE             hReplHist;
	  REPLHIST_SUMMARY   ReplHist;
	  REPLHIST_SUMMARY * pReplHist;
	  char               szTimedate[MAXALPHATIMEDATE + 1];
	  WORD               wLen;
	  DWORD              dwNumEntries, i;
	  char 		       * pServerName;                    /* terminating NULL not included */
	  char               szServerName[MAXUSERNAME + 1];
	  char             * pFileName;                      /* includes terminating NULL */
	  char               szDirection[10];                /* NEVER, SEND, RECEIVE */
#line 279 "Replication.c"

   /* NOTE: ALL O_LN_OBJECT C-types MUST be typedef'ed to SV  */
   if ( sv_isobject( ST(0) ) && ( SvTYPE( SvRV( ST(0) ) ) == SVt_PVMG) ) {
      repl = (LN_Replication *) ST(0);
   } else {
     warn( "Notes::Replication::gethistory() -- repl is not a blessed SV reference" );
     XSRETURN_UNDEF;
   }   ;
#line 188 "Replication.xs"
	  /* Get the Replication History Summary */
	  error = NSFDbGetReplHistorySummary (LN_DB_HANDLE(NOTESREPLICATION,repl),
	                                      0,
	                                      &hReplHist,
	                                      &dwNumEntries);
	  if (error)
	  {
	      LN_SET_IVX(repl, error);
	      DEBUG(("Notes::Replication object returning error %d at line %d", error, __LINE__));
	      XSRETURN_NOT_OK;
      }
	  /* Obtain a pointer to the first member of the Replication History Summary array */
      pReplHist = OSLock (REPLHIST_SUMMARY, hReplHist);
      for (i = 0; i < dwNumEntries; i++)
      {
	  	ReplHist = pReplHist[i];
  		error = ConvertTIMEDATEToText (NULL, NULL, &(ReplHist.ReplicationTime),
  		                               szTimedate, MAXALPHATIMEDATE, &wLen);
  		if (error)
  		{
			DEBUG(("Notes::Replication object returning error %d at line %d", error, __LINE__));
  			OSUnlock (hReplHist);
  			OSMemFree (hReplHist);
  			LN_SET_IVX(repl, error);
	        XSRETURN_NOT_OK;
  		}
  		szTimedate[wLen] = '\0';
  		if (ReplHist.Direction == DIRECTION_NEVER)
    		strcpy (szDirection, "NEVER");
  		else if (ReplHist.Direction == DIRECTION_SEND)
  			strcpy (szDirection, "SEND");
  		else if (ReplHist.Direction == DIRECTION_RECEIVE)
  			strcpy (szDirection, "RECEIVE");
  		else
  			strcpy (szDirection, "");

  		pServerName = NSFGetSummaryServerNamePtr (pReplHist, i);
  		strncpy (szServerName, pServerName, ReplHist.ServerNameLength);
  		szServerName[ReplHist.ServerNameLength] = '\0';

  		/* FileName will be NULL terminated */
  		pFileName = NSFGetSummaryFileNamePtr (pReplHist, i);

  		/* Push entry on the stack as a new SV */
  		XPUSHs( sv_2mortal( newSVpvf( "%s,%s,%s,%s",
  		        szTimedate, szServerName, pFileName, szDirection)));
	  }
	  OSUnlock  (hReplHist);
	  OSMemFree (hReplHist);
#line 338 "Replication.c"
	PUTBACK;
	return;
    }
}

XS(XS_Notes__Replication_clearhistory)
{
    dXSARGS;
    if (items != 1)
	Perl_croak(aTHX_ "Usage: Notes::Replication::clearhistory(repl)");
    SP -= items;
    {
	LN_Replication *	repl;
#line 243 "Replication.xs"
      STATUS error = NOERROR;
#line 354 "Replication.c"

   /* NOTE: ALL O_LN_OBJECT C-types MUST be typedef'ed to SV  */
   if ( sv_isobject( ST(0) ) && ( SvTYPE( SvRV( ST(0) ) ) == SVt_PVMG) ) {
      repl = (LN_Replication *) ST(0);
   } else {
     warn( "Notes::Replication::clearhistory() -- repl is not a blessed SV reference" );
     XSRETURN_UNDEF;
   }   ;
#line 245 "Replication.xs"
      if ( LN_IS_OK(repl) )
	  {
	      error = NSFDbClearReplHistory(LN_DB_HANDLE(NOTESREPLICATION,repl), 0);
      }
      XSRETURN_OK;
#line 369 "Replication.c"
	PUTBACK;
	return;
    }
}

#ifdef __cplusplus
extern "C"
#endif
XS(boot_Notes__Replication)
{
    dXSARGS;
    char* file = __FILE__;

    XS_VERSION_BOOTCHECK ;

    {
        CV * cv ;

        cv = newXS("Notes::Database::replication_info", XS_Notes__Database_replication_info, file);
        XSANY.any_i32 = 0 ;
        cv = newXS("Notes::Database::ReplicationInfo", XS_Notes__Database_replication_info, file);
        XSANY.any_i32 = 0 ;
        newXS("Notes::Replication::DESTROY", XS_Notes__Replication_DESTROY, file);
        cv = newXS("Notes::Replication::is_browsable", XS_Notes__Replication_is_browsable, file);
        XSANY.any_i32 = 0 ;
        cv = newXS("Notes::Replication::is_receiving_deletions", XS_Notes__Replication_is_browsable, file);
        XSANY.any_i32 = 4 ;
        cv = newXS("Notes::Replication::is_using_cutoff_interval", XS_Notes__Replication_is_browsable, file);
        XSANY.any_i32 = 6 ;
        cv = newXS("Notes::Replication::is_replicating", XS_Notes__Replication_is_browsable, file);
        XSANY.any_i32 = 2 ;
        cv = newXS("Notes::Replication::is_running_scheduled_agents", XS_Notes__Replication_is_browsable, file);
        XSANY.any_i32 = 7 ;
        cv = newXS("Notes::Replication::is_catalogable", XS_Notes__Replication_is_browsable, file);
        XSANY.any_i32 = 1 ;
        cv = newXS("Notes::Replication::is_sending_deletions", XS_Notes__Replication_is_browsable, file);
        XSANY.any_i32 = 5 ;
        cv = newXS("Notes::Replication::is_never_replicating", XS_Notes__Replication_is_browsable, file);
        XSANY.any_i32 = 3 ;
        cv = newXS("Notes::Replication::set_browsable", XS_Notes__Replication_set_browsable, file);
        XSANY.any_i32 = 0 ;
        cv = newXS("Notes::Replication::keep_docs_not_in_cutoff_interval", XS_Notes__Replication_set_browsable, file);
        XSANY.any_i32 = 12 ;
        cv = newXS("Notes::Replication::do_not_send_deletions", XS_Notes__Replication_set_browsable, file);
        XSANY.any_i32 = 11 ;
        cv = newXS("Notes::Replication::set_not_browsable", XS_Notes__Replication_set_browsable, file);
        XSANY.any_i32 = 1 ;
        cv = newXS("Notes::Replication::send_deletions", XS_Notes__Replication_set_browsable, file);
        XSANY.any_i32 = 10 ;
        cv = newXS("Notes::Replication::disable_replication", XS_Notes__Replication_set_browsable, file);
        XSANY.any_i32 = 4 ;
        cv = newXS("Notes::Replication::run_scheduled_agents", XS_Notes__Replication_set_browsable, file);
        XSANY.any_i32 = 14 ;
        cv = newXS("Notes::Replication::delete_docs_not_in_cutoff_interval", XS_Notes__Replication_set_browsable, file);
        XSANY.any_i32 = 13 ;
        cv = newXS("Notes::Replication::enable_replication", XS_Notes__Replication_set_browsable, file);
        XSANY.any_i32 = 5 ;
        cv = newXS("Notes::Replication::do_not_run_scheduled_agents", XS_Notes__Replication_set_browsable, file);
        XSANY.any_i32 = 15 ;
        cv = newXS("Notes::Replication::set_catalogable", XS_Notes__Replication_set_browsable, file);
        XSANY.any_i32 = 2 ;
        cv = newXS("Notes::Replication::set_not_catalogable", XS_Notes__Replication_set_browsable, file);
        XSANY.any_i32 = 3 ;
        cv = newXS("Notes::Replication::never_replicate_again", XS_Notes__Replication_set_browsable, file);
        XSANY.any_i32 = 6 ;
        cv = newXS("Notes::Replication::receive_deletions", XS_Notes__Replication_set_browsable, file);
        XSANY.any_i32 = 8 ;
        cv = newXS("Notes::Replication::replicate_again", XS_Notes__Replication_set_browsable, file);
        XSANY.any_i32 = 7 ;
        cv = newXS("Notes::Replication::do_not_receive_deletions", XS_Notes__Replication_set_browsable, file);
        XSANY.any_i32 = 9 ;
        newXS("Notes::Replication::cutoff_interval_days", XS_Notes__Replication_cutoff_interval_days, file);
        newXS("Notes::Replication::set_cutoff_interval_days", XS_Notes__Replication_set_cutoff_interval_days, file);
        newXS("Notes::Replication::gethistory", XS_Notes__Replication_gethistory, file);
        newXS("Notes::Replication::clearhistory", XS_Notes__Replication_clearhistory, file);
    }
    XSRETURN_YES;
}

