use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Net::MyIP',
    VERSION_FROM      => 'lib/Net/MyIP.pm', # finds $VERSION, requires EU::MM from perl >= 5.5
    PREREQ_PM         => {'JSON::XS' => 0, 'LWP::Simple' => 0}, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/Net/MyIP.pm', # retrieve abstract from module
    AUTHOR            => '',
    #LICENSE           => 'perl',
    #Value must be from legacy list of licenses here
    #http://search.cpan.org/perldoc?Module%3A%3ABuild%3A%3AAPI
);
