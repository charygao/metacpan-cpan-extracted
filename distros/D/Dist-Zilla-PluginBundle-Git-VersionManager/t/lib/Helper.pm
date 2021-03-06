use strict;
use warnings;

package # hide from PAUSE
    Helper;

use parent 'Exporter';
our @EXPORT = qw(
    all_plugins_in_prereqs
    no_git_tempdir
    git_in_path
);

use Test::More 0.96;
use Test::Deep;
use List::Util 1.45 'uniq';
use Path::Tiny;
use JSON::MaybeXS;
use Moose::Util 'find_meta';
use namespace::clean;

my $bundle_plugin_requirements; # hashref via CPAN::Meta::Requirements
{
    use Dist::Zilla::PluginBundle::Git::VersionManager;
    package Dist::Zilla::PluginBundle::Git::VersionManager;
    use Moose;
    __PACKAGE__->meta->make_mutable;
    # grab a copy of _plugin_prereqs attribute so we can test that these
    # prereqs are also reflected in the bundle's runtime-requires
    after configure => sub {
        my $self = shift;
        $bundle_plugin_requirements = $self->_plugin_requirements_as_string_hash;
    };
    __PACKAGE__->meta->make_immutable;
}

# checks that all plugins in use are in the plugin bundle dist's runtime
# requires list
# - some plugins can be explicitly exempted (added manually to faciliate testing)
# TODO: move into its own distribution
sub all_plugins_in_prereqs
{ SKIP: {
    my ($tzil, %options) = @_;

    my $bundle_name = $options{bundle_name} // '@Git::VersionManager';    # TODO: default to dist we are in
    my %exempt = map { $_ => undef } @{ $options{exempt} // [] };

    my $pluginbundle_meta = -f 'META.json' ? decode_json(path('META.json')->slurp_raw) : undef;
    my $dist_meta = $tzil->distmeta;

    subtest 'all plugins in use are specified as *required* runtime prerequisites by the plugin bundle' => sub {
        foreach my $plugin (uniq map { find_meta($_)->name }
            grep { $_->plugin_name =~ /^$bundle_name\/[^@]/ } @{$tzil->plugins})
        {
            note($plugin . ' is explicitly exempted; skipping'), next
                if exists $exempt{$plugin};

            # cannot be a (non-develop) prereq if the module lives in this distribution
            note("$plugin is found in local directory or in 'provides' metadata; skipping"), next
            if (
                $pluginbundle_meta ? exists $pluginbundle_meta->{provides}{$plugin}
               : do {
                   (my $file = $plugin) =~ s{::}{/}g; $file .= '.pm';
                   path('lib', $file)->exists;
               });

            my $required_version = $bundle_plugin_requirements->{find_meta($plugin)->name} // 0;

            # plugin is a core requirement of the bundle
            cmp_deeply(
                $pluginbundle_meta->{prereqs}{runtime}{requires},
                superhashof({ $plugin => $required_version }),
                $plugin . ' is a runtime prereq of the plugin bundle',
            ) if $pluginbundle_meta;
        }

        pass 'this is a token test to keep things humming' if not $pluginbundle_meta;

        if (not Test::Builder->new->is_passing)
        {
            diag 'got dist metadata: ', explain $dist_meta;
            diag 'got plugin bundle metadata: ', explain $pluginbundle_meta;
        }
    }
} }

# provides a temp directory that is guaranteed to not be inside a git repository
# directory is cleaned up when $tempdir goes out of scope
sub no_git_tempdir
{
    my $tempdir = Path::Tiny->tempdir(CLEANUP => 1);
    mkdir $tempdir if not -d $tempdir;    # FIXME: File::Temp::newdir doesn't make the directory?!

    my $in_git = git_in_path($tempdir);
    ok(!$in_git, 'tempdir is not in a real git repository');

    return $tempdir;
}

# checks if a .git directory is in the current or any parent directory
sub git_in_path
{
    my $in_git;
    my $dir = path($_[0]);
    my $count = 0;
    while (not $dir->is_rootdir) {
        # this should never happen.
        do { diag "failed to detect that $dir is at the root?!"; last } if $dir eq $dir->parent;

        my $checkdir = path($dir, '.git');
        if (-d $checkdir) {
            note "found $checkdir in $_[0]";
            $in_git = 1;
            last;
        }
        $dir = $dir->parent;
    }
    continue {
        die "too many iterations when traversing $dir!"
            if $count++ > 100;
    }
    return $in_git;
}

1;
