use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'ACME::Error::IgpayAtinlay',
    'VERSION_FROM'	=> 'IgpayAtinlay.pm', # finds $VERSION
    'PREREQ_PM'		=> { Lingua::Atinlay::Igpay => 0.01 }, # e.g., Module::Name => 1.1
);
