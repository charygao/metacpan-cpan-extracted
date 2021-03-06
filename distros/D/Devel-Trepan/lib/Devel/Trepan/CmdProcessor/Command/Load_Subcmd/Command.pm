# -*- coding: utf-8 -*-
# Copyright (C) 2012, 2014, 2018 Rocky Bernstein <rocky@cpan.org>
use warnings; no warnings 'redefine';
use rlib '../../../../..';

package Devel::Trepan::CmdProcessor::Command::Load::Command;
use Cwd 'abs_path';

# FIXME: allow specifying just the Perl module name,
# e.g. File::Basename a command name, e.g. alias.

use Devel::Trepan::CmdProcessor::Command::Subcmd::Core;

use strict;
our (@ISA, @SUBCMD_VARS);
# Values inherited from parent
use vars @Devel::Trepan::CmdProcessor::Command::Subcmd::SUBCMD_VARS;

unless (@ISA) {
    eval <<"EOE";
    use constant MAX_ARGS => undef;  # unlimited.
EOE
}

@ISA = qw(Devel::Trepan::CmdProcessor::Command::Subcmd);

=pod

=head2 Synopsis:

=cut

our $HELP = <<'HELP';
=pod

B<load commmand> {I<file-or-directory-name-1> [I<file-or-directory-name-2>...]}

Load debugger commands or directories containing debugger
commands. This is also useful if you want add, change, or fix a debugger
command while inside the debugger.
=cut
HELP

our $SHORT_HELP = 'Load debugger command(s)';
our $MIN_ABBREV = length('co');

sub complete($$)
{
    my ($self, $prefix) = @_;
    $self->{proc}->filename_complete($prefix);
}

sub run($$)
{
    my ($self, $args) = @_;
    my $proc = $self->{proc};
    my @args = @$args; shift @args; shift @args;
    foreach my $file_or_dir (@args) {
        my @errs = $proc->load_debugger_commands($file_or_dir);
	if(@errs) {
	    $proc->errmsg("Devel::Trepan command $file_or_dir failed");
	    $proc->errmsg(join("\n", @errs));
	} else {
	    $proc->msg("Devel::Trepan command $file_or_dir loaded ok");
	}
    }
}

unless (caller) {
    require Devel::Trepan;
    # Demo it.
    # require_relative '../../mock'
    # my($dbgr, $parent_cmd) = MockDebugger::setup('show');
    # $cmd = __PACKAGE__->new(parent_cmd);
    # $cmd->run(@$cmd->prefix);
}

# Suppress a "used-once" warning;
$HELP || scalar @SUBCMD_VARS;
