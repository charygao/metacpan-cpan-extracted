
#############################################################################
## $Id: ClusterNode.pm 3666 2006-03-11 20:34:10Z spadkins $
#############################################################################

package App::Context::ClusterNode;
$VERSION = (q$Revision: 3666 $ =~ /(\d[\d\.]*)/)[0];  # VERSION numbers generated by svn

use App;
use App::Context::Server;

@ISA = ( "App::Context::Server" );

use Date::Format;

use strict;

=head1 NAME

App::Context::ClusterNode - a runtime environment for a Cluster Node that serves a Cluster Controller

=head1 SYNOPSIS

   # ... official way to get a Context object ...
   use App;
   $context = App->context();
   $config = $context->config();   # get the configuration
   $config->dispatch_events();     # dispatch events

   # ... alternative way (used internally) ...
   use App::Context::ClusterNode;
   $context = App::Context::ClusterNode->new();

=cut

sub _init2a {
    &App::sub_entry if ($App::trace);
    my ($self, $options) = @_;
    $self->{controller_host} = $options->{controller_host};
    $self->{controller_port} = $options->{controller_port};
    die "Node must have a controller host and port defined (\$context->{options}{controller_host} and {controller_port})"
        if (!$self->{controller_host} || !$self->{controller_port});
    &App::sub_exit() if ($App::trace);
}

sub _init2b {
    &App::sub_entry if ($App::trace);
    my ($self, $options) = @_;
    # nothing yet
    &App::sub_exit() if ($App::trace);
}

sub dispatch_events_begin {
    &App::sub_entry if ($App::trace);
    my ($self) = @_;
    $self->log({level=>2},"Starting Cluster Node on $self->{host}:$self->{port}\n");
    my $node_heartbeat  = $self->{options}{node_heartbeat} || 60;
    $self->schedule_event(
        method => "send_node_status",
        time => time(),  # immediately ...
        interval => $node_heartbeat,  # and every X seconds hereafter
    );
    &App::sub_exit() if ($App::trace);
}

sub dispatch_events_end {
    &App::sub_entry if ($App::trace);
    my ($self) = @_;
    $self->log({level=>2},"Stopping Cluster Node\n");
    my $controller_host = $self->{controller_host};
    my $controller_port = $self->{controller_port};
    my $node_host       = $self->{host};
    my $node_port       = $self->{port};
    # We need to close the listen socket before we do a synchronous connection to the controller
    # in order to avoid deadlock.
    $self->close_listen_socket();
    # This message needs to be synchronous, otherwise the parent will kill the subprocess during shutdown.
    $self->send_message($controller_host, $controller_port, "NODE-DOWN:$node_host:$node_port");
    &App::sub_exit() if ($App::trace);
}

sub send_node_status {
    &App::sub_entry if ($App::trace);
    my ($self) = @_;
    my $controller_host = $self->{controller_host};
    my $controller_port = $self->{controller_port};
    my $node_host       = $self->{host};
    my $node_port       = $self->{port};
    my $values          = $self->system_values();
    $self->send_async_message($controller_host, $controller_port, "NODE-UP:$node_host:$node_port:$values");
    &App::sub_exit() if ($App::trace);
}

sub system_values {
    &App::sub_entry if ($App::trace);
    my ($self) = @_;
    my $info = $self->get_sys_info();
    my $memfree = $info->{memfree} + $info->{buffers} + $info->{cached};
    my $values = "load=$info->{load},memfree=$memfree,memtotal=$info->{memtotal},swapfree=$info->{swapfree},swaptotal=$info->{swaptotal}";
    &App::sub_exit($values) if ($App::trace);
    return($values);
}

sub process_msg {
    &App::sub_entry if ($App::trace);
    my ($self, $msg) = @_;
    my $verbose = $self->{verbose};
    $self->log({level=>3},"process_msg: [$msg]\n");
    my $return_value = $self->process_custom_msg($msg);
    if (!$return_value) {
        if ($msg =~ /^ASYNC-EVENT:([^:]+):([^:]+):([^:]+):(.*)$/) {
            my %event = (
                service_type => $1,
                name         => $2,
                method       => $3,
            );
            my $args = $4;
            $event{args} = $self->{rpc_serializer}->deserialize($args) if ($args ne "");
            my $event_token = $self->send_async_event({method => "process_async_event", args => [\%event],});
            $event{event_token} = $event_token;
            $return_value = "ASYNC-EVENT-TOKEN:$event_token\n";
        }
        elsif ($msg =~ /^CONTROLLER-UP:/) {
            my $controller_host = $self->{controller_host};
            my $controller_port = $self->{controller_port};
            my $node_host       = $self->{host};
            my $node_port       = $self->{port};
            $self->send_async_event({
                method => "send_async_message",
                args => [ $controller_host, $controller_port, "NODE-UP:$node_host:$node_port" ],
            });
            $return_value = "OK";
        }
        elsif ($msg =~ /^ABORT-ASYNC-EVENT:(.*)/) {
            my $event_token = $1;
            $self->abort_async_event($event_token);
            $return_value = "OK";
        }
        else {
            $return_value = "ERROR: unknown [$msg]";
        }
    }
    &App::sub_exit($return_value) if ($App::trace);
    return($return_value);
}

# Can be overridden to provide customized processing.
sub process_custom_msg {
    &App::sub_entry if ($App::trace);
    my ($self, $msg) = @_;
    my $return_value = "";
    &App::sub_exit($return_value) if ($App::trace);
    return($return_value);
}

sub state {
    &App::sub_entry if ($App::trace);
    my ($self) = @_;

    my $datetime = time2str("%Y-%m-%d %H:%M:%S", time());
    my $state = "Cluster Node: $self->{host}:$self->{port}  procs[$self->{num_procs}/$self->{max_procs}:max]  async_events[$self->{num_async_events}/$self->{max_async_events}:max]\n[$datetime]\n";
    $state .= "\n";
    $state .= $self->_state();

    &App::sub_exit($state) if ($App::trace);
    return($state);
}

sub _state {
    &App::sub_entry if ($App::trace);
    my ($self) = @_;

    my $state = "";

    $state .= $self->SUPER::_state();

    &App::sub_exit($state) if ($App::trace);
    return($state);
}

sub process_async_event {
    &App::sub_entry if ($App::trace);
    my ($self, $event) = @_;
    my ($results);
    eval {
        $results = $self->send_event($event);
    };
    if ($@) {
        $results = $@;
    }
    $results =~ s/\s*\n\s*/ /gs;  # we can't have multi-line result text
    my $results_txt = $self->{rpc_serializer}->serialize($results);
    my $msg = "ASYNC-EVENT-RESULTS:$event->{event_token}:$results_txt";
    $self->send_message($self->{controller_host}, $self->{controller_port}, $msg);
    &App::sub_exit() if ($App::trace);
}

sub finish_killed_async_event {
    &App::sub_entry if ($App::trace);
    my ($self, $event) = @_;
    my $results_txt = $self->{rpc_serializer}->serialize("Subrequest Killed");
    my $msg = "ASYNC-EVENT-RESULTS:$event->{event_token}:$results_txt";
    $self->send_async_message($self->{controller_host}, $self->{controller_port}, $msg);
    &App::sub_exit() if ($App::trace);
}

1;

