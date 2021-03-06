# When you compiled GOODS using makefile.freebsd, use this.
use ExtUtils::MakeMaker;

my $argdef = '';
for my $arg(@ARGV) {
	$argdef .= "$arg " if $arg =~ /^-D/;
}

WriteMakefile(
    'NAME'	=> 'Pogo',
    'VERSION_FROM' => 'Pogo.pm', # finds $VERSION
    'CC'	=> 'g++',
    'LD'	=> '$(CC)',
    'LDDLFLAGS' => '-shared -L/usr/local/lib',
    'LIBS'	=> '-lg++ -lstdc++ -lgcc -L/usr/local/goods/lib -lclient',
    'DEFINE'	=> "$argdef",
    'INC'	=> '-I/usr/local/goods/inc',
    'XSPROTOARG'	=> '-noprototypes',
    'OBJECT'	=> 'Pogo.o pogomain.o pogogcls.o pogocall.o nstring.o',
);
