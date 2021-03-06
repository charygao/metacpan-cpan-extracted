use 5.010000;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'WWW::Pixelletter',
    VERSION_FROM      => 'lib/WWW/Pixelletter.pm', # finds $VERSION
    PREREQ_PM         => {  LWP::UserAgent => '0',
							File::Util => '0',	
							Locale::Country => 0,
						},
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/WWW/Pixelletter.pm', # retrieve abstract from module
       AUTHOR         => 'Robin Clarke <rcl@robinclarke.net>') : ()),
);
