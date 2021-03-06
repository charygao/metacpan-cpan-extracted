package Example::Synopsis::ArraySet;

use Mic::Impl
    has => { SET => { default => sub { [] } } },
;

sub has {
    my ($self, $e) = @_;
    scalar grep { $_ == $e } @{ $self->[SET] };
}

sub add {
    my ($self, $e) = @_;

    if ( ! $self->has($e) ) {
        push @{ $self->[SET] }, $e;
    }
}

1;
