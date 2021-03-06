use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'punctuation',
    'VERSION_FROM'	=> 'punctuation.pm', # finds $VERSION
    'PREREQ_PM'		=> {B::Utils => 0.03}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT => 'Forbid uses of punctuation variables', 
       AUTHOR     => 'M. J. Dominus <mjd-perl-nopunct+@plover.com') : ()),
);
