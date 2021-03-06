
package Paws::DynamoDB::DeleteTableOutput;
  use Moose;
  has TableDescription => (is => 'ro', isa => 'Paws::DynamoDB::TableDescription');

  has _request_id => (is => 'ro', isa => 'Str');

### main pod documentation begin ###

=head1 NAME

Paws::DynamoDB::DeleteTableOutput

=head1 ATTRIBUTES


=head2 TableDescription => L<Paws::DynamoDB::TableDescription>

Represents the properties of a table.


=head2 _request_id => Str


=cut

1;