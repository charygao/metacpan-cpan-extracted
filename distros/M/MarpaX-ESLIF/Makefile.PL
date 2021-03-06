# This Makefile.PL for MarpaX-ESLIF was generated by
# Dist::Zilla::Plugin::MakeMaker::Awesome 0.48.
# Don't edit it but the dist.ini and plugins used to construct it.

use strict;
use warnings;

use 5.010;
use ExtUtils::MakeMaker '7.20';

BEGIN {
  use File::Spec;                     # Formally it is not necessary I believe to do it here
  # Make sure we have our 'inc' directory in the perl search path
  my $inc_dir = File::Spec->catdir(File::Spec->curdir, 'inc');
  push(@INC, $inc_dir);
  #
  # ExtUtils::CppGuess does not install everywhere.
  # This is why we provide it explicitely, we are ok if it fails at run-time
  # (eg. on solaris).
  #
  eval 'use ExtUtils::CppGuess; 1;' || die "$@";
}
use Config;
use Config::AutoConf;
use ExtUtils::CBuilder;
use Cwd qw/abs_path/;
use ExtUtils::Constant qw /constant_types C_constant XS_constant autoload/;
use File::Basename;
use File::Find;
use File::Which;
use IO::Handle;
use IPC::Run qw/run/;
use Perl::OSType qw/is_os_type/;
use Try::Tiny;

autoflush STDOUT 1;

#
# Our distribution have both C and CPP files, and we want to make sure that modifying
# CFLAGS will not affect cpp files. Since we require a version of ExtUtils::CBuilder
# that support the environment variables, explicitely setting the environment variables
# from default ExtUtils::Cbuilder will ensure cc and cpp settings will become independant
# if we are doing to modify any of them.
# We do that for linker settings as well for coherency although we will NEVER touch them.
# OTHERLDFLAGS will be specific to this makefile.
#
# Take care: with ExtUtils::CBuilder, $ENV{CFLAGS} and $ENV{LDFLAGS} are appended to default perl compile flags, not the others
#
#
my %cbuilder_config = ExtUtils::CBuilder->new()->get_config;
$ENV{CC} = $cbuilder_config{cc} // 'cc';
$ENV{CFLAGS} //= '';
$ENV{CXX} = $cbuilder_config{cxx} // $ENV{CC};
$ENV{CXXFLAGS} = $cbuilder_config{cxxflags} // $cbuilder_config{ccflags} // '';
$ENV{LD} = $cbuilder_config{ld} // $ENV{CC};
$ENV{LDFLAGS} //= '';
# OTHERLDFLAGS remains local and must affect ONLY this process, not sub-processes
my @OTHERLDFLAGS = ();
#
print "==========================================\n";
print "Original compilers and linker settings as per ExtUtils::CBuilder\n";
print "\n";
print "CC           (overwrite) $ENV{CC}\n";
print "CFLAGS       (    fixed) " . ($cbuilder_config{ccflags} // '') . "\n";
print "CFLAGS       (   append) $ENV{CFLAGS}\n";
print "CXX          (overwrite) $ENV{CXX}\n";
print "CXXFLAGS     (overwrite) $ENV{CXXFLAGS}\n";
print "LD           (overwrite) $ENV{LD}\n";
print "LDFLAGS      (    fixed) " . ($cbuilder_config{ldflags} // '') . "\n";
print "LDFLAGS      (   append) $ENV{LDFLAGS}\n";
print "==========================================\n";
print "\n";

my $ac = Config::AutoConf->new();
$ac->check_cc;

#
# We want to align lua integer type with perl ivtype
#
my $ivtype = $Config{ivtype} || '';
if ($ivtype eq 'int') {
  $ac->msg_notice("Use int for lua_Integer");
  $ENV{CFLAGS} .= " -DLUA_INT_TYPE=1";
  $ENV{CXXFLAGS} .= " -DLUA_INT_TYPE=1";
} elsif ($ivtype eq 'long') {
  $ac->msg_notice("Use long for lua_Integer");
  $ENV{CFLAGS} .= " -DLUA_INT_TYPE=2";
  $ENV{CXXFLAGS} .= " -DLUA_INT_TYPE=2";
} elsif ($ivtype eq 'long long') {
  $ac->msg_notice("Use long long for lua_Integer");
  $ENV{CFLAGS} .= " -DLUA_INT_TYPE=3";
  $ENV{CXXFLAGS} .= " -DLUA_INT_TYPE=3";
} else {
  $ac->msg_notice("No exact map found in lua for perl integer type \"$ivtype\": use long long for lua_Integer");
  $ENV{CFLAGS} .= " -DLUA_INT_TYPE=3";
  $ENV{CXXFLAGS} .= " -DLUA_INT_TYPE=3";
}

#
# We want to align lua float type with perl nvtype
#
my $nvtype = $Config{nvtype} || '';
if ($nvtype eq 'float') {
  $ac->msg_notice("Use float for lua_Number");
  $ENV{CFLAGS} .= " -DLUA_FLOAT_TYPE=1";
  $ENV{CXXFLAGS} .= " -DLUA_FLOAT_TYPE=1";
} elsif ($nvtype eq 'double') {
  $ac->msg_notice("Use double for lua_Number");
  $ENV{CFLAGS} .= " -DLUA_FLOAT_TYPE=2";
  $ENV{CXXFLAGS} .= " -DLUA_FLOAT_TYPE=2";
} elsif ($nvtype eq 'long double') {
  $ac->msg_notice("Use long double for lua_Number");
  $ENV{CFLAGS} .= " -DLUA_FLOAT_TYPE=3";
  $ENV{CXXFLAGS} .= " -DLUA_FLOAT_TYPE=3";
} else {
  $ac->msg_notice("No exact map found in lua for perl double type \"$nvtype\": use long double for lua_Number");
  $ENV{CFLAGS} .= " -DLUA_FLOAT_TYPE=3";
  $ENV{CXXFLAGS} .= " -DLUA_FLOAT_TYPE=3";
}
#
# Guess CXX configuration
#
#
# Sun/Solaris CC is a special case, we know that guess_compiler will always get it wrong
#
my $solariscase = 0;
$ac->msg_checking(sprintf "if this is solaris compiler");
if ($ac->link_if_else("#if defined(__sun) && defined(__SVR4)\n#else\n#error \"this is not solaris compiler\"\n#endif\nint main() { return 0; }")) {
  $ac->msg_result('yes');
  my $cc = which($ENV{CC}) || '';
  if (! $cc) {
    #
    # Should never happen since we checked that the compiler works
    #
    $ac->msg_notice("Warning! Solaris C compiler working but which() on its location returned false !?");
  } else {
    #
    # $cc should be a full path
    #
    $cc = abs_path($cc);
    my $ccdir = dirname($cc) || File::Spec->curdir();
    my $cxx = File::Spec->catfile($ccdir, 'CC');
    # We always give precedence to CC that should be at the same location of the C compiler
    #
    if (! which($cxx)) {
      #
      # No CC at the same location?
      #
      $ac->msg_notice("Warning! Solaris C compiler detected but no CC found at the same location - trying with default search path");
      $cxx = 'CC';
    } else {
      #
      # Could it be that this CC is also the one that is, eventually, in the path?
      #
      my $cxxfromPATH = which('CC') || '';
      if ($cxxfromPATH) {
        $cxxfromPATH = abs_path($cxxfromPATH);
        my $cxxfromWhich = abs_path($cxx);
        if ($cxxfromWhich eq $cxxfromPATH) {
          $ac->msg_notice("Solaris C compiler detected and its CC counterpart is already in the search path");
          $cxx = 'CC';
        }
      }
    }
    if (which($cxx)) {
      $ac->msg_notice("Forcing CXX to $cxx");
      $ENV{CXX} = $cxx;
      #
      # We got "CC" executable - no need of eventual -x c++ that perl may have add
      #
      if ($ENV{CXXFLAGS} =~ s/\-x\s+c\+\+\s*//) {
        $ac->msg_notice("Removed -x c++ from CXXFLAGS");
      }
    } else {
      $ac->msg_notice("Warning! Solaris C compiler detected but no CC found neither in path neither where is the C compiler");
    }
    #
    # In any case, add -lCrun and do not execute guess_compiler - cross fingers if we did not managed to find CXX
    #
    $ac->msg_notice("Adding -lCrun to OTHERLDFLAGS");
    push(@OTHERLDFLAGS, '-lCrun');
    $solariscase = 1;
  }
} else {
  $ac->msg_result('no');
}
if (! $solariscase) {
  try {
    my ($cxx_guess, $extra_cxxflags_guess, $extra_ldflags_guess) = guess_compiler();
    if (defined($cxx_guess) && (length($cxx_guess) > 0) && which($cxx_guess)) {
      $ac->msg_notice("Setting CXX to $cxx_guess");
      $ENV{CXX} = $cxx_guess;
      if (defined($extra_cxxflags_guess) && (length($extra_cxxflags_guess) > 0)) {
        $ac->msg_notice("Appending $extra_cxxflags_guess to CXXFLAGS");
        $ENV{CXXFLAGS} .= " $extra_cxxflags_guess";
      }
      if (defined($extra_ldflags_guess) && (length($extra_ldflags_guess) > 0)) {
        $ac->msg_notice("Pushing $extra_ldflags_guess to OTHERLDFLAGS");
        push(@OTHERLDFLAGS, $extra_ldflags_guess)
      }
    }
  };
}
if ((! "$ENV{CXX}") || (! which($ENV{CXX}))) {
  $ac->msg_notice("Fallback mode trying to guess from C compiler");
  my $cc_basename = basename($ENV{CC});
  my $cc_dirname = dirname($ENV{CC});
  #
  # Traditionally xxxxcc becomes xxxx++
  #
  if ($cc_basename =~ /cc$/i) {
    my $cxx_basename = $cc_basename;
    $cxx_basename =~ s/cc$/++/;
    my $cxx = File::Spec->catfile($cc_dirname, $cxx_basename);
    if (which($cxx)) {
      $ac->msg_notice("Setting CXX to found $cxx");
      $ENV{CXX} = $cxx;
    }
  }
  #
  # Or xxxxlang becomes lang++
  #
  elsif ($cc_basename =~ /lang$/i) {
    my $cxx_basename = $cc_basename;
    $cxx_basename .= "++";
    my $cxx = File::Spec->catfile($cc_dirname, $cxx_basename);
    if (which($cxx)) {
      $ac->msg_notice("Setting CXX to found $cxx");
      $ENV{CXX} = $cxx;
    }
  }
  #
  # Cross fingers, and use C compiler
  #
  else {
    $ac->msg_notice("Setting CXX to fallback $ENV{CC}");
    $ENV{CXX} = $ENV{CC};
  }
}

# -------------
# CC and CFLAGS
# --------------
#
my $isc99 = 0;
if (($cbuilder_config{cc} // 'cc') ne 'cl') {
    $ac->msg_checking("Checking if C99 is enabled by default:");
    if (try_compile("#if !defined(__STDC_VERSION__) || __STDC_VERSION__ < 199901L\n#error \"C99 is not enabled\"\n#endif\nint main(){return 0;}")) {
        $ac->msg_result('yes');
        $isc99 = 1;
    } else {
        $ac->msg_result('no');
        $ac->msg_notice("Checking what CFLAGS is required for C99:");
        foreach my $flag (qw/-std=gnu99 -std=c99 -c99 -AC99 -xc99=all -qlanglvl=extc99/) {
            $ac->msg_checking("Checking if flag $flag works:");
            if (try_compile("#if !defined(__STDC_VERSION__) || __STDC_VERSION__ < 199901L\n#error \"C99 is not enabled\"\n#endif\nint main(){return 0;}", $flag)) {
                $ac->msg_result('yes');
                $ENV{CFLAGS} .= " $flag";
                $isc99 = 1;
                last;
            } else {
                $ac->msg_result('no');
            }
        }
    }
}

#
# When the compiler is clang, there is a bug with inlining, c.f. for example
# https://sourceforge.net/p/resil/tickets/6/
#
if (is_os_type('Unix', 'darwin') && ! $isc99)
{
  $ac->msg_checking(sprintf "if this is clang compiler");
  if ($ac->link_if_else("#ifndef __clang__\n#error \"this is not clang compiler\"\n#endif\nint main() { return 0; }")) {
      $ac->msg_result('yes');
      #
      # C.f. http://clang.llvm.org/compatibility.html#inline
      #      https://bugzilla.mozilla.org/show_bug.cgi?id=917526
      #
      $ac->msg_notice("Adding -std=gnu89 to CFLAGS for inline semantics");
      $ENV{CFLAGS} .= ' -std=gnu89';
  } else {
      $ac->msg_result('no');
  }
}

if ($^O eq "netbsd" && ! $isc99) {
  #
  # We need long long, that C99 guarantees, else _NETBSD_SOURCE will do it
  #
  $ac->msg_notice("NetBSD platform: Append _NETBSD_SOURCE to CFLAGS to have long long");
  $ENV{CFLAGS} .= ' -D_NETBSD_SOURCE';
}

#
# On windows we are using dlfcn-win32 that will imply a dependency on psapi. We verify this library is available
#

if (is_os_type('Windows')) {
  $ac->msg_notice("Windows platform: Append -D__NO_INLINE__ to CFLAGS and CXXFLAGS");
  $ENV{CFLAGS} .= ' -D__NO_INLINE__';
  $ENV{CXXFLAGS} .= ' -D__NO_INLINE__';
  $ac->msg_notice("Windows platform: Determining the need for -lpsapi");
  $ac->push_libraries('psapi');
  if ($ac->link_if_else("#include <windows.h>\n#include <psapi.h>\nint main() { EnumProcessModules(NULL, NULL, 0, NULL); }")) {
    if (basename($Config{cc}) =~ /^cl/i) {
      $ac->msg_notice("Windows platform: Adding psapi.lib to OTHERLDFLAGS");
      push(@OTHERLDFLAGS, "psapi.lib");
    } else {
      $ac->msg_notice("Windows platform: Adding -lpsapi to OTHERLDFLAGS");
      push(@OTHERLDFLAGS, "-lpsapi");
    }
  }
}

my $OTHERLDFLAGS = join(' ', @OTHERLDFLAGS);
print "\n";
print "==========================================\n";
print "Tweaked compilers and linker settings\n";
print "\n";
print "CC           (overwrite) $ENV{CC}\n";
print "CFLAGS       (    fixed) " . ($cbuilder_config{ccflags} // '') . "\n";
print "CFLAGS       (   append) $ENV{CFLAGS}\n";
print "CXX          (overwrite) $ENV{CXX}\n";
print "CXXFLAGS     (overwrite) $ENV{CXXFLAGS}\n";
print "LD           (overwrite) $ENV{LD}\n";
print "LDFLAGS      (    fixed) " . ($cbuilder_config{ldflags} // '') . "\n";
print "LDFLAGS      (   append) $ENV{LDFLAGS}\n";
print "OTHERLDFLAGS             $OTHERLDFLAGS\n";
print "==========================================\n";
print "\n";

my $fh;
print "Generating constant types\n";
open($fh, '>', 'c-constant-types.inc') || die "Cannot open c-constant-types.inc, $!";
print $fh constant_types();
close($fh) || warn "Failed to close c-constant-types.inc, $!";

my %types = ( 'event' => { pkg => 'MarpaX::ESLIF::Event::Type', constants => [qw/MARPAESLIF_EVENTTYPE_NONE MARPAESLIF_EVENTTYPE_COMPLETED MARPAESLIF_EVENTTYPE_NULLED MARPAESLIF_EVENTTYPE_PREDICTED MARPAESLIF_EVENTTYPE_BEFORE MARPAESLIF_EVENTTYPE_AFTER MARPAESLIF_EVENTTYPE_EXHAUSTED MARPAESLIF_EVENTTYPE_DISCARD/] }, 'value' => { pkg => 'MarpaX::ESLIF::Value::Type', constants => [qw/MARPAESLIF_VALUE_TYPE_UNDEF MARPAESLIF_VALUE_TYPE_CHAR MARPAESLIF_VALUE_TYPE_SHORT MARPAESLIF_VALUE_TYPE_INT MARPAESLIF_VALUE_TYPE_LONG MARPAESLIF_VALUE_TYPE_FLOAT MARPAESLIF_VALUE_TYPE_DOUBLE MARPAESLIF_VALUE_TYPE_PTR MARPAESLIF_VALUE_TYPE_ARRAY MARPAESLIF_VALUE_TYPE_BOOL MARPAESLIF_VALUE_TYPE_STRING MARPAESLIF_VALUE_TYPE_ROW MARPAESLIF_VALUE_TYPE_TABLE MARPAESLIF_VALUE_TYPE_LONG_DOUBLE/] }, 'loggerLevel' => { pkg => 'MarpaX::ESLIF::Logger::Level', constants => [qw/GENERICLOGGER_LOGLEVEL_TRACE GENERICLOGGER_LOGLEVEL_DEBUG GENERICLOGGER_LOGLEVEL_INFO GENERICLOGGER_LOGLEVEL_NOTICE GENERICLOGGER_LOGLEVEL_WARNING GENERICLOGGER_LOGLEVEL_ERROR GENERICLOGGER_LOGLEVEL_CRITICAL GENERICLOGGER_LOGLEVEL_ALERT GENERICLOGGER_LOGLEVEL_EMERGENCY/] }, 'rulePropertyBitSet' => { pkg => 'MarpaX::ESLIF::Rule::PropertyBitSet', constants => [qw/MARPAESLIF_RULE_IS_ACCESSIBLE MARPAESLIF_RULE_IS_NULLABLE MARPAESLIF_RULE_IS_NULLING MARPAESLIF_RULE_IS_LOOP MARPAESLIF_RULE_IS_PRODUCTIVE/] }, 'symbolPropertyBitSet' => { pkg => 'MarpaX::ESLIF::Symbol::PropertyBitSet', constants => [qw/MARPAESLIF_SYMBOL_IS_ACCESSIBLE MARPAESLIF_SYMBOL_IS_NULLABLE MARPAESLIF_SYMBOL_IS_NULLING MARPAESLIF_SYMBOL_IS_PRODUCTIVE MARPAESLIF_SYMBOL_IS_START MARPAESLIF_SYMBOL_IS_TERMINAL/] }, 'symbolEventBitSet' => { pkg => 'MarpaX::ESLIF::Symbol::EventBitSet', constants => [qw/MARPAESLIF_SYMBOL_EVENT_COMPLETION MARPAESLIF_SYMBOL_EVENT_NULLED MARPAESLIF_SYMBOL_EVENT_PREDICTION/] }, 'symbol' => { pkg => 'MarpaX::ESLIF::Symbol::Type', constants => [qw/MARPAESLIF_SYMBOLTYPE_TERMINAL MARPAESLIF_SYMBOLTYPE_META/] });

foreach (sort keys %types) {
  my $pkg = $types{$_}->{pkg};
  print "Generating $pkg C $_ types\n";
  open($fh, '>', "c-$_-types.inc") || die "Cannot open c-$_-types.inc, $!";
  print $fh C_constant($pkg, "${_}_constant", undef, undef, undef, undef, @{$types{$_}->{constants}});
  close($fh) || warn "Failed to close c-$_-types.inc, $!";

  # This is a bit vicious but in our case these are NOT macros but ENUMS !
  # We know what were are doing and replace all #ifdef MARPAESLIF_xxx and #ifdef GENERICLOGGER_xxx by #if 1

  print "Tweaking $pkg C $_ types to work with enums\n";
  open($fh, '<', "c-$_-types.inc") || die "Failed to open c-$_-types.inc, $!";
  my $content = do { local $/; <$fh> };
  close($fh) || warn "Failed to close c-$_-types.inc, $!";
  $content =~ s/^#\s*ifdef\s+(?:MARPAESLIF_|GENERICLOGGER_).*?$/#if 1/smg;
  open($fh, '>', "c-$_-types.inc") || die "Failed to open c-$_-types.inc, $!";
  print $fh $content;
  close($fh) || warn "Failed to close c-$_-types.inc, $!";

  print "Generating $pkg XS $_ types\n";
  open($fh, '>', "xs-$_-types.inc") || die "Cannot open xs-$_-types.inc, $!";
  print $fh XS_constant($pkg, 'IV', 'constant', "${_}_constant");
  close($fh) || warn "Failed to close xs-$_-types.inc, $!";

  print "Generating $pkg AUTOLOAD\n";
  my $autoload = autoload($pkg, '5.10', 1);

  my @pkg = split(/::/, $pkg);
  $pkg[-1] .= '.pm';
  my $pkgfile = File::Spec->catfile('lib', @pkg);
  print "Pushing AUTOLOAD into $pkgfile\n";
  open($fh, '<', $pkgfile) || die "Failed to open $pkgfile, $!";
  $content = do { local $/; <$fh> };
  close($fh) || warn "Failed to close $pkgfile, $!";
  $content =~ s/^#\s*AUTOLOAD.*?$/\n$autoload\n/sm;
  open($fh, '>', $pkgfile) || die "Failed to open $pkgfile, $!";
  print $fh $content;
  close($fh) || warn "Failed to close $pkgfile, $!";
}

run([$^X, File::Spec->catfile('src', 'CMakeObjects.PL')]) or die "src/CMakeObjects.PL: $?";
my @ldfrom = ();
my %unique = ();

find({ wanted => sub {
                       if (-f $_) {
                         my $cpath = File::Spec->canonpath($_);
                         if (basename(dirname($cpath)) eq 'obj4perl') {
                           if (! ${unique}{basename($cpath)}++) {
                             push(@ldfrom, $cpath);
                           }
                         }
                       }
                     },
      no_chdir => 1 }, File::Spec->curdir);

print "Linking ESLIF\$(OBJ_EXT) using: @ldfrom\n";

#
# Inspired by Inline-CPP-0.74/inc/ILCPPConfig/CompilerGuess.pm
#
sub guess_compiler {

  my ($cxx_guess, $extra_cxxflags_guess, $extra_ldflags_guess, $guesser, %configuration);

  if( $Config::Config{osname} eq 'freebsd'
    && $Config::Config{osvers} =~ /^(\d+)/
    && $1 >= 10
  ){
    if( $ENV{CC} =~ /\bclang\b/ ) {
      $cxx_guess = $ENV{CC};
      $cxx_guess =~ s/\bclang\b/clang++/;
    } else {
      $cxx_guess = 'clang++';
    }
    $extra_cxxflags_guess = '';     # Extra compile flag moved to compiler command -;
    $extra_ldflags_guess = '-lc++'; # Extra linker flag
  }
  else {
    $guesser = ExtUtils::CppGuess->new(cc => $ENV{CC});
    %configuration = $guesser->module_build_options;
    $extra_cxxflags_guess = $configuration{extra_compiler_flags};
    $extra_ldflags_guess = $configuration{extra_linker_flags};
    if( $guesser->is_gcc ) {
      if( $ENV{CC} =~ /\bclang\b/ ) {
        $cxx_guess = $ENV{CC};
        $cxx_guess =~ s/\bclang\b/clang++/;
      } else {
        if( $ENV{CC} =~ /\bgcc\b/ ) {
          $cxx_guess = $ENV{CC};
          $cxx_guess =~ s/\bgcc\b/g++/;
        } else {
          $cxx_guess = 'g++';
        }
      }
      $extra_cxxflags_guess = '';    # Extra compile flag moved to compiler command, extra linker flag untouched -;
    }

    ( $cxx_guess, $extra_cxxflags_guess, $extra_ldflags_guess ) = map { _trim_whitespace($_) } ( $cxx_guess, $extra_cxxflags_guess, $extra_ldflags_guess );
  }
  return ( $cxx_guess, $extra_cxxflags_guess, $extra_ldflags_guess );
}

sub _trim_whitespace {
  my $string = shift;
  if (defined($string)) {
    $string =~ s/^\s+|\s+$//g;
  }
  return $string;
}

sub try_compile {
    my ($csource, $extra_compiler_flags) = @_;

    my $fh = File::Temp->new(UNLINK => 0, SUFFIX => '.c');
    print $fh "$csource\n";
    close($fh);
    my $source = $fh->filename;
    my $rc = 0;

    try {
        my $cbuilder = ExtUtils::CBuilder->new();
        my $obj = basename($cbuilder->object_file($source));
        $cbuilder->compile(
            source               => $source,
            object_file          => $obj,
            extra_compiler_flags => $extra_compiler_flags
            );
        $rc = 1;
    };
    unlink $fh->filename;

    return $rc;
}

my %WriteMakefileArgs = (
  "ABSTRACT" => "ESLIF is Extended ScanLess InterFace",
  "AUTHOR" => "Jean-Damien Durand <jeandamiendurand\@free.fr>",
  "CONFIGURE_REQUIRES" => {
    "Archive::Tar" => 0,
    "Capture::Tiny" => 0,
    "Config" => 0,
    "Config::AutoConf" => 0,
    "Config::AutoConf::INI" => "0.005",
    "ExtUtils::CBuilder" => "0.280224",
    "ExtUtils::Constant" => 0,
    "ExtUtils::MakeMaker" => "7.20",
    "File::Basename" => 0,
    "File::Copy" => 0,
    "File::Copy::Recursive" => 0,
    "File::Find" => 0,
    "File::Path" => 0,
    "File::Spec" => 0,
    "File::Which" => "1.23",
    "File::chdir" => 0,
    "IO::Handle" => 0,
    "IPC::Run" => 0,
    "POSIX" => 0,
    "Perl::OSType" => 0,
    "Try::Tiny" => 0,
    "diagnostics" => 0,
    "strict" => 0
  },
  "DISTNAME" => "MarpaX-ESLIF",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010",
  "NAME" => "MarpaX::ESLIF",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Devel::GlobalDestruction" => 0,
    "Encode" => 0,
    "JSON::MaybeXS" => "1.004000",
    "Math::BigFloat" => 0,
    "Math::BigInt" => 0,
    "Moo" => 0,
    "XSLoader" => 0,
    "constant" => 0,
    "namespace::autoclean" => 0,
    "namespace::clean" => 0,
    "overload" => 0,
    "parent" => 0,
    "strict" => 0,
    "vars" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "File::Temp" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Log::Any" => 0,
    "Log::Any::Adapter" => 0,
    "Log::Any::Adapter::Log4perl" => 0,
    "Log::Any::Adapter::Util" => "1.03",
    "Log::Log4perl" => "1.32",
    "Safe::Isa" => 0,
    "Test::Deep" => "1.128",
    "Test::Deep::NoTest" => 0,
    "Test::More" => "1.3",
    "Test::More::UTF8" => 0,
    "Try::Tiny" => 0,
    "diagnostics" => 0,
    "open" => 0,
    "threads" => 0,
    "threads::shared" => 0,
    "utf8" => 0
  },
  "VERSION" => "4.0.1",
  "test" => {
    "TESTS" => "t/*.t"
  }
);

%WriteMakefileArgs = (
    %WriteMakefileArgs,
    OBJECT => 'ESLIF$(OBJ_EXT)',
    LDFROM => join(' ', '$(OBJECT)', @ldfrom),
    dynamic_lib => { OTHERLDFLAGS => join(' ', @OTHERLDFLAGS) },
    INC => join(' ', map { "-I$_ " } (File::Spec->catdir('src', 'output', 'include'), File::Spec->catdir('src', 'include'), File::Spec->catdir('src', 'output', '3rdparty', 'genericLogger', 'output', 'include'), File::Spec->catdir('src', 'output', '3rdparty', 'genericLogger', 'include'), File::Spec->catdir('src', 'output', '3rdparty', 'genericStack', 'include'), File::Spec->catdir('src', 'output', '3rdparty', 'genericHash', 'include') ) ),
);

my %FallbackPrereqs = (
  "Carp" => 0,
  "Devel::GlobalDestruction" => 0,
  "Encode" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "File::Temp" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "JSON::MaybeXS" => "1.004000",
  "Log::Any" => 0,
  "Log::Any::Adapter" => 0,
  "Log::Any::Adapter::Log4perl" => 0,
  "Log::Any::Adapter::Util" => "1.03",
  "Log::Log4perl" => "1.32",
  "Math::BigFloat" => 0,
  "Math::BigInt" => 0,
  "Moo" => 0,
  "Safe::Isa" => 0,
  "Test::Deep" => "1.128",
  "Test::Deep::NoTest" => 0,
  "Test::More" => "1.3",
  "Test::More::UTF8" => 0,
  "Try::Tiny" => 0,
  "XSLoader" => 0,
  "constant" => 0,
  "diagnostics" => 0,
  "namespace::autoclean" => 0,
  "namespace::clean" => 0,
  "open" => 0,
  "overload" => 0,
  "parent" => 0,
  "strict" => 0,
  "threads" => 0,
  "threads::shared" => 0,
  "utf8" => 0,
  "vars" => 0,
  "warnings" => 0
);

# inserted by Dist::Zilla::Plugin::DynamicPrereqs 0.035
use Config;
if (! $Config{usethreads}) {
  foreach (qw/PREREQ_PM BUILD_REQUIRES TEST_REQUIRES/) {
    delete($WriteMakefileArgs{$_}{Thread}) if (exists($WriteMakefileArgs{$_}));
    delete($FallbackPrereqs{$_}{Thread})   if (exists($FallbackPrereqs{$_}));
  }
}

unless ( eval { ExtUtils::MakeMaker->VERSION('6.63_03') } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
