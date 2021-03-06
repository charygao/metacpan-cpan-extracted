#!/usr/bin/perl

use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME               => 'Calendar::Julian',
    AUTHOR             => q{Mohammad S Anwar <mohammad.anwar@yahoo.com>},
    VERSION_FROM       => 'lib/Calendar/Julian.pm',
    ABSTRACT_FROM      => 'lib/Calendar/Julian.pm',
    LICENSE            => 'artistic_2',
    MIN_PERL_VERSION   => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES   => {
        'Test::More'        => 0,
        'File::Temp'        => 0,
        'XML::SemanticDiff' => 0,
    },
    PREREQ_PM => {
        'Moo'                        => '2.000000',
        'namespace::autoclean'       => '0.28',
        'Date::Julian::Simple'       => '0.12',
        'Calendar::Plugin::Renderer' => '0.15',
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Calendar-Julian-*' },
    (eval { ExtUtils::MakeMaker->VERSION(6.46) } ? (META_MERGE => {
        'meta-spec' => { version => 2 },
        provides    => {
            'Calendar::Julian' => { file => 'lib/Calendar/Julian.pm', version => '0.17' },
        },
        resources => {
            repository => {
                type => 'git',
                url  => 'https://github.com/manwar/Calendar-Julian.git',
                web  => 'https://github.com/manwar/Calendar-Julian',
            },
        }})
     : ()
    ),
);
