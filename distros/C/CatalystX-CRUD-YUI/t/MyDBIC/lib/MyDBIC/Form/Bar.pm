package MyDBIC::Form::Bar;
use strict;
use base qw( MyDBIC::Base::Form );

sub init_with_bar {
    my $self = shift;
    $self->init_with_object(@_);
}

sub bar_from_form {
    my $self = shift;
    $self->object_from_form(@_);
}

sub build_form {
    my $self = shift;

    $self->add_fields(

        id => {
            id    => 'id',
            type  => 'hidden',
            class => 'serial',
            label => 'id',
            rank  => 1,
        },

        name => {
            id        => 'name',
            type      => 'text',
            class     => 'varchar',
            label     => 'name',
            tabindex  => 2,
            rank      => 2,
            size      => 16,
            maxlength => 64,
        },

        foo_id => {
            id        => 'foo_id',
            type      => 'integer',
            class     => 'integer',
            label     => 'foo_id',
            tabindex  => 3,
            rank      => 3,
            size      => 24,
            maxlength => 64,
        },
    );

}

1;

