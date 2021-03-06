use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::EOL 0.19

use Test::More 0.88;
use Test::EOL;

my @files = (
    'lib/MooseX/SlurpyConstructor.pm',
    'lib/MooseX/SlurpyConstructor/Role/Object.pm',
    'lib/MooseX/SlurpyConstructor/Trait/ApplicationToClass.pm',
    'lib/MooseX/SlurpyConstructor/Trait/ApplicationToRole.pm',
    'lib/MooseX/SlurpyConstructor/Trait/Attribute.pm',
    'lib/MooseX/SlurpyConstructor/Trait/Class.pm',
    'lib/MooseX/SlurpyConstructor/Trait/Composite.pm',
    'lib/MooseX/SlurpyConstructor/Trait/Method/Constructor.pm',
    'lib/MooseX/SlurpyConstructor/Trait/Role.pm',
    't/00-report-prereqs.dd',
    't/00-report-prereqs.t',
    't/01_usage.t',
    't/02_normal_usage.t',
    't/03_basic_and_subclassing.t',
    't/04_attribute_options.t',
    't/05_bad_usage.t',
    't/06_instance.t',
    't/07_role.t',
    't/zzz-check-breaks.t',
    'xt/author/00-compile.t',
    'xt/author/clean-namespaces.t',
    'xt/author/eol.t',
    'xt/author/kwalitee.t',
    'xt/author/mojibake.t',
    'xt/author/no-tabs.t',
    'xt/author/pod-coverage.t',
    'xt/author/pod-no404s.t',
    'xt/author/pod-spell.t',
    'xt/author/pod-syntax.t',
    'xt/author/portability.t',
    'xt/release/changes_has_content.t',
    'xt/release/cpan-changes.t',
    'xt/release/distmeta.t',
    'xt/release/minimum-version.t'
);

eol_unix_ok($_, { trailing_whitespace => 1 }) foreach @files;
done_testing;
