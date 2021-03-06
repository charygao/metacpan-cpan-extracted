#!/usr/bin/perl

use 5.008;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME               => 'Text::CSV::Pivot',
    AUTHOR             => q{Mohammad S Anwar <mohammad.anwar@yahoo.com>},
    VERSION_FROM       => 'lib/Text/CSV/Pivot.pm',
    ABSTRACT_FROM      => 'lib/Text/CSV/Pivot.pm',
    LICENSE            => 'artistic_2',
    MIN_PERL_VERSION   => 5.008,
    EXE_FILES          => [ 'script/csv-pivot' ],
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES   => {
        'Test::More' => 0,
        'File::Temp' => 0,
    },
    PREREQ_PM => {
        'Getopt::Long'   => '2.48',
        'Text::CSV'      => '1.33',
        'File::Basename' => '2.6',
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Text-CSV-Pivot-*' },
    (eval { ExtUtils::MakeMaker->VERSION(6.46) } ? (META_MERGE => {
        'meta-spec' => { version => 2 },
        provides    => {
            'Text::CSV::Pivot' => { file => 'lib/Text/CSV/Pivot.pm', version => '0.09' },
        },
        resources => {
            repository => {
                type => 'git',
                url  => 'https://github.com/manwar/Text-CSV-Pivot.git',
                web  => 'https://github.com/manwar/Text-CSV-Pivot',
            },
        }})
     : ()
    ),
);
