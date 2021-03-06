use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Lingua::Zompist::Barakhinei',
    'VERSION_FROM'	=> 'Barakhinei.pm', # finds $VERSION
    'PREREQ_PM'		=> { Test::More => 0.19 }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'Barakhinei.pm', # retrieve abstract from module
       AUTHOR     => 'Philip Newton <pne@cpan.org>') : ()),
);
