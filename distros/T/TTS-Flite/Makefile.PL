use 5.026001;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'TTS::Flite',
    VERSION_FROM      => 'lib/TTS/Flite.pm', # finds $VERSION, requires EU::MM from perl >= 5.5
    PREREQ_PM         => {'Alt::Devel::CallParser::ButWorking' => '0.002', 'Kavorka' => '0.039', 'Mouse' => '2.5.6', 'FFI::Raw' => '0.32'}, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/TTS/Flite.pm', # retrieve abstract from module
    AUTHOR            => '',
    #LICENSE           => 'perl',
    #Value must be from legacy list of licenses here
    #http://search.cpan.org/perldoc?Module%3A%3ABuild%3A%3AAPI
);
