package Pcore::Dist::CLI::Update;

use Pcore -class;

extends qw[Pcore::Dist::CLI];

sub CLI ($self) {
    return { abstract => 'update README.md and LICENSE', };
}

sub CLI_RUN ( $self, $opt, $arg, $rest ) {
    my $dist = $self->get_dist;

    $dist->build->update;

    return;
}

1;
__END__
=pod

=encoding utf8

=head1 NAME

Pcore::Dist::CLI::Update - update README.md and LICENSE

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=head1 METHODS

=head1 SEE ALSO

=cut
