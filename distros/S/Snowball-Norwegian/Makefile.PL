use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
	'NAME'      => 'Lingua::Stem::Snowball::No',
	'VERSION_FROM'  => 'lib/Lingua/Stem/Snowball/No.pm', # finds $VERSION
	'PREREQ_PM'     => { }, # e.g., Module::Name => 1.1
    'PL_FILES'      => { },
    'INST_BIN'      => 'bin/',
	($] >= 5.005 ?    ## Add these new keywords supported since 5.005
		(ABSTRACT_FROM => 'lib/Lingua/Stem/Snowball/No.pm', # retrieve abstract from module
		AUTHOR     => 'Ask Solem Hoel <ASKSH@cpan.net>') : ()),
);

