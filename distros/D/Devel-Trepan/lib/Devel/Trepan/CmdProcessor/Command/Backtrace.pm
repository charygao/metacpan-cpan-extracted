# Copyright (C) 2011-2012, 2014-2015, 2018 Rocky Bernstein <rocky@cpan.org>
use warnings; no warnings 'redefine';

use rlib '../../../..';

package Devel::Trepan::CmdProcessor::Command::Backtrace;
use if !@ISA, Devel::Trepan::CmdProcessor::Command ;

use Getopt::Long qw(GetOptionsFromArray);

unless (@ISA) {
    eval <<"EOE";
use constant ALIASES    => qw(bt where T);
use constant CATEGORY   => 'stack';
use constant SHORT_HELP => 'Print backtrace of stack frames';
use constant MIN_ARGS   => 0;   # Need at least this many
use constant MAX_ARGS   => 4;   # Need at most this many - undef -> unlimited.
use constant NEED_STACK => 1;
EOE
}

use strict; use vars qw(@ISA); @ISA = @CMD_ISA;
use vars @CMD_VARS;  # Value inherited from parent

our $NAME = set_name();
=pod

=head2 Synopsis:

=cut
our $HELP = <<'HELP';
=pod

B<backtrace> [I<options>] [I<count>]

Print backtrace of all stack frames, or innermost *count* frames.

With a negative argument, print outermost -I<count> frames.

In the listing produced, an arrow, C<--E<gt>>, indicates the 'current
frame'. The current frame determines the context used for many
debugger commands such as source-line listing
(L<C<list>|Devel::Trepan::CmdProcessor::Command::List>) or the
L<C<edit>|Devel::Trepan::CmdProcessor::Command::Edit> command.

I<optionss> are:

   -d | --deparse - show deparsed call position
   -s | --source  - show source code line
   -f | --full    - locals of each frame
   -h | --help    - give this help

=head2 Examples:

   backtrace      # Print a full stack trace
   backtrace 2    # Print only the top two entries
   backtrace -1   # Print a stack trace except the initial (least recent) call.
   backtrace -s   # show source lines in listing
   backtrace -d   # show deparsed source lines in listing
   backtrace -f   # show with locals
   backtrace -df  # show with deparsed calls and locals
   backtrace --deparse --full   # same as above

=head2 See also:

L<C<up>|Devel::Trepan::CmdProcessor::Command::Up>,
L<C<down>|Devel::Trepan::CmdProcessor::Command::Down>, and
L<C<frame>|Devel::Trepan::CmdProcessor::Command::Frame>,

=cut
HELP

sub complete($$)
{
    my ($self, $prefix) = @_;
    $self->{proc}->frame_complete($prefix);
}

my $DEFAULT_OPTIONS = {
    help      => 0,       # show source line in backtrace?
    deparse   => 0,       # show deparse in backtrace?
    full      => 0,       # show "locals"?
    source    => 0,       # show source line in backtrace?

};

sub parse_options($$)
{
    my ($self, $args) = @_;
    $Getopt::Long::autoabbrev = 1;
    my %opts = %{$DEFAULT_OPTIONS};
    my $result = &GetOptionsFromArray($args,
          'h|help' =>    \$opts{help},
          'd|deparse' => \$opts{deparse},
          's|source' => \$opts{source},
          'f|full'   => \$opts{full},
        );
    %opts;
}

# This method runs the command
sub run($$)
{
    my ($self, $args) = @_;
    my $proc = $self->{proc};
    my %cmd_opts = $self->parse_options($args);
    my $opts = {
        basename    => $proc->{settings}{basename},
        current_pos => $proc->{frame_index},
        maxstack    => $proc->{settings}{maxstack},
        maxwidth    => $proc->{settings}{maxwidth},
        displayop   => $proc->{settings}{displayop},
        deparse     => $cmd_opts{deparse},
        source      => $cmd_opts{source},
        full        => $cmd_opts{full},
    };
    if ($cmd_opts{help}) {
	my $help_cmd = $proc->{commands}{help};
	$help_cmd->run( ['help', 'backtrace'] );
	return
    }

    my $stack_size = $proc->{stack_size};
    my $count = $stack_size;
    if (scalar @$args > 1) {
        $count =
            $proc->get_an_int($args->[1],
                              {cmdname   => $self->name,
                               min_value => -$stack_size,
			      });
        return unless defined $count;
    }
    $opts->{count} = $count;
    my @frames = $self->{dbgr}->tbacktrace($count-1);
    $self->{proc}->print_stack_trace(\@frames, $opts);
}

unless(caller) {
    # FIXME: DRY this code by putting in common location.
    require Devel::Trepan::DB;
    require Devel::Trepan::Core;
    my $db = Devel::Trepan::Core->new;
    my $intf = Devel::Trepan::Interface::User->new(undef, undef, {readline => 0});
    my $proc = Devel::Trepan::CmdProcessor->new([$intf], $db);

    $proc->{stack_size} = 0;
    my $cmd = __PACKAGE__->new($proc);
    $cmd->run([$NAME]);
    $cmd->run([$NAME, 1000]);
}

1;
