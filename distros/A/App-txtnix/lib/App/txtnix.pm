package App::txtnix;

use Mojo::Base -base;
use 5.14.0;
use Config::Tiny;
use Path::Tiny;
use Mojo::Date;
use Mojo::UserAgent;
use Mojo::URL;
use Mojo::Loader qw(data_section);
use Mojo::Template;
use App::txtnix::Tweet;
use App::txtnix::Source;
use App::txtnix::Cache;
use App::txtnix::Registry;
use IO::Pager;
use Mojo::ByteStream 'b';

our $VERSION = '0.07';

has ua      => sub { shift->_build_ua };
has cache   => sub { App::txtnix::Cache->new( cache_dir => shift->cache_dir ) };
has twtfile => sub { path('~/twtxt') };
has cache_dir         => sub { path('~/.cache/txtnix') };
has use_pager         => sub { 0 };
has sorting           => sub { "descending" };
has timeout           => sub { 5 };
has use_cache         => sub { 1 };
has limit             => sub { 20 };
has time_format       => sub { '%F %H:%M' };
has disclose_identity => sub { 0 };
has write_metadata    => sub { 0 };
has hide_metadata     => sub { 1 };
has rewrite_urls      => sub { 1 };
has embed_names       => sub { 1 };
has check_following   => sub { 1 };
has following         => sub { {} };
has display_format    => sub { 'simple' };
has nick              => sub { $ENV{USER} };
has since             => sub { Mojo::Date->new->epoch(0) };
has until             => sub { Mojo::Date->new() };
has ca_file           => sub { '/etc/ssl/certs/ca-certificates.crt' };
has show_new          => sub { 0 };
has last_timeline     => sub { 0 };
has use_colors        => sub { 0 };
has wrap_text         => sub { 1 };
has colors            => sub {
    {
        nick    => 'bright_yellow',
        time    => 'bright_blue',
        mention => 'cyan',
        hashtag => 'cyan',
    };
};

has [
    qw( twturl pre_tweet_hook post_tweet_hook config force registry key_file cert_file )
];

sub new {
    my ( $class, @args ) = @_;
    my $args = ref $args[0] ? $args[0] : {@args};

    my %translate = (
        cache => 'use_cache',
        pager => 'use_pager',
        new   => 'show_new',
    );

    for ( keys %translate ) {
        $args->{ $translate{$_} } = delete $args->{$_} if exists $args->{$_};
    }

    $args->{config} =
      $args->{config} ? path( $args->{config} ) : $class->_build_config_file;

    for (qw(since until)) {
        if ( exists $args->{$_} ) {
            $args->{$_} = $class->to_date( $args->{$_} );
            die "Can't parse parameter $_ as rfc3339.\n"
              if !defined $args->{$_}->epoch;
        }
    }

    for (qw(pretty simple )) {
        $args->{display_format} = $_ if exists $args->{$_} && $args->{$_};
    }

    for (qw(ascending descending )) {
        $args->{sorting} = $_ if exists $args->{$_} && $args->{$_};
    }

    if ( $args->{config}->exists ) {
        my $config = $class->read_config( $args->{config} );
        if ( $config->{twtxt} ) {
            $args = { %{ $config->{twtxt} }, %$args };
        }
        if ( $config->{following} ) {
            $args->{following} = $config->{following};
        }
        if ( $config->{colors} ) {
            $args->{colors} = $config->{colors};
        }
    }
    for my $path (qw(twtfile cache_dir)) {
        $args->{$path} = path( $args->{$path} ) if exists $args->{$path};
    }

    return bless {%$args}, ref $class || $class;
}

sub _build_ua {
    my $self = shift;
    my $ua   = Mojo::UserAgent->new()->request_timeout( $self->timeout )
      ->max_redirects(5);
    my $ua_string = "txtnix/$VERSION";
    if (   $self->disclose_identity
        && $self->nick
        && $self->twturl )
    {
        $ua_string .= ' (+' . $self->twturl . '; @' . $self->nick . ')';
    }
    $ua->transactor->name($ua_string);
    $ua->proxy->detect;
    $ua->ca( $self->ca_file );
    $ua->cert( $self->cert_file ) if $self->cert_file;
    $ua->key( $self->key_file )   if $self->key_file;
    return $ua;
}

sub _build_config_file {
    my $dir = path(
          $ENV{XDG_CONFIG_HOME} ? $ENV{XDG_CONFIG_HOME}
        : $^O eq "MSWin32"      ? $ENV{APPDATA}
        : $^O eq 'darwin'       ? '~/Library/Application Support'
        :                         '~/.config/'
    )->child('twtxt');
    $dir->mkpath if !$dir->exists;
    return $dir->child('config');
}

sub write_config {
    my ( $self, $config ) = @_;
    $config->write( $self->config, 'utf8' );
    return;
}

sub read_config {
    my ( $self, $file ) = @_;
    $file = path( $file || $self->config );
    if ( !$file->exists ) {
        $file->parent->mkpath;
        $file->touch;
    }
    my $config =
      Config::Tiny->read( $file || $self->config->stringify, 'utf8' );
    die "Could not read configuration file: $Config::Tiny::errstr\n"
      if !defined $config;
    return $config;
}

sub to_date {
    my ( $self, $date ) = @_;
    $date =~ s/([+-]\d\d)(\d\d)/$1:$2/;
    return Mojo::Date->new($date);
}

sub sync {
    my ($self) = @_;
    my $config = $self->read_config;
    $config->{following} = $self->following;
    $self->write_config($config);
    return;
}

sub config_set {
    my ( $self, $key, $value ) = @_;
    my $config = $self->read_config;
    $config->{twtxt}->{$key} = $value;
    $self->write_config($config);
    return;
}

sub add_metadata {
    my $self = shift;
    return $self->twtfile->append_utf8(
        Mojo::Date->new()->to_datetime . "\t// " . join( ' ', @_ ) . "\n" );
}

sub get_tweets {
    my ( $self, $source ) = @_;
    my @tweets;

    my @urls = $source || values %{ $self->following };
    my %urls = map { $_ => 1 } @urls;

    my $delay = Mojo::IOLoop->delay;

    for my $url (@urls) {
        my $nick = $self->url_to_nick($url);
        my ( $cache, $params ) = ( undef, {} );
        if ( $self->use_cache ) {
            $cache = $self->cache->get($url);
            if ($cache) {
                $params = { "If-Modified-Since" => $cache->{last_modified} };
            }
        }
        my $end = $delay->begin;
        $self->ua->get(
            $url => $params => sub {
                my ( $ua, $tx ) = @_;

                if ( my $res = $tx->success ) {

                    $self->check_for_moved_url( $tx, $nick ) if $nick;

                    my $body = b( $res->body )->decode;
                    if ( $res->code == 304 && $cache ) {
                        $body = $cache->{body};
                    }

                    if ( !$body ) {
                        warn "No $body for $url. Ignoring\n";
                        next;
                    }

                    if (   $self->use_cache
                        && $res->code == 200
                        && $res->headers->last_modified )
                    {
                        $self->cache->set(
                            $url,
                            {
                                last_modified => $res->headers->last_modified,
                                body          => $body
                            }
                        );
                    }
                    my $source =
                      App::txtnix::Source->new( url => $url, nick => $nick );
                    push @tweets, $self->parse_twtfile( $source, $body );

                }
                else {
                    my $err = $tx->error;
                    my $source = $nick || $url;
                    chomp( $err->{message} );
                    warn "Failing to get tweets for $source: "
                      . (
                        $err->{code}
                        ? "$err->{code} response: $err->{message}"
                        : "Connection error: $err->{message}"
                      ) . "\n";
                    if (   $nick
                        && $tx->res
                        && $tx->res->code
                        && $tx->res->code == 410
                        && $self->rewrite_urls )
                    {
                        warn "Unfollow user $nick after 410 response.\n";
                        delete $self->following->{$nick};
                    }
                }
                $end->();
            }
        );
    }

    if ( !$source && $self->registry && $self->twturl ) {
        my $end = $delay->begin;
        my $registry =
          App::txtnix::Registry->new( url => $self->registry, ua => $self->ua );
        my @mentions = $registry->get_mentions(
            $self->twturl => sub {
                my (@results) = @_;
                for my $result (@results) {
                    my ( $nick, $url ) =
                      $result->[0] =~ /\@<(?:(\w+) )?([^>]+)>/;
                    next if $url and $urls{$url};
                    my $source =
                      App::txtnix::Source->new( url => $url, nick => $nick );
                    my $timestamp = $self->to_date( $result->[1] );
                    next if !defined $timestamp->epoch;
                    push @tweets,
                      App::txtnix::Tweet->new(
                        timestamp => $timestamp,
                        text      => $result->[2],
                        source    => $source,
                      );
                }
                $end->();
            }
        );
    }

    $delay->wait;

    if ( !$source and $self->twtfile->exists ) {
        my $source = App::txtnix::Source->new(
            file => $self->twtfile,
            nick => $self->nick,
        );
        push @tweets,
          $self->parse_twtfile( $source, $self->twtfile->slurp_utf8 );
    }

    if ( !$source ) {
        $self->sync;

        $self->cache->clean( values %{ $self->following } )
          if $self->use_cache;
    }

    return @tweets;
}

sub filter_tweets {
    my ( $self, @tweets ) = @_;

    if ( $self->show_new && $self->last_timeline ) {
        $self->since( Mojo::Date->new( $self->last_timeline ) );
    }

    @tweets =
      grep {
             !( $self->hide_metadata && index( $_->text, '//' ) == 0 )
          && $_->timestamp->epoch >= $self->since->epoch
          && $_->timestamp->epoch <= $self->until->epoch
      } @tweets;

    my %seen_tweets;

    for my $tweet (@tweets) {
        $seen_tweets{ $tweet->md5_hash } = $tweet;
    }

    @tweets = values %seen_tweets;

    @tweets = sort { $b->timestamp->epoch <=> $a->timestamp->epoch } @tweets;

    my $limit = $self->limit;
    return sort {
            $self->sorting eq 'descending'
          ? $b->timestamp->epoch <=> $a->timestamp->epoch
          : $a->timestamp->epoch <=> $b->timestamp->epoch
    } @tweets > $limit ? @tweets[ 0 .. $limit - 1 ] : @tweets;
}

sub check_for_moved_url {
    my ( $self, $tx, $user ) = @_;
    my $redirect = $tx->redirects->[0];
    if ( $redirect && $self->rewrite_urls ) {
        my $res = $redirect->res;
        if ( ( $res->code == 301 || $res->code == 308 )
            && $res->headers->location )
        {
            warn 'Rewrite url from '
              . $redirect->req->url . ' to '
              . $res->headers->location
              . " after "
              . $res->code . ".\n";
            $self->following->{$user} = $res->headers->location;
        }
    }
    return;
}

sub parse_twtfile {
    my ( $self, $source, $string ) = @_;
    my @tweets;
    for my $line ( split( /\n/, $string ) ) {
        next if $line =~ /^#/;
        my ( $time, $text ) = split( /\t/, $line, 2 );
        next if not defined $text;
        $text =~ s/\P{XPosixPrint}//g;
        $time = $self->to_date($time);
        next if !defined $time->epoch;
        if ( $time and $text ) {
            push @tweets,
              App::txtnix::Tweet->new(
                source    => $source,
                timestamp => $time,
                text      => $text,
              );
        }
    }
    return @tweets;
}

sub display_tweets {
    my ( $self, $display_nick, @tweets ) = @_;
    return if !@tweets;
    my $fh;
    if ( $self->use_pager ) {
        IO::Pager->new($fh);
    }
    else {
        $fh = \*STDOUT;
    }
    my $format        = $self->display_format;
    my $template_name = $format eq 'pretty' ? 'pretty.txt' : 'simple.txt';
    my $template      = data_section( __PACKAGE__, $template_name );
    my $mt =
      Mojo::Template->new( vars => 1, encoding => 'UTF-8' )->parse($template);
    for my $tweet (@tweets) {

        if ( !$self->use_colors ) {
            $ENV{ANSI_COLORS_DISABLED} = 0;
        }

        print {$fh} b(
            $mt->process(
                {
                    nick    => $tweet->source->to_string,
                    content => $self->collapse_mentions( $tweet->text || '' ),
                    time    => $tweet->strftime( $self->time_format ),
                    app     => $self,
                }
            )
        )->encode;
    }
    return;
}

sub url_to_nick {
    my ( $self, $url ) = @_;
    my $known_users = $self->known_users;
    my %urls = map { $known_users->{$_} => $_ } keys %{$known_users};
    return $urls{$url};
}

sub collapse_mentions {
    my ( $self, $text ) = @_;
    $text =~ s/\@<(?:(\w+) )?([^>]+)>/$self->collapse_mention($1,$2)/ge;
    return $text;
}

sub collapse_mention {
    my ( $self, $user, $url ) = @_;
    my $nick = $self->url_to_nick($url);
    return $nick ? "\@$nick" : $user ? "\@<$user $url>" : "\@<$url>";
}

sub parse_mention {
    my ( $self, $text ) = @_;
    return $text =~ /\@<(?:(\w+) )?([^>]+)>/;
}

sub known_users {
    my $self = shift;
    if ( $self->nick and $self->twturl ) {
        return {
            $self->nick => $self->twturl,
            %{ $self->following }
        };
    }
    return $self->following;
}

sub expand_mentions {
    my ( $self, $text ) = @_;
    $text =~ s/\@(\w+)/$self->expand_mention($1)/ge;
    return $text;
}

sub expand_mention {
    my ( $self, $user ) = @_;
    my $known_users = $self->known_users;
    if ( $known_users->{$user} ) {
        if ( $self->embed_names ) {
            return "\@<$user " . $known_users->{$user} . ">";
        }
        else {
            return '@<' . $known_users->{$user} . '>';
        }
    }
    return "\@$user";
}

1;

__DATA__

@@ pretty.txt
% use Term::ANSIColor;
% use Text::Wrap;
% $content =~ s/(@\w+)/colored($1, $app->colors->{mention})/ge;
% $content =~ s/(#\w+)/colored($1, $app->colors->{hashtag})/ge;
%
* <%= colored($nick, $app->colors->{nick}) %> (<%= colored($time, $app->colors->{time}) %>):
% if ( $app->wrap_text ) {
%= wrap('','',$content) . "\n"
% } else {
%= $content . "\n"
% }

@@ simple.txt
<%= $time %> <%= $nick %>: <%= $content %>

__END__

=pod

=head1 NAME

txtnix - Client for txtwt, the minimalist microblogging service for hackers

=head1 COPYRIGHT AND LICENSE

Copyright 2015 Mario Domgoergen C<< <mario@domgoergen.com> >>

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program.  If not, see <http://www.gnu.org/licenses/>.
