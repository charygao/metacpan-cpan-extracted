# This Makefile is for the PerlIO::via::PinyinConvert extension to perl.
#
# It was generated automatically by MakeMaker version
# 6.05 (Revision: 1.69) from the contents of
# Makefile.PL. Don't edit this file, edit Makefile.PL instead.
#
#       ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker ARGV: ()
#
#   MakeMaker Parameters:

#     ABSTRACT_FROM => q[PinyinConvert.pm]
#     AUTHOR => q[xern <xern@cpan.org>]
#     NAME => q[PerlIO::via::PinyinConvert]
#     PREREQ_PM => {  }
#     VERSION_FROM => q[PinyinConvert.pm]

# --- MakeMaker post_initialize section:


# --- MakeMaker const_config section:

# These definitions are from config.sh (via /usr/local/lib/perl5/5.8.0/i686-linux-thread-multi-64all-ld/Config.pm)

# They may have been overridden via Makefile.PL or on the command line
AR = ar
CC = cc
CCCDLFLAGS = -fpic
CCDLFLAGS = -rdynamic
DLEXT = so
DLSRC = dl_dlopen.xs
LD = cc
LDDLFLAGS = -shared -L/usr/local/lib
LDFLAGS =  -L/usr/local/lib
LIBC = /lib/libc-2.2.4.so
LIB_EXT = .a
OBJ_EXT = .o
OSNAME = linux
OSVERS = 2.4.7-10
RANLIB = :
SO = so
EXE_EXT = 
FULL_AR = /usr/bin/ar


# --- MakeMaker constants section:
AR_STATIC_ARGS = cr
NAME = PerlIO::via::PinyinConvert
DISTNAME = PerlIO-via-PinyinConvert
NAME_SYM = PerlIO_via_PinyinConvert
VERSION = 0.01
VERSION_SYM = 0_01
XS_VERSION = 0.01
INST_ARCHLIB = ../blib/arch
INST_SCRIPT = ../blib/script
INST_BIN = ../blib/bin
INST_LIB = ../blib/lib
INSTALLDIRS = site
PREFIX = /usr/local
SITEPREFIX = /usr/local
VENDORPREFIX = 
INSTALLPRIVLIB = /usr/local/lib/perl5/5.8.0
INSTALLSITELIB = /usr/local/lib/perl5/site_perl/5.8.0
INSTALLVENDORLIB = 
INSTALLARCHLIB = /usr/local/lib/perl5/5.8.0/i686-linux-thread-multi-64all-ld
INSTALLSITEARCH = /usr/local/lib/perl5/site_perl/5.8.0/i686-linux-thread-multi-64all-ld
INSTALLVENDORARCH = 
INSTALLBIN = /usr/local/bin
INSTALLSITEBIN = /usr/local/bin
INSTALLVENDORBIN = 
INSTALLSCRIPT = /usr/local/bin
PERL_LIB = /usr/local/lib/perl5/5.8.0
PERL_ARCHLIB = /usr/local/lib/perl5/5.8.0/i686-linux-thread-multi-64all-ld
VENDORLIBEXP = 
SITELIBEXP = /usr/local/lib/perl5/site_perl/5.8.0
SITEARCHEXP = /usr/local/lib/perl5/site_perl/5.8.0/i686-linux-thread-multi-64all-ld
VENDORARCHEXP = 
LIBPERL_A = libperl.a
FIRST_MAKEFILE = Makefile
MAKE_APERL_FILE = Makefile.aperl
PERLMAINCC = $(CC)
PERL_INC = /usr/local/lib/perl5/5.8.0/i686-linux-thread-multi-64all-ld/CORE
PERL = /usr/local/bin/perl
FULLPERL = /usr/local/bin/perl
PERLRUN = $(PERL)
FULLPERLRUN = $(FULLPERL)
PERLRUNINST = $(PERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
FULLPERLRUNINST = $(FULLPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
ABSPERL = $(PERL)
ABSPERLRUN = $(ABSPERL)
ABSPERLRUNINST = $(ABSPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
FULL_AR = /usr/bin/ar
PERL_CORE = 0
NOOP = $(SHELL) -c true
NOECHO = @

VERSION_MACRO = VERSION
DEFINE_VERSION = -D$(VERSION_MACRO)=\"$(VERSION)\"
XS_VERSION_MACRO = XS_VERSION
XS_DEFINE_VERSION = -D$(XS_VERSION_MACRO)=\"$(XS_VERSION)\"
PERL_MALLOC_DEF = -DPERL_EXTMALLOC_DEF -Dmalloc=Perl_malloc -Dfree=Perl_mfree -Drealloc=Perl_realloc -Dcalloc=Perl_calloc

MAKEMAKER = /usr/local/lib/perl5/5.8.0/ExtUtils/MakeMaker.pm
MM_VERSION = 6.05

# FULLEXT = Pathname for extension directory (eg Foo/Bar/Oracle).
# BASEEXT = Basename part of FULLEXT. May be just equal FULLEXT. (eg Oracle)
# PARENT_NAME = NAME without BASEEXT and no trailing :: (eg Foo::Bar)
# DLBASE  = Basename part of dynamic library. May be just equal BASEEXT.
FULLEXT = PerlIO/via/PinyinConvert
BASEEXT = PinyinConvert
PARENT_NAME = PerlIO::via
DLBASE = $(BASEEXT)
VERSION_FROM = PinyinConvert.pm
OBJECT = 
LDFROM = $(OBJECT)
LINKTYPE = dynamic

# Handy lists of source code files:
XS_FILES= 
C_FILES = 
O_FILES = 
H_FILES = 
MAN1PODS = 
MAN3PODS = PinyinConvert.pm
INST_MAN1DIR = ../blib/man1
MAN1EXT = 1
INSTALLMAN1DIR = /usr/local/share/man/man1
INSTALLSITEMAN1DIR = /usr/local/man/man1
INST_MAN3DIR = ../blib/man3
MAN3EXT = 3
INSTALLMAN3DIR = /usr/local/share/man/man3
INSTALLSITEMAN3DIR = /usr/local/man/man3
PERM_RW = 644
PERM_RWX = 755

# work around a famous dec-osf make(1) feature(?):
makemakerdflt: all

.SUFFIXES: .xs .c .C .cpp .i .s .cxx .cc $(OBJ_EXT)

# Nick wanted to get rid of .PRECIOUS. I don't remember why. I seem to recall, that
# some make implementations will delete the Makefile when we rebuild it. Because
# we call false(1) when we rebuild it. So make(1) is not completely wrong when it
# does so. Our milage may vary.
# .PRECIOUS: Makefile    # seems to be not necessary anymore

.PHONY: all config static dynamic test linkext manifest

# Where is the Config information that we are using/depend on
CONFIGDEP = $(PERL_ARCHLIB)/Config.pm $(PERL_INC)/config.h

# Where to put things:
INST_LIBDIR      = $(INST_LIB)/PerlIO/via
INST_ARCHLIBDIR  = $(INST_ARCHLIB)/PerlIO/via

INST_AUTODIR     = $(INST_LIB)/auto/$(FULLEXT)
INST_ARCHAUTODIR = $(INST_ARCHLIB)/auto/$(FULLEXT)

INST_STATIC  =
INST_DYNAMIC =
INST_BOOT    =

EXPORT_LIST = 

PERL_ARCHIVE = 

PERL_ARCHIVE_AFTER = 

TO_INST_PM = PinyinConvert.pm

PM_TO_BLIB = PinyinConvert.pm \
	../blib/lib/PerlIO/via/PinyinConvert.pm


# --- MakeMaker tool_autosplit section:
# Usage: $(AUTOSPLITFILE) FileToSplit AutoDirToSplitInto
AUTOSPLITFILE = $(PERLRUN) -e 'use AutoSplit;  autosplit($$ARGV[0], $$ARGV[1], 0, 1, 1) ;'



# --- MakeMaker tool_xsubpp section:


# --- MakeMaker tools_other section:

SHELL = /bin/sh
CHMOD = chmod
CP = cp
LD = cc
MV = mv
NOOP = $(SHELL) -c true
RM_F = rm -f
RM_RF = rm -rf
TEST_F = test -f
TOUCH = touch
UMASK_NULL = umask 0
DEV_NULL = > /dev/null 2>&1

# The following is a portable way to say mkdir -p
# To see which directories are created, change the if 0 to if 1
MKPATH = $(PERLRUN) "-MExtUtils::Command" -e mkpath

# This helps us to minimize the effect of the .exists files A yet
# better solution would be to have a stable file in the perl
# distribution with a timestamp of zero. But this solution doesn't
# need any changes to the core distribution and works with older perls
EQUALIZE_TIMESTAMP = $(PERLRUN) "-MExtUtils::Command" -e eqtime


# --- MakeMaker dist section skipped.

# --- MakeMaker macro section:


# --- MakeMaker depend section:


# --- MakeMaker cflags section:


# --- MakeMaker const_loadlibs section:


# --- MakeMaker const_cccmd section:


# --- MakeMaker post_constants section:


# --- MakeMaker pasthru section:

PASTHRU = LIB="$(LIB)"\
	LIBPERL_A="$(LIBPERL_A)"\
	LINKTYPE="$(LINKTYPE)"\
	PREFIX="$(PREFIX)"\
	OPTIMIZE="$(OPTIMIZE)"\
	PASTHRU_DEFINE="$(PASTHRU_DEFINE)"\
	PASTHRU_INC="$(PASTHRU_INC)"


# --- MakeMaker c_o section:


# --- MakeMaker xs_c section:


# --- MakeMaker xs_o section:


# --- MakeMaker top_targets section:

all :: pure_all manifypods
	@$(NOOP)

pure_all :: config pm_to_blib subdirs linkext
	@$(NOOP)

subdirs :: $(MYEXTLIB)
	@$(NOOP)

config :: Makefile $(INST_LIBDIR)/.exists
	@$(NOOP)

config :: $(INST_ARCHAUTODIR)/.exists
	@$(NOOP)

config :: $(INST_AUTODIR)/.exists
	@$(NOOP)

$(INST_AUTODIR)/.exists :: /usr/local/lib/perl5/5.8.0/i686-linux-thread-multi-64all-ld/CORE/perl.h
	@$(MKPATH) $(INST_AUTODIR)
	@$(EQUALIZE_TIMESTAMP) /usr/local/lib/perl5/5.8.0/i686-linux-thread-multi-64all-ld/CORE/perl.h $(INST_AUTODIR)/.exists

	-@$(CHMOD) $(PERM_RWX) $(INST_AUTODIR)

$(INST_LIBDIR)/.exists :: /usr/local/lib/perl5/5.8.0/i686-linux-thread-multi-64all-ld/CORE/perl.h
	@$(MKPATH) $(INST_LIBDIR)
	@$(EQUALIZE_TIMESTAMP) /usr/local/lib/perl5/5.8.0/i686-linux-thread-multi-64all-ld/CORE/perl.h $(INST_LIBDIR)/.exists

	-@$(CHMOD) $(PERM_RWX) $(INST_LIBDIR)

$(INST_ARCHAUTODIR)/.exists :: /usr/local/lib/perl5/5.8.0/i686-linux-thread-multi-64all-ld/CORE/perl.h
	@$(MKPATH) $(INST_ARCHAUTODIR)
	@$(EQUALIZE_TIMESTAMP) /usr/local/lib/perl5/5.8.0/i686-linux-thread-multi-64all-ld/CORE/perl.h $(INST_ARCHAUTODIR)/.exists

	-@$(CHMOD) $(PERM_RWX) $(INST_ARCHAUTODIR)

config :: $(INST_MAN3DIR)/.exists
	@$(NOOP)


$(INST_MAN3DIR)/.exists :: /usr/local/lib/perl5/5.8.0/i686-linux-thread-multi-64all-ld/CORE/perl.h
	@$(MKPATH) $(INST_MAN3DIR)
	@$(EQUALIZE_TIMESTAMP) /usr/local/lib/perl5/5.8.0/i686-linux-thread-multi-64all-ld/CORE/perl.h $(INST_MAN3DIR)/.exists

	-@$(CHMOD) $(PERM_RWX) $(INST_MAN3DIR)

help:
	perldoc ExtUtils::MakeMaker


# --- MakeMaker linkext section:

linkext :: $(LINKTYPE)
	@$(NOOP)


# --- MakeMaker dlsyms section:


# --- MakeMaker dynamic section:

## $(INST_PM) has been moved to the all: target.
## It remains here for awhile to allow for old usage: "make dynamic"
#dynamic :: Makefile $(INST_DYNAMIC) $(INST_BOOT) $(INST_PM)
dynamic :: Makefile $(INST_DYNAMIC) $(INST_BOOT)
	@$(NOOP)


# --- MakeMaker dynamic_bs section:

BOOTSTRAP =


# --- MakeMaker dynamic_lib section:


# --- MakeMaker static section:

## $(INST_PM) has been moved to the all: target.
## It remains here for awhile to allow for old usage: "make static"
#static :: Makefile $(INST_STATIC) $(INST_PM)
static :: Makefile $(INST_STATIC)
	@$(NOOP)


# --- MakeMaker static_lib section:


# --- MakeMaker manifypods section:
POD2MAN_EXE = /usr/local/bin/pod2man
POD2MAN = $(PERL) -we '%m=@ARGV;for (keys %m){' \
-e 'next if -e $$m{$$_} && -M $$m{$$_} < -M $$_ && -M $$m{$$_} < -M "Makefile";' \
-e 'print "Manifying $$m{$$_}\n";' \
-e 'system(q[$(PERLRUN) $(POD2MAN_EXE) ].qq[$$_>$$m{$$_}])==0 or warn "Couldn\047t install $$m{$$_}\n";' \
-e 'chmod(oct($(PERM_RW)), $$m{$$_}) or warn "chmod $(PERM_RW) $$m{$$_}: $$!\n";}'

manifypods : pure_all PinyinConvert.pm
	@$(POD2MAN) \
	PinyinConvert.pm \
	$(INST_MAN3DIR)/PerlIO::via::PinyinConvert.$(MAN3EXT)

# --- MakeMaker processPL section:


# --- MakeMaker installbin section:


# --- MakeMaker subdirs section:

# none

# --- MakeMaker clean section:

# Delete temporary files but do not touch installed files. We don't delete
# the Makefile here so a later make realclean still has a makefile to use.

clean ::
	-rm -rf ./blib $(MAKE_APERL_FILE) $(INST_ARCHAUTODIR)/extralibs.all perlmain.c tmon.out mon.out so_locations pm_to_blib *$(OBJ_EXT) *$(LIB_EXT) perl.exe perl perl$(EXE_EXT) $(BOOTSTRAP) $(BASEEXT).bso $(BASEEXT).def lib$(BASEEXT).def $(BASEEXT).exp $(BASEEXT).x core core.*perl.*.? *perl.core
	-mv Makefile Makefile.old $(DEV_NULL)


# --- MakeMaker realclean section:

# Delete temporary files (via clean) and also delete installed files
realclean purge ::  clean
	rm -rf $(INST_AUTODIR) $(INST_ARCHAUTODIR)
	rm -rf $(DISTVNAME)
	rm -f  ../blib/lib/PerlIO/via/PinyinConvert.pm
	rm -rf Makefile Makefile.old


# --- MakeMaker dist_basics section skipped.

# --- MakeMaker dist_core section skipped.

# --- MakeMaker dist_dir section skipped.

# --- MakeMaker dist_test section skipped.

# --- MakeMaker dist_ci section skipped.

# --- MakeMaker install section skipped.

# --- MakeMaker force section:
# Phony target to force checking subdirectories.
FORCE:
	@$(NOOP)


# --- MakeMaker perldepend section:


# --- MakeMaker makefile section:

# We take a very conservative approach here, but it\'s worth it.
# We move Makefile to Makefile.old here to avoid gnu make looping.
Makefile : Makefile.PL $(CONFIGDEP)
	@echo "Makefile out-of-date with respect to $?"
	@echo "Cleaning current config before rebuilding Makefile..."
	-@$(RM_F) Makefile.old
	-@$(MV) Makefile Makefile.old
	-$(MAKE) -f Makefile.old clean $(DEV_NULL) || $(NOOP)
	$(PERLRUN) Makefile.PL 
	@echo "==> Your Makefile has been rebuilt. <=="
	@echo "==> Please rerun the make command.  <=="
	false



# --- MakeMaker staticmake section:

# --- MakeMaker makeaperl section ---
MAP_TARGET    = ../perl
FULLPERL      = /usr/local/bin/perl


# --- MakeMaker test section:

TEST_VERBOSE=0
TEST_TYPE=test_$(LINKTYPE)
TEST_FILE = test.pl
TEST_FILES = 
TESTDB_SW = -d

testdb :: testdb_$(LINKTYPE)

test :: $(TEST_TYPE)
	@echo 'No tests defined for $(NAME) extension.'

test_dynamic :: pure_all

testdb_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) $(TESTDB_SW) "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)

test_ : test_dynamic

test_static :: test_dynamic
testdb_static :: testdb_dynamic


# --- MakeMaker ppd section:
# Creates a PPD (Perl Package Description) for a binary distribution.
ppd:
	@$(PERL) -e "print qq{<SOFTPKG NAME=\"$(DISTNAME)\" VERSION=\"0,01,0,0\">\n\t<TITLE>$(DISTNAME)</TITLE>\n\t<ABSTRACT>PerlIO layer for Lingua::ZH::PinyinConvert</ABSTRACT>\n\t<AUTHOR>xern &lt;xern\@cpan.org&gt;</AUTHOR>\n}" > $(DISTNAME).ppd
	@$(PERL) -e "print qq{\t<IMPLEMENTATION>\n}" >> $(DISTNAME).ppd
	@$(PERL) -e "print qq{\t\t<OS NAME=\"$(OSNAME)\" />\n\t\t<ARCHITECTURE NAME=\"i686-linux-thread-multi-64all-ld\" />\n\t\t<CODEBASE HREF=\"\" />\n\t</IMPLEMENTATION>\n</SOFTPKG>\n}" >> $(DISTNAME).ppd

# --- MakeMaker pm_to_blib section:

pm_to_blib: $(TO_INST_PM)
	@$(PERLRUNINST) "-MExtUtils::Install" \
	-e "pm_to_blib({qw{PinyinConvert.pm ../blib/lib/PerlIO/via/PinyinConvert.pm}},'$(INST_LIB)/auto','$(PM_FILTER)')"
	@$(TOUCH) $@

# --- MakeMaker selfdocument section:


# --- MakeMaker postamble section:


# End.
