# -*- coding: utf-8 -*-
# Copyright (C) 2011-2014 Rocky Bernstein <rocky@cpan.org>
# largely rewritten from perl5db.

use Class::Struct;
use strict;

struct DBBreak => {
    id          => '$', # breakpoint/action number
    enabled     => '$', # True if breakpoint or action is enabled
    type        => '$', # 'tbrkpt', 'brkpt' or 'action'
    condition   => '$', # Condition to evaluate or '1' fo unconditional
                        # if type is 'action' this is the action to run
    hits        => '$', # Number of times the breakpoint/action hit
    negate      => '$', # break/step if ... or until .. ?
    filename    => '$',
    line_num    => '$'
};

package DBBreak;
sub inspect($)
{
    my $self = shift;
    sprintf("id %d, file %s, line %s, type: %s, enabled: %d, negate %s, hits: %s, cond: %s",
            $self->id,
            $self->filename, $self->line_num,
            $self->type,
            $self->enabled,
            $self->negate || 0,
            $self->hits, $self->condition
        );
};

sub icon_char($)
{
    my $self = shift;
    if ('tbrkpt' eq $self->type) {
        return 'T';
    } elsif ('brkpt' eq $self->type) {
        return 'B';
    } elsif ('action' eq $self->type) {
        return 'A';
    }
}

package DB;
use vars qw($brkpt $package $lineno $max_bp $max_action);
use strict; use warnings; no warnings 'redefine';
use English qw( -no_match_vars );
use Scalar::Util;

use rlib '../../..';
use Devel::Trepan::DB::LineCache;  # For eval_ok

BEGIN {
    $DB::brkpt   = undef; # current breakpoint
    $max_bp = $max_action = 0;
}

# return info on lines with actions
sub line_events {
  my $s = shift;
  my $fname = shift;
  my(%ret) = ();
  $fname = $DB::filename unless $fname;
  local(*DB::dbline) = "::_<$fname";
  for (my $i = 1; $i <= $#DB::dbline; $i++) {
    $ret{$i} = $DB::dbline[$i] if defined $DB::dbline{$i};
  }
  return %ret;
}

# Find a subroutine. Return ($filename, $fn_name, $start_line);
# If not found, return (undef, undef, undef);
sub find_subline($;$) {
    my $fn_name = shift;
    $fn_name =~ s/\'/::/;
    $fn_name = "${DB::package}\:\:" . $fn_name if $fn_name !~ /::/;
    $fn_name = "main" . $fn_name if substr($fn_name,0,2) eq "::";
    my $filename = $DB::filename;
    if (exists $DB::sub{$fn_name}) {
        my($filename, $from, $to) = ($DB::sub{$fn_name} =~ /^(.*):(\d+)-(\d+)$/);
        if ($from) {
            local *DB::dbline = "::_<$filename";
            return ($filename, $fn_name, $from);
        }
    }
    return (undef, undef, undef);
}

# Return a warning message if breakpoint position is invalid.
# undef is returned if the breakpont is valid.
sub break_invalid {
    my ($s, $filename_ref, $fn_or_lineno) = @_;
    my $filename = $$filename_ref;
    $filename = $DB::filename unless defined $filename;
    my $change_dbline = $filename ne $DB::filename;
    $fn_or_lineno ||= $DB::lineno;

    # If we're not in that file, switch over to it.
    if ( $change_dbline ) {
        # Switch debugger's magic structures.
        my $filekey = '_<' . $filename;
        *DB::dbline   = $main::{ $filekey } if exists $main::{ $filekey };
    }

    my $lineno = $fn_or_lineno;
    if ($fn_or_lineno =~ /\D/) {
        my $junk;
        ($filename, $junk, $lineno) = find_subline($fn_or_lineno) ;
        unless ($lineno) {
            *DB::dbline   = $main::{ '_<' . $DB::filename } if $change_dbline;
            return "Subroutine $fn_or_lineno not found"
        }
        $change_dbline = $filename ne $DB::filename;
        if ( $change_dbline ) {
            # Switch debugger's magic structures.
            my $filekey = '_<' . $filename;
            *DB::dbline   = $main::{ $filekey } if exists $main::{ $filekey };
        }
	$$filename_ref = $filename;
	return undef;
    } else {
	if (!defined($DB::dbline[$lineno]) || $DB::dbline[$lineno] == 0) {
	    *DB::dbline   = $main::{ '_<' . $DB::filename } if $change_dbline;
	    $$filename_ref = $filename;
	    return "Line $lineno of $filename not known to be a trace line";
	}
    }
    return undef;
}

=head2 set_breakpoint

# Set a breakpoint, temporary breakpoint, or action.

=cut
sub set_break {
    my ($s, $filename, $fn_or_lineno, $cond, $id, $type, $enabled, $force) = @_;
    $filename = $DB::filename unless defined $filename;
    my $change_dbline = $filename ne $DB::filename;
    $type = 'brkpt' unless defined $type;
    $enabled = 1 unless defined $enabled;
    $fn_or_lineno ||= $DB::lineno;
    $cond ||= '1';

    # If we're not in that file, switch over to it.
    if ( $change_dbline ) {
        # Switch debugger's magic structures.
        my $filekey = '_<' . $filename;
        *DB::dbline   = $main::{ $filekey } if exists $main::{ $filekey };
    }

    my $lineno = $fn_or_lineno;
    my $function = undef;
    if ($fn_or_lineno =~ /\D/) {
        my $junk;
        ($filename, $function, $lineno) = find_subline($fn_or_lineno, $filename) ;
        unless ($lineno) {
            $s->warning("Subroutine $fn_or_lineno not found.\n");
            *DB::dbline   = $main::{ '_<' . $DB::filename } if $change_dbline;
            return undef;
        }
        $change_dbline = $filename ne $DB::filename;
        if ( $change_dbline ) {
            # Switch debugger's magic structures.
            my $filekey = '_<' . $filename;
            *DB::dbline   = $main::{ $filekey } if exists $main::{ $filekey };
        }
    } else {
	unless (is_breakable($filename, $lineno) || $force) {
	    $s->warning("Line $lineno of $filename not known to be a trace line.\n");

	    *DB::dbline   = $main::{ '_<' . $DB::filename } if $change_dbline;
	    return undef;
	}
    }
    unless (defined $id) {
        if ($type eq 'action') {
            $id = ++$max_action;
        } else {
            $id = ++$max_bp;
        }
    }
    my $brkpt = DBBreak->new(
        type      => $type,
        condition => $cond,
        id        => $id,
        hits      => 0,
        enabled   => $enabled,
        filename  => $filename,
        line_num  => $lineno
        );

    my $ary_ref;
    if (defined($function)) {
	$DB::fn_brkpt{$function} = [] unless exists $DB::fn_brkpt{$fn_or_lineno};
	$ary_ref = $DB::fn_brkpt{$function};
    } else {
	$DB::dbline{$lineno} = [] unless (exists $DB::dbline{$lineno});
	$ary_ref = $DB::dbline{$lineno};
    }
    push @$ary_ref, $brkpt;
    *DB::dbline   = $main::{ '_<' . $DB::filename } if $change_dbline;
    return $brkpt;
}

=head2 is_breakable

Return 1 if C<$filename> has code associated with C<$lineno>; 0 otherwise.

=cut
# Return 1 if $lineno is
sub is_breakable {
    my($filename, $lineno) = @_;
    return defined($DB::dbline[$lineno]) && ($DB::dbline[$lineno] != 0)
}

# Set a temporary breakpoint
sub set_tbreak {
    my ($s, $filename, $lineno, $cond, $id) = @_;
    return set_break($s, $filename, $lineno, $cond, $id, 'tbrkpt');
}

sub delete_bp($$) {
    my ($s, $bp) = @_;
    my $i = $bp->line_num;
    my $file_key = '_<' . $bp->filename;
    return unless exists $main::{ $file_key };
    local *dbline   = $main::{ $file_key };
    if (defined $DB::dbline{$i}) {
        my $brkpts = $DB::dbline{$i};
        my $count = 0;
        my $break_count = scalar @$brkpts;
        for (my $j=0; $j <= $break_count; $j++) {
            $brkpt = $brkpts->[$j];
            next unless defined $brkpt;
            if ($brkpt eq $bp) {
                undef $brkpts->[$j];
                last;
            }
            $count++;
        }
        delete $DB::dbline{$i} if $count == 0;
    }
}

sub clr_breaks {
    my $s = shift;
    my $i;
    if (@_) {
        while (@_) {
            $i = shift;
            $i = _find_subline($i) if ($i =~ /\D/);
            $s->output("Subroutine not found.\n") unless $i;
            if (defined $DB::dbline{$i}) {
                my $brkpts = $DB::dbline{$i};
                my $j = 0;
                for my $brkpt (@$brkpts) {
                    if ($brkpt->action ne 'brkpt') {
                        $j++;
                        next;
                    }
                    undef $brkpts->[$j];
                }
                delete $DB::dbline{$i} if $j == 0;
            }
        }
    } else {
        for ($i = 1; $i <= $#DB::dbline ; $i++) {
            if (defined $DB::dbline{$i}) {
                clr_breaks($s, $i);
            }
        }
    }
}

# Set a an action
sub set_action {
    my ($s, $lineno, $filename, $action, $id) = @_;
    return set_break($s, $filename, $lineno, $action, $id, 'action');
}

# FIXME: combine with clear_breaks
sub clr_actions {
    my $s = shift;
    my $i;
    if (@_) {
        while (@_) {
            $i = shift;
            $i = _find_subline($i) if ($i =~ /\D/);
            $s->output("Subroutine not found.\n") unless $i;
            if (defined $DB::dbline{$i}) {
                my $brkpts = $DB::dbline{$i};
                my $j = 0;
                for my $brkpt (@$brkpts) {
                    if ($brkpt->action ne 'action') {
                        $j++;
                        next;
                    }
                    undef $brkpts->[$j];
                }
                delete $DB::dbline{$i} if $j == 0;
            }
        }
    } else {
        for ($i = 1; $i <= $#DB::dbline ; $i++) {
            if (defined $DB::dbline{$i}) {
                clr_breaks($s, $i);
            }
        }
    }
}

# Demo it.
unless (caller) {
    my $brkpt = DBBreak->new(
        filename => __FILE__, line_num => __LINE__,
        type=>'action', condition=>'1', id=>1, hits => 0, enbled => 1,
        negate => 0
        );
    print $brkpt->inspect, "\n";
    # This line is a comment for below.
    $DB::filename = __FILE__;
    my $filename = __FILE__;
    my $msg = break_invalid(undef, \$filename, __LINE__ - 3);
    print $msg, "\n";
}

1;
