
BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    print qq{1..0 # SKIP these tests are for testing by the author\n};
    exit
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.15

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/Search/Elasticsearch/Client/0_90.pm',
    'lib/Search/Elasticsearch/Client/0_90/Bulk.pm',
    'lib/Search/Elasticsearch/Client/0_90/Direct.pm',
    'lib/Search/Elasticsearch/Client/0_90/Direct/Cluster.pm',
    'lib/Search/Elasticsearch/Client/0_90/Direct/Indices.pm',
    'lib/Search/Elasticsearch/Client/0_90/Role/API.pm',
    'lib/Search/Elasticsearch/Client/0_90/Role/Bulk.pm',
    'lib/Search/Elasticsearch/Client/0_90/Role/Scroll.pm',
    'lib/Search/Elasticsearch/Client/0_90/Scroll.pm',
    'lib/Search/Elasticsearch/Client/0_90/TestServer.pm',
    't/Client_0_90/00_print_version.t',
    't/Client_0_90/10_live.t',
    't/Client_0_90/15_conflict.t',
    't/Client_0_90/20_fork_httptiny.t',
    't/Client_0_90/21_fork_lwp.t',
    't/Client_0_90/22_fork_hijk.t',
    't/Client_0_90/30_bulk_add_action.t',
    't/Client_0_90/31_bulk_helpers.t',
    't/Client_0_90/32_bulk_flush.t',
    't/Client_0_90/33_bulk_errors.t',
    't/Client_0_90/34_bulk_cxn_errors.t',
    't/Client_0_90/40_scroll.t',
    't/Client_0_90/50_reindex.t',
    't/Client_0_90/60_auth_httptiny.t',
    't/Client_0_90/61_auth_lwp.t',
    't/author-eol.t',
    't/author-no-tabs.t',
    't/author-pod-syntax.t',
    't/lib/LogCallback.pl',
    't/lib/MockCxn.pm',
    't/lib/bad_cacert.pem',
    't/lib/default_cxn.pl',
    't/lib/es_sync.pl',
    't/lib/es_sync_auth.pl',
    't/lib/es_sync_fork.pl',
    't/lib/index_test_data.pl'
);

notabs_ok($_) foreach @files;
done_testing;
