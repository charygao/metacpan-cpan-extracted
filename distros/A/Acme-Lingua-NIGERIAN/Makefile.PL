use 5.006;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Acme::Lingua::NIGERIAN',
    'VERSION_FROM'	=> 'NIGERIAN.pm', # finds $VERSION
    'PREREQ_PM'		=> {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'NIGERIAN.pm', # retrieve abstract from module
       AUTHOR     => 'J�RG WALTER <JWALT@CPAN.ORG>') : ()),
);
