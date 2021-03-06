package Mojolicious::Plugin::TimeAgo;
use Mojo::Base 'Mojolicious::Plugin';

# imports
use DateTimeX::Format::Ago;

# version
our $VERSION = 0.06;

sub register {
  my ($self, $app, $attrs) = @_;

  # attributes
  my $default_lang = $attrs->{default} || 'en';

  $app->hook(
    before_dispatch => sub {
      $_[0]->stash(lang_default => $default_lang)
        unless $_[0]->stash('lang_default');
    }
  );

  # add "time_ago" helper
  $app->helper(
    time_ago => sub {
      my ($c, $dt) = @_;

      my $ago = DateTimeX::Format::Ago->new(
        language => $c->stash('lang_default')
      );

      return $ago->format_datetime($dt) if $dt && $dt->isa('DateTime');
    }
  );
}

1;
__END__
=pod
 
=encoding utf8
 
=head1 NAME
 
Mojolicious::Plugin::TimeAgo - DateTime TimeAgo Mojolicious Plugin
 
 
=head1 VERSION
 
version 0.6
 
 
=head1 SYNOPSIS
 
  # Mojolicious
  $self->plugin(
    TimeAgo => { default => 'en' }
  );
 
  # Mojolicious::Lite
  plugin TimeAgo => { default => 'en' };
 

=head1 DESCRIPTION
 
L<Mojolicious::Plugin::TimeAgo> is a L<Mojolicious> plugin that
provide a feature to convert DateTime objects to "just now" 
string, for example.
 
It's a simple wrapper about L<DateTimeX::Format::Ago> module 
class.
 
 
=head1 METHODS
 
=head2 time_ago([DateTime obj]) 
 
Method that translate you L<DateTime> object into human readaable
string.
 
    # Mojolicious::Controller
    my $date = $self->time_ago( DateTime->now );
 
or ...
 
    # view template
    %= time_ago DateTime->now
    <%= time_ago DateTime->now %>
 
 
=head1 CONFIGURATION
 
=head2 default
 
C<default> is the language configuration that your DateTime will be
translated.
 
See more about language in L<DateTimeX::Format::Ago>.
 
 
=head1 TODO
 
    * [done] Language support
    * [done] Get and use language by stash
    * Integration with I18N mojolicious plugin
 
=head1 BUGS AND ISSUES
 
Please report any bugs or feature requests at 
L<https://github.com/dvinciguerra/mojolicious-plugin-timeago/issues>
 
 
=head1 AUTHOR
 
Daniel Vinciguerra <daniel.vinciguerra@bivee.com.br>
 
 
=head1 LICENSE AND COPYRIGHT
 
Copyright 2014-2016 Daniel Vinciguerra <dvinci at cpan.org>.
 
This library is free software; you can redistribute it and/or modify it under 
the same terms as Perl itself.
 
 
=head1 SEE ALSO
 
L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.
 
=cut
