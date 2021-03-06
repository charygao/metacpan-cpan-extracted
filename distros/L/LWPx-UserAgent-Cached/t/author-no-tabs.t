
BEGIN {
    unless ( $ENV{AUTHOR_TESTING} ) {
        print qq{1..0 # SKIP these tests are for testing by the author\n};
        exit;
    }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.15

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/LWPx/UserAgent/Cached.pm', 't/00-compile.t',
    't/000-report-versions.t',      't/004-cached.t',
    't/005-custom-cache.t',         't/006-cached-chi.t',
    't/TestCache.pm',               't/author-critic.t',
    't/author-eol.t',               't/author-minimum-version.t',
    't/author-mojibake.t',          't/author-no-tabs.t',
    't/author-pod-coverage.t',      't/author-pod-linkcheck.t',
    't/author-pod-syntax.t',        't/author-portability.t',
    't/author-synopsis.t',          't/author-test-version.t',
    't/cache_control.t',            't/cache_key.t',
    't/etag.t',                     't/is_cached.t',
    't/pages/1.html',               't/pages/10.html',
    't/pages/2.html',               't/pages/3.html',
    't/pages/4.html',               't/pages/5.html',
    't/pages/6.html',               't/pages/7.html',
    't/pages/8.html',               't/pages/9.html',
    't/release-cpan-changes.t',     't/release-dist-manifest.t',
    't/release-distmeta.t',         't/release-kwalitee.t',
    't/release-meta-json.t',        't/release-unused-vars.t'
);

notabs_ok($_) foreach @files;
done_testing;
