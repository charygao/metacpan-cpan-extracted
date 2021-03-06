package App::Unliner::Program::Compiled;

use common::sense;

use POSIX;

use App::Unliner::Util;
use App::Unliner::Grammar::PostProc;
use App::Unliner::Language;



sub new {
  my ($class, %args) = @_;

  my $self = \%args;
  bless $self, $class;

  my @commands = @{ $self->_build_pipeline_commands($self->{def_name}, $self->{argv}) };

  EXPAND: while(1) {

    for my $i (0..$#commands) {
      my @command_line = @{ $commands[$i]->{shell_arg} };

      if ($self->{program}->{defs}->{$command_line[0]}) {
        @commands = (@commands[0 .. ($i-1)],
                     @{ $self->_build_pipeline_commands($command_line[0], [ @command_line[1..$#command_line] ]) },
                     @commands[($i+1)..$#commands]);
        next EXPAND;
      }
    }

    last EXPAND;

  }

  $self->{compiled_commands} = \@commands;

  return $self;
}



sub _build_pipeline_commands {
  my ($self, $def_name, $argv) = @_;

  my $def = $self->{program}->{defs}->{$def_name};

  my $def_body = App::Unliner::Grammar::PostProc::brace_block($def->{brace_block}->{''});
  my $def_modifiers = $self->_parse_def_modifiers($def->{def_modifier});
  my $def_prototype = $def->{prototype};

  my $cmd = $def_modifiers->{cmd};

  my $language_package = $App::Unliner::Language::registry->{$cmd} || die "language not specified";

  ## FIXME: find better way to require
  my $pm_file = $language_package;
  $pm_file =~ s{::}{/}g;
  $pm_file = "$pm_file.pm";
  require $pm_file;

  return $language_package->render_as_pipeline(
                              def_name => $def_name,
                              argv => $argv,
                              def_body => $def_body,
                              def_modifiers => $def_modifiers,
                              def_prototype => $def_prototype,
                            );
}



sub _parse_def_modifiers {
  my ($self, $def_modifiers) = @_;

  my $output = {};

  foreach my $def_modifier (@{$def_modifiers}) {
    my $args = $def_modifier->{shell_arg};
    my $cmd = shift @$args;

    $output->{args}->{$cmd} = $args;

    if ($App::Unliner::Language::registry->{$cmd}) {
      die "$cmd def modifier not compatible with $output->{cmd}" if defined $output->{cmd};
      $output->{cmd} = $cmd;
    }
  }

  $output->{cmd} ||= 'sh';

  return $output;
}


sub optimise {
  my ($self) = @_;

  my $commands = $self->{compiled_commands};



  ## Internal cat pass

  my @tmp_commands;
  my $internal_cats_removed = 0;

  foreach my $command (@$commands) {
    if ($command->{shell_arg}->[0] eq 'cat' &&
        @{$command->{shell_arg}} == 1 &&
        $command != $commands->[0] &&
        $command != $commands->[-1]) {
      $internal_cats_removed++;
      next;
    }

    push @tmp_commands, $command;
  }

  if ($internal_cats_removed) {
    debug_log("OPT: removed $internal_cats_removed internal cats");
    $commands = \@tmp_commands; 
  }




  ## Leading cat pass

  if (@$commands > 1) {

    my $first_command = $commands->[0]->{shell_arg};

    if ($first_command->[0] eq 'cat') {
      if (@$first_command == 1) {
        debug_log("OPT: optimised away empty leading cat");
        shift @$commands;
      }
      if (@$first_command == 2) {
        my $file = $first_command->[1];
        debug_log("OPT: optimised away leading cat, opening file '$file' as STDIN");
        if (!open(STDIN, '<', $file)) {
          say STDERR "cat: $file: No such file or directory";
          exit(1);
        }
        shift @$commands;
      }
    }


    ## Trailing cat pass

    my $last_command = $commands->[-1]->{shell_arg};

    if ($last_command->[0] eq 'cat' && @$last_command == 1) {
      if (-t STDOUT) {
        debug_log("OPT: did *NOT* optimise away trailing cat because STDOUT is a terminal");
      } else {
        debug_log("OPT: optimised away trailing cat");
        pop @$commands;
      }
    }

  }


  $self->{compiled_commands} = $commands;

  return $self;
}






sub execute {
  my ($self) = @_;

  my $commands = $self->{compiled_commands};

  if ($ENV{UNLINER_DEBUG}) {
    print STDERR "unliner: CMD: ";

    foreach my $command (@$commands) {
      my @exec_args = @{$command->{shell_arg}};
      print STDERR join(' ', map { App::Unliner::Util::re_shell_quote($_) } @exec_args);
      print STDERR ' | ' unless $command == $commands->[-1];
    }

    print STDERR "\n";
  }




  my $prev_r;

  foreach my $command (@$commands) {
    my ($r, $w);
    pipe $r, $w;

    if (!fork) {
      POSIX::dup2(fileno($prev_r), 0) || die "dup2(,0): $!" unless $command == $commands->[0];
      POSIX::dup2(fileno($w), 1) || die "dup2(,1) $!" unless $command == $commands->[-1];

      my @exec_args = @{$command->{shell_arg}};

      $ENV{$_} = $command->{env}->{$_} foreach (keys %{$command->{env}});

      exec(@exec_args);
      die "couldn't exec $exec_args[0]: $!";
    }

    $prev_r = $r;
  }

  #say STDERR 'reaped ' . 
  waitpid(-1, 0) . " ($?)" for 1..@$commands;

  return $self;
}



1;
