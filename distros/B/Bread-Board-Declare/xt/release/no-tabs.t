use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::NoTabsTests 0.05

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/Bread/Board/Declare.pm',
    'lib/Bread/Board/Declare/BlockInjection.pm',
    'lib/Bread/Board/Declare/ConstructorInjection.pm',
    'lib/Bread/Board/Declare/Literal.pm',
    'lib/Bread/Board/Declare/Meta/Role/Attribute.pm',
    'lib/Bread/Board/Declare/Meta/Role/Attribute/Container.pm',
    'lib/Bread/Board/Declare/Meta/Role/Attribute/Service.pm',
    'lib/Bread/Board/Declare/Meta/Role/Class.pm',
    'lib/Bread/Board/Declare/Meta/Role/Instance.pm',
    'lib/Bread/Board/Declare/Role/Object.pm',
    'lib/Bread/Board/Declare/Role/Service.pm'
);

notabs_ok($_) foreach @files;
done_testing;
