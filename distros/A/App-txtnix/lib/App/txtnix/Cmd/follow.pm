package App::txtnix::Cmd::follow;
use Mojo::Base 'App::txtnix';

has 'nickname';
has 'url';

sub run {
    my ($self) = @_;
    my $nick = $self->nickname;
    if (    $self->following->{$nick}
        and $self->following->{$nick} eq $self->url )
    {
        print "You're already following $nick.\n";
        return 1;
    }
    elsif ( $self->following->{$nick} && not $self->force ) {
        print "You're already following $nick under a differant url.\n";
        return 1;
    }
    elsif ( $nick eq $self->nick ) {
        print "Your nickname is also $nick. Please choose a different nick.\n";
        return 1;
    }
    print "You're now following $nick.\n";
    $self->following->{$nick} = $self->url;
    $self->sync;
    $self->add_metadata( 'follow', $self->nickname, $self->url )
      if $self->write_metadata;
    return 0;
}

1;
