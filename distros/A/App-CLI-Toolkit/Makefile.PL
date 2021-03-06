use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'App::CLI::Toolkit',
    AUTHOR              => 'Simon Whitaker <swhitaker@cpan.org>',
    VERSION_FROM        => 'lib/App/CLI/Toolkit.pm',
    ABSTRACT_FROM       => 'lib/App/CLI/Toolkit.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'App-CLI-Toolkit-*' },
);
