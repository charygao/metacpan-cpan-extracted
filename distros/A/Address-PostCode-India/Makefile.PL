#!/usr/bin/perl

use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Address::PostCode::India',
    AUTHOR           => q{Mohammad S Anwar <mohammad.anwar@yahoo.com>},
    VERSION_FROM     => 'lib/Address/PostCode/India.pm',
    ABSTRACT_FROM    => 'lib/Address/PostCode/India.pm',
    LICENSE          => 'artistic_2',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES   => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        'JSON' => 0,
        'Moo'  => 0,
        'namespace::autoclean'         => '0.28',
        'Address::PostCode::UserAgent' => '0.09',
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Address-PostCode-India-*' },
    (eval { ExtUtils::MakeMaker->VERSION(6.46) } ? (META_MERGE => {
        'meta-spec' => { version => 2 },
        provides    => {
            'Address::PostCode::India'        => { file => 'lib/Address/PostCode/India.pm'      , version => '0.13' },
            'Address::PostCode::India::Place' => { file => 'lib/Address/PostCode/India/Place.pm', version => '0.13' },
        },
        resources => {
            repository => {
                type => 'git',
                url  => 'https://github.com/Manwar/Address-PostCode-India.git',
                web  => 'https://github.com/Manwar/Address-PostCode-India',
            },
        }})
     : ()
    ),
);
