use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Acme::Remote::Strangulation::Protocol',
    'VERSION_FROM'	=> 'Protocol.pm', # finds $VERSION
    'PREREQ_PM'		=> { Test::More => 0,
											 Text::Wrap => 0,
											 Test::Harness => 0,
											 Test::Pod => 0,
		                 }, # e.g., Module::Name => 1.1
);
