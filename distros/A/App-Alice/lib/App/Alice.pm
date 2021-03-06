package App::Alice;

use Text::MicroTemplate::File;
use App::Alice::Window;
use App::Alice::InfoWindow;
use App::Alice::HTTPD;
use App::Alice::IRC;
use App::Alice::Signal;
use App::Alice::Config;
use App::Alice::Logger;
use App::Alice::History;
use Any::Moose;
use File::Copy;
use Digest::MD5 qw/md5_hex/;
use List::Util qw/first/;
use Encode;

our $VERSION = '0.19';

has condvar => (
  is       => 'rw',
  isa      => 'AnyEvent::CondVar'
);

has config => (
  is       => 'ro',
  isa      => 'App::Alice::Config',
);

has msgid => (
  is        => 'rw',
  isa       => 'Int',
  default   => 1,
);

sub next_msgid {$_[0]->msgid($_[0]->msgid + 1)}

has _ircs => (
  is      => 'rw',
  isa     => 'ArrayRef',
  default => sub {[]},
);

sub ircs {@{$_[0]->_ircs}}
sub add_irc {push @{$_[0]->_ircs}, $_[1]}
sub has_irc {$_[0]->get_irc($_[1])}
sub get_irc {first {$_->alias eq $_[1]} $_[0]->ircs}
sub remove_irc {$_[0]->_ircs([ grep { $_->alias ne $_[1] } $_[0]->ircs])}
sub irc_aliases {map {$_->alias} $_[0]->ircs}
sub connected_ircs {grep {$_->is_connected} $_[0]->ircs}

has standalone => (
  is      => 'ro',
  isa     => 'Bool',
  default => 1,
);

has httpd => (
  is      => 'rw',
  isa     => 'App::Alice::HTTPD',
  lazy    => 1,
  default => sub {
    App::Alice::HTTPD->new(app => shift);
  },
);

has commands => (
  is      => 'ro',
  isa     => 'App::Alice::Commands',
  lazy    => 1,
  default => sub {
    App::Alice::Commands->new(app => shift);
  }
);

has notifier => (
  is      => 'ro',
  lazy    => 1,
  default => sub {
    my $self = shift;
    my $notifier;
    eval {
      if ($^O eq 'darwin') {
        # 5.10 doesn't seem to put Extras in @INC
        # need this for Foundation.pm
        if ($] >= 5.01 and -e "/System/Library/Perl/Extras/5.10.0") {
          require lib;
          lib->import("/System/Library/Perl/Extras/5.10.0"); 
        }
        require App::Alice::Notifier::Growl;
        $notifier = App::Alice::Notifier::Growl->new;
      }
      elsif ($^O eq 'linux') {
        require App::Alice::Notifier::LibNotify;
        $notifier = App::Alice::Notifier::LibNotify->new;
      }
    };
    $self->log(info => "Notifications disabled") unless $notifier;
    return $notifier;
  }
);

has history => (
  is      => 'rw',
  lazy    => 1,
  default => sub {
    my $self = shift;
    my $config = $self->config->path."/log.db";
    if (-e $config) {
      if ((stat($config))[9] < 1272757679) {
        print STDERR "Log schema is out of date, updating\n";
        copy($self->config->assetdir."/log.db", $config);
      }
    }
    else {
      copy($self->config->assetdir."/log.db", $config);
    }
    App::Alice::History->new(
      dbfile => $self->config->path ."/log.db"
    );
  },
);

sub store {
  my $self = shift;
  my %fields = @_;
  $fields{user} = $self->user;
  $fields{time} = time;
  $self->history->store(%fields);
}

has logger => (
  is        => 'ro',
  default   => sub {App::Alice::Logger->new},
);

sub log {$_[0]->logger->log($_[1] => $_[2]) if $_[0]->config->show_debug}

has _windows => (
  is        => 'rw',
  isa       => 'ArrayRef',
  default   => sub {[]},
);

sub windows {@{$_[0]->_windows}}
sub add_window {push @{$_[0]->_windows}, $_[1]}
sub has_window {$_[0]->get_window($_[1])}
sub get_window {first {$_->id eq $_[1]} $_[0]->windows}
sub remove_window {$_[0]->_windows([grep {$_->id ne $_[1]} $_[0]->windows])}
sub window_ids {map {$_->id} $_[0]->windows}

has 'template' => (
  is => 'ro',
  isa => 'Text::MicroTemplate::File',
  lazy => 1,
  default => sub {
    my $self = shift;
    Text::MicroTemplate::File->new(
      include_path => $self->config->assetdir . '/templates',
      cache        => 1,
    );
  },
);

has 'info_window' => (
  is => 'ro',
  isa => 'App::Alice::InfoWindow',
  lazy => 1,
  default => sub {
    my $self = shift;
    my $info = App::Alice::InfoWindow->new(
      assetdir => $self->config->assetdir,
      app      => $self,
    );
    $self->add_window($info);
    return $info;
  }
);

has 'shutting_down' => (
  is => 'rw',
  default => 0,
  isa => 'Bool',
);

has 'user' => (
  is => 'ro',
  default => $ENV{USER}
);

sub BUILDARGS {
  my ($class, %options) = @_;
  my $self = {standalone => 1};
  for (qw/standalone history notifier template user/) {
    if (exists $options{$_}) {
      $self->{$_} = $options{$_};
      delete $options{$_};
    }
  }
  $self->{config} = App::Alice::Config->new(%options);
  # some options get overwritten by the config
  # so merge options again
  $self->{config}->merge(\%options);
  return $self;
}

sub run {
  my $self = shift;
  # initialize lazy stuff
  $self->commands;
  $self->history;
  $self->info_window;
  $self->template;
  $self->httpd;
  $self->notifier;

  print STDERR "Location: http://".$self->config->http_address.":".$self->config->http_port."/\n"
    if $self->standalone;

  $self->add_irc_server($_, $self->config->servers->{$_})
    for keys %{$self->config->servers};
  
  if ($self->standalone) { 
    $self->condvar(AnyEvent->condvar);
    my @sigs;
    for my $sig (qw/INT QUIT/) {
      my $w = AnyEvent->signal(
        signal => $sig,
        cb     => sub {App::Alice::Signal->new(app => $self, type => $sig)}
      );
      push @sigs, $w;
    }

    $self->condvar->recv;
  }
}

sub init_shutdown {
  my ($self, $cb, $msg) = @_;
  $self->{on_shutdown} = $cb;
  $self->shutting_down(1);
  $self->history(undef);
  $self->alert("Alice server is shutting down");
  if ($self->connected_ircs) {
    print STDERR "\nDisconnecting, please wait\n" if $self->standalone;
    $_->init_shutdown($msg) for $self->connected_ircs;
  }
  else {
    print "\n";
    $self->shutdown;
    return;
  }
  $self->{shutdown_timer} = AnyEvent->timer(
    after => 3,
    cb    => sub{$self->shutdown}
  );
}

sub shutdown {
  my $self = shift;
  $self->_ircs([]);
  $self->httpd->shutdown;
  $_->buffer->clear for $self->windows;
  delete $self->{shutdown_timer} if $self->{shutdown_timer};
  $self->{on_shutdown}->() if $self->{on_shutdown};
  $self->condvar->send if $self->condvar;
}

sub handle_command {
  my ($self, $command, $window) = @_;
  $self->commands->handle($command, $window);
}

sub reload_commands {
  my $self = shift;
  $self->commands->reload_handlers;
}

sub merge_config {
  my ($self, $new_config) = @_;
  for my $newserver (values %$new_config) {
    if (! exists $self->config->servers->{$newserver->{name}}) {
      $self->add_irc_server($newserver->{name}, $newserver);
    }
    for my $key (keys %$newserver) {
      $self->config->servers->{$newserver->{name}}{$key} = $newserver->{$key};
    }
  }
}

sub tab_order {
  my ($self, $window_ids) = @_;
  my $order = [];
  for my $count (0 .. scalar @$window_ids - 1) {
    if (my $window = $self->get_window($window_ids->[$count])) {
      next unless $window->is_channel
           and $self->config->servers->{$window->irc->alias};
      push @$order, $window->title;
    }
  }
  $self->config->order($order);
  $self->config->write;
}

sub with_messages {
  my ($self, $cb) = @_;
  $_->buffer->with_messages($cb) for $self->windows;
}

sub find_window {
  my ($self, $title, $connection) = @_;
  return $self->info_window if $title eq "info";
  my $id = $self->_build_window_id($title, $connection->alias);
  if (my $window = $self->get_window($id)) {
    return $window;
  }
}

sub alert {
  my ($self, $message) = @_;
  return unless $message;
  $self->broadcast({
    type => "action",
    event => "alert",
    body => $message,
  });
}

sub create_window {
  my ($self, $title, $connection) = @_;
  my $id = $self->_build_window_id($title, $connection->alias);
  my $window = App::Alice::Window->new(
    title    => $title,
    irc      => $connection,
    assetdir => $self->config->assetdir,
    app      => $self,
  );
  $self->add_window($window);
  return $window;
}

sub _build_window_id {
  my ($self, $title, $session) = @_;
  md5_hex(encode_utf8(lc $self->user."-$title-$session"));
}

sub find_or_create_window {
  my ($self, $title, $connection) = @_;
  return $self->info_window if $title eq "info";
  if (my $window = $self->find_window($title, $connection)) {
    return $window;
  }
  else {
    $self->create_window($title, $connection);
  }
}

sub sorted_windows {
  my $self = shift;
  my %o;
  if ($self->config->order) {
    %o = map {$self->config->order->[$_] => $_ + 2}
             0 .. @{$self->config->order} - 1;
  }
  $o{info} = 1;
  sort { ($o{$a->title} || $a->sort_name) cmp ($o{$b->title} || $b->sort_name) }
       $self->windows;
}

sub close_window {
  my ($self, $window) = @_;
  $self->broadcast($window->close_action);
  $self->log(debug => "sending a request to close a tab: " . $window->title)
    if $self->httpd->stream_count;
  $self->remove_window($window->id) if $window->type ne "info";
}

sub add_irc_server {
  my ($self, $name, $config) = @_;
  $self->config->servers->{$name} = $config;
  my $irc = App::Alice::IRC->new(
    app    => $self,
    alias  => $name
  );
  $self->add_irc($irc);
}

sub reload_config {
  my ($self, $new_config) = @_;

  my %prev = map {$_ => $self->config->servers->{$_}{ircname} || ""}
             keys %{ $self->config->servers };

  if ($new_config) {
    $self->config->merge($new_config);
    $self->config->write;
  }
  
  for my $network (keys %{$self->config->servers}) {
    my $config = $self->config->servers->{$network};
    if (!$self->has_irc($network)) {
      $self->add_irc_server($network, $config);
    }
    else {
      my $irc = $self->get_irc($network);
      $config->{ircname} ||= "";
      if ($config->{ircname} ne $prev{$network}) {
        $irc->update_realname($config->{ircname});
      }
      $irc->config($config);
    }
  }
  for my $irc ($self->ircs) {
    if (!$self->config->servers->{$irc->alias}) {
      $self->remove_window($_->id) for $irc->windows;
      $irc->remove;
    }
  }
}

sub format_info {
  my ($self, $session, $body, %options) = @_;
  $self->info_window->format_message($session, $body, %options);
}

sub broadcast {
  my ($self, @messages) = @_;
  
  # add any highlighted messages to the log window
  push @messages, map {$self->info_window->copy_message($_)}
                  grep {$_->{highlight}} @messages;
  
  $self->httpd->broadcast(@messages);
  
  if ($self->config->alerts and $self->notifier and ! $self->httpd->stream_count) {
    for my $message (@messages) {
      next if !$message->{window} or $message->{window}{type} eq "info";
      $self->notifier->display($message) if $message->{highlight};
    }
  }
}

sub render {
  my ($self, $template, @data) = @_;
  return $self->template->render_file("$template.html", $self, @data)->as_string;
}

sub is_highlight {
  my ($self, $own_nick, $body) = @_;
  for ((@{$self->config->highlights}, $own_nick)) {
    my $highlight = quotemeta($_);
    return 1 if $body =~ /\b$highlight\b/i;
  }
  return 0;
}

sub is_monospace_nick {
  my ($self, $nick) = @_;
  for (@{$self->config->monospace_nicks}) {
    return 1 if $_ eq $nick;
  }
  return 0;
}

sub is_ignore {
  my ($self, $nick) = @_;
  for ($self->config->ignores) {
    return 1 if $nick eq $_;
  }
  return 0;
}

sub add_ignore {
  my ($self, $nick) = @_;
  $self->config->add_ignore($nick);
  $self->config->write;
}

sub remove_ignore {
  my ($self, $nick) = @_;
  $self->config->ignore([ grep {$nick ne $_} $self->config->ignores ]);
  $self->config->write;
}

sub ignores {
  my $self = shift;
  return $self->config->ignores;
}

sub auth_enabled {
  my $self = shift;
  return ($self->config->auth
      and ref $self->config->auth eq 'HASH'
      and $self->config->auth->{user}
      and $self->config->auth->{pass});
}

sub authenticate {
  my ($self, $user, $pass) = @_;
  $user ||= "";
  $pass ||= "";
  if ($self->auth_enabled) {
    return ($self->config->auth->{user} eq $user
       and $self->config->auth->{pass} eq $pass);
  }
  return 1;
}

sub static_url {
  my ($self, $file) = @_;
  return $self->config->static_prefix . $file;
}

__PACKAGE__->meta->make_immutable;
1;
