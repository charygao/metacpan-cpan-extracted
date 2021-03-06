package Prophet::CLI::Command::Config;
{
  $Prophet::CLI::Command::Config::VERSION = '0.751';
}
use Any::Moose;
use Params::Validate qw/validate/;
extends 'Prophet::CLI::Command';

with 'Prophet::CLI::TextEditorCommand';

has config_filename => (
    is      => 'rw',
    isa     => 'Str',
    lazy    => 1,
    default => sub {
        $_[0]->app_handle->config->replica_config_file;
    },
);

has old_errors => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

sub ARG_TRANSLATIONS {
    shift->SUPER::ARG_TRANSLATIONS(), a => 'add', d => 'delete', s => 'show';
}

sub usage_msg {
    my $self = shift;
    my $cmd  = $self->cli->get_script_name;

    return <<"END_USAGE";
usage: ${cmd}config [show]
       ${cmd}config edit [--global|--user]
       ${cmd}config <section.subsection.var> [<value>]
END_USAGE
}

sub run {
    my $self = shift;

    $self->print_usage if $self->has_arg('h');

    my $config = $self->config;

    if ( $self->has_arg('global') ) {
        $self->config_filename( $config->global_file );
    } elsif ( $self->has_arg('user') ) {
        $self->config_filename( $config->user_file );
    }

    # add is the same as set
    if ( $self->context->has_arg('add') && !$self->has_arg('set') ) {
        $self->context->set_arg( 'set', $self->arg('add') );
    }

    if ( $self->has_arg('set') || $self->has_arg('delete') ) {
        if ( $self->has_arg('set') ) {
            my $value = $self->arg('set');
            if ( $value =~ /^\s*(.+?)\s*=\s*(.+?)\s*$/ ) {
                my ( $key, $value ) = ( $1, $2 );
                $self->_warn_unknown_args( $key, $value );
                $config->set(
                    key      => $key,
                    value    => $value,
                    filename => $self->config_filename,
                );
            }

            # no value given, just print the current value
            else {
                $self->_warn_unknown_args( $self->arg('set') );
                my $value = $config->get( key => $self->arg('set') );
                if ( defined $value ) {
                    print $config->get( key => $self->arg('set') ) . "\n";
                } else {
                    print "Key " . $self->arg('set') . " is not set.\n";
                }
            }
        } elsif ( $self->has_arg('delete') ) {
            my $key = $self->arg('delete');

            $self->_warn_unknown_args($key);

            $config->set(
                key      => $key,
                filename => $self->config_filename,
            );
        }

    } elsif ( $self->has_arg('edit') ) {
        my $done = 0;

        die "You don't have write permissions on "
          . $self->config_filename
          . ", can't edit!\n"
          if ( -e $self->config_filename && !-w $self->config_filename )
          || !-w ( File::Spec->splitpath( $self->config_filename ) )[1];
        my $template = $self->make_template;

        while ( !$done ) {
            $done = $self->try_to_edit( template => \$template );
            $config->load;
        }
    } else {

        # if no args are given, print out the contents of the currently loaded
        # config files
        print "Configuration:\n\n";
        my @files = @{ $config->config_files };
        if ( !scalar @files ) {
            print $self->no_config_files;
            return;
        }
        print "Config files:\n\n";
        for my $file (@files) {
            print "$file\n";
        }
        print "\nYour configuration:\n\n";
        $config->dump;
    }
}

sub _warn_unknown_args {
    my $self  = shift;
    my $key   = shift;
    my $value = shift;

    # help users avoid frustration if they accidentally do something
    # like config add aliases.foo = push --to foo@bar.com
    my %args = %{ $self->args };
    for my $arg (qw(show edit add delete set user global)) {
        delete $args{$arg};
    }
    if ( keys %args != 0 ) {
        my $args_str = join( q{ }, keys %args );
        print
          "W: You have args set that aren't used by this command! Quote your\n"
          . "W: key/value if this was accidental.\n"
          . "W: - offending args: ${args_str}\n"
          . "W: - running command with key '$key'";
        print ", value '$value'" if defined $value;
        print "\n";
    }
}

sub make_template {
    my $self = shift;

    return -f $self->config_filename
      ? Prophet::Util->slurp( $self->config_filename )
      : '';
}

sub process_template {
    my $self = shift;
    my %args = validate( @_, { template => 1, edited => 1, record => 0 } );

    # Attempt parsing the config. If we're good, remove any previous error
    # sections, write to disk and load.
    eval {
        $self->config->parse_content(
            content => $args{edited},
            error   => sub {
                Config::GitLike::error_callback( @_,
                    filename => $self->config_filename );
            },
        );
    };
    if ($@) {
        chomp $@;
        my @error_lines = split "\n", $@;
        my $error = join "\n", map {"# Error: '$_'"} @error_lines;
        $self->handle_template_errors(
            rtype          => 'configuration',
            template_ref   => $args{template},
            bad_template   => $args{edited},
            errors_pattern => '',
            error          => $error,
            old_errors     => $self->old_errors,
        );
        return 0;
    }
    my $old_errors = $self->old_errors;
    Prophet::Util->write_file(
        file    => $self->config_filename,
        content => $args{edited},
    );
    return 1;
}

sub no_config_files {
    my $self = shift;
    return "No configuration files found. " . " Either create a file called
         '"
      . $self->handle->app_handle->config->replica_config_file
      . "' or set the PROPHET_APP_CONFIG environment variable.\n\n";
}

sub parse_cli_arg {
    my $self = shift;
    my ( $cmd, $arg ) = @_;

    use Text::ParseWords qw(shellwords);
    my @args = shellwords($arg);

    if ( $args[0] eq 'show' ) {
        $self->context->set_arg( show => 1 );
    } elsif ( $args[0] eq 'edit' ) {
        $self->context->set_arg( edit => 1 );
    } elsif ( $args[0] eq 'delete' ) {
        $self->_setup_delete_subcmd( "$cmd delete", @args[ 1 .. $#args ] );
    }

    # all of these may also contain add|set after alias
    # prophet alias "foo bar" = "foo baz" (1)
    # prophet alias foo = bar (1)
    # prophet alias foo =bar (2)
    # prophet alias foo bar = bar baz (1)
    # prophet alias foo bar = "bar baz" (1)
    elsif (
        $args[0] =~ /^(add|set)$/
        || ( @args >= 3 && grep {m/^=|=$/} @args )    # ex 1
        || ( @args == 2 && $args[1] =~ /^=|=$/ )
      )
    {                                                 # ex 2
        my $subcmd = defined $1 ? $1 : q{};
        shift @args if $args[0] =~ /^(?:add|set)$/;

        $self->_setup_old_syntax_add_subcmd( $cmd, $subcmd, @args );
    }

    # alternate syntax (preferred):
    # prophet alias "foo bar" "bar baz", prophet alias foo "bar baz",
    # prophet alias foo bar, etc.
    # (can still have add|set at the beginning)
    else {
        my $subcmd = q{};
        if ( $args[0] =~ /^(add|set)$/ ) {
            shift @args;
            $subcmd = $1;
        }

        $self->_setup_new_syntax_add_subcmd( $cmd, $subcmd, @args );
    }
}

sub _setup_delete_subcmd {
    my $self = shift;
    my $cmd  = shift;
    my @args = @_;

    if (@args) {
        my $remainder = join( q{ }, @args );
        $self->context->set_arg( delete => $remainder );
    } else {
        if ( $cmd =~ /delete/ ) {
            $self->print_usage(
                usage_method => sub {
                    $self->delete_usage_msg($cmd);
                },
            );
        } else {
            $self->print_usage;
        }
    }
}

sub _setup_old_syntax_add_subcmd {
    my $self   = shift;
    my $cmd    = shift;
    my $subcmd = shift;
    my @args   = @_;

    if ( @args > 1 ) {

        # divide words up into two groups split on =
        my ( @orig_words, @new_words );
        my $seen_equals = 0;
        for my $word (@args) {
            if ($seen_equals) {
                push @new_words, $word;
            } else {
                if ( $word =~ s/=$// ) {
                    $seen_equals = 1;

                    # allows syntax like alias add foo bar= bar baz
                    push @orig_words, $word if $word;
                    next;
                } elsif ( $word =~ s/^=// ) {
                    $seen_equals = 1;

                    # allows syntax like alias add foo bar =bar baz
                    push @new_words, $word if $word;
                    next;
                }
                push @orig_words, $word;
            }
        }

        # join each group together to get what we're setting
        my $orig = join( q{ }, @orig_words );
        my $new  = join( q{ }, @new_words );

        $orig = "'$orig'" if $cmd =~ /^alias/ && $orig =~ /\./;
        $self->context->set_arg( set => "$orig=$new" );
    }

    # all of these may also contain add|set after alias
    # prophet alias "foo = bar"
    # prophet alias "foo bar = foo baz"
    elsif ( defined $args[0] && $args[0] =~ /=/ ) {
        $self->context->set_arg( set => $args[0] );
    } else {

        # the only way this will be triggered is if the user types
        # "config add" or "config set"
        $self->print_usage(
            usage_method => sub {
                $self->add_usage_msg( $cmd, $subcmd );
            },
        );
    }
}

sub _setup_new_syntax_add_subcmd {
    my $self   = shift;
    my $cmd    = shift;
    my $subcmd = shift;
    my @args   = @_;

    if ( @args <= 2 ) {
        my ( $orig, $new ) = ( $args[0], $args[1] );
        $orig = "'$orig'" if $cmd =~ /alias/ && $orig =~ /\./;
        if ($new) {
            $self->context->set_arg( set => "$orig=$new" );
        } else {
            $self->context->set_arg( set => $orig );
        }
    } else {
        $self->print_usage(
            usage_method => sub {
                $self->add_usage_msg( $cmd, $subcmd );
            },
        );
    }
}

sub delete_usage_msg {
    my $self    = shift;
    my $app_cmd = $self->cli->get_script_name;
    my $cmd     = shift;

    qq{usage: ${app_cmd}${cmd} section.subsection.var\n};
}

sub add_usage_msg {
    my $self    = shift;
    my $app_cmd = $self->cli->get_script_name;
    my ( $cmd, $subcmd ) = @_;

    qq{usage: ${app_cmd}${cmd} ${subcmd} section.subsection.var ["key value"]\n};
}

__PACKAGE__->meta->make_immutable;
no Any::Moose;

1;

__END__

=pod

=head1 NAME

Prophet::CLI::Command::Config

=head1 VERSION

version 0.751

=head1 AUTHORS

=over 4

=item *

Jesse Vincent <jesse@bestpractical.com>

=item *

Chia-Liang Kao <clkao@bestpractical.com>

=item *

Christine Spang <christine@spang.cc>

=back

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2009 by Best Practical Solutions.

This is free software, licensed under:

  The MIT (X11) License

=head1 BUGS AND LIMITATIONS

You can make new bug reports, and view existing ones, through the
web interface at L<https://rt.cpan.org/Public/Dist/Display.html?Name=Prophet>.

=head1 CONTRIBUTORS

=over 4

=item *

Alex Vandiver <alexmv@bestpractical.com>

=item *

Casey West <casey@geeknest.com>

=item *

Cyril Brulebois <kibi@debian.org>

=item *

Florian Ragwitz <rafl@debian.org>

=item *

Ioan Rogers <ioanr@cpan.org>

=item *

Jonas Smedegaard <dr@jones.dk>

=item *

Kevin Falcone <falcone@bestpractical.com>

=item *

Lance Wicks <lw@judocoach.com>

=item *

Nelson Elhage <nelhage@mit.edu>

=item *

Pedro Melo <melo@simplicidade.org>

=item *

Rob Hoelz <rob@hoelz.ro>

=item *

Ruslan Zakirov <ruz@bestpractical.com>

=item *

Shawn M Moore <sartak@bestpractical.com>

=item *

Simon Wistow <simon@thegestalt.org>

=item *

Stephane Alnet <stephane@shimaore.net>

=item *

Unknown user <nobody@localhost>

=item *

Yanick Champoux <yanick@babyl.dyndns.org>

=item *

franck cuny <franck@lumberjaph.net>

=item *

robertkrimen <robertkrimen@gmail.com>

=item *

sunnavy <sunnavy@bestpractical.com>

=back

=cut
