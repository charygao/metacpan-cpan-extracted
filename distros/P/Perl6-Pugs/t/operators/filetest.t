use v6-alpha;

use Test;

=head1 DESCRIPTION

This test tests the various filetest operators.

=cut

plan 41;

#if $*OS eq any <MSWin32 mingw msys cygwin> {
#    skip 30, "file tests not fully available on win32";
#    exit;
#};

if $*OS eq "browser" {
  skip_rest "Programs running in browsers don't have access to regular IO.";
  exit;
}

# Basic tests
ok -d 't',            "-d returns true on directories";
ok -f $*PROGRAM_NAME, "-f returns true on files";
ok -e $*PROGRAM_NAME, "-e returns true on files";
ok -e 't',            "-e returns true on directories";
ok -r $*PROGRAM_NAME, "-r returns true on readable files";
ok -w $*PROGRAM_NAME, "-w returns true on writable files";

if $*OS eq any <MSWin32 mingw msys cygwin> {
  skip 2, "win32 doesn't have -x";
} else {
  if -e $*EXECUTABLE_NAME {
    ok -x $*EXECUTABLE_NAME, "-x returns true on executable files";
  }
  else {
    skip 1, "'$*EXECUTABLE_NAME' is not present (interactive mode?)";
  }
  ok -x 't',    "-x returns true on cwd()able directories";
}

ok not -f "t", "-f returns false on directories";
ok -r "t",  "-r returns true on a readable directory";

skip 2, "/etc/shadow tests skipped";
#if $*OS eq any <MSWin32 mingw msys cygwin> {
#  skip 2, "win32 doesn't have /etc/shadow";
#} else {
#  ok not -r "/etc/shadow", "-r returns false on unreadable files";
#  ok not -w "/etc/shadow", "-w returns false on unwritable files";
#}

ok not -d 'doesnotexist', "-d returns false on non existant directories";
ok not -r 'doesnotexist', "-r returns false on non existant directories";
ok not -w 'doesnotexist', "-w returns false on non existant directories";
ok not -x 'doesnotexist', "-x returns false on non existant directories";
ok not -f 'doesnotexist', "-f returns false on non existant directories";

ok not -f 'doesnotexist.t', "-f returns false on non existant files";
ok not -r 'doesnotexist.t', "-r returns false on non existant files";
ok not -w 'doesnotexist.t', "-w returns false on non existant files";
ok not -x 'doesnotexist.t', "-x returns false on non existant files";
ok not -f 'doesnotexist.t', "-f returns false on non existant files";

#if $*OS eq any <MSWin32 mingw msys cygwin> {
#  skip 1, "-s is not working on Win32 yet"
#}
#else {
  ok  -s $*PROGRAM_NAME > 42,   "-s returns size on existant files";
#}
ok not -s "doesnotexist.t", "-s returns false on non existant files";

ok not -z $*PROGRAM_NAME,   "-z returns false on existant files";
ok not -z "doesnotexist.t", "-z returns false on non existant files";
ok not -z "t",              "-z returns false on directories";

my $fh = open("empty_file", :w);
close $fh;
#if $*OS eq any <MSWin32 mingw msys cygwin> {
#  skip 1, "-z is not working on Win32 yet"
#}
#else {
  ok -z "empty_file",      "-z returns true for an empty file";
#}
unlink "empty_file";

# Stacked filetests
# L<S03/Changes to Perl 5 operators/"just cascade tests">
ok -e -d -r "t",               "stacking of filetest operators (1)";
ok -e -f -r $*PROGRAM_NAME, "stacking of filetest operators (2)";
ok not -e -f -r "doesnotexist.t", "stacking of filetest operators (3)";
# This one should return false *all the time* (-f and -d are mutually
# exclusive):
ok not -e -f -d "t",              "stacking of filetest operators (4-1)";
ok not -e -f -d "doesnotexist.t", "stacking of filetest operators (4-2)";
ok not -e -f -d "pugs",           "stacking of filetest operators (4-3)";
# L<S03/Changes to Perl 5 operators/"put the value in a variable">
my $sb = -e "t";
ok -d $sb, 'filetest operators return a stat buffer';
$sb = -e $*PROGRAM_NAME;
ok -f -r $sb, 'filetest operators can stack on stat buffer';
# L<S03/Changes to Perl 5 operators/"in the case of -s, a number">
my $sizeSB = -s $*PROGRAM_NAME;
ok $sizeSB > 42, '-s is a number';
ok -e $sizeSB, 'result of -s is a stat buffer', :todo<bug>;
# L<S03/Changes to Perl 5 operators/filetest operators return both
#                                   a boolean and a stat buffer>
$sb = -f $*PROGRAM_NAME;
isa_ok $sb, 'Bool', 'filetest operators return a boolean', :todo<feature>;
$sb = -s $*PROGRAM_NAME;
isa_ok $sb, 'Num', '-s returns a number';
# We should get false, but still be able to use the result
$sb = -f "t";
skip 1, '-f "t" is true somehow, so next test is invalid' if $sb;
ok -e $sb, 'false stat buffers can still be used', :todo<bug>;
