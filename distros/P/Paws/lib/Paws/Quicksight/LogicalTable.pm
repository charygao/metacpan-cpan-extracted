package Paws::Quicksight::LogicalTable;
  use Moose;
  has Alias => (is => 'ro', isa => 'Str', required => 1);
  has DataTransforms => (is => 'ro', isa => 'ArrayRef[Paws::Quicksight::TransformOperation]');
  has Source => (is => 'ro', isa => 'Paws::Quicksight::LogicalTableSource', required => 1);
1;

### main pod documentation begin ###

=head1 NAME

Paws::Quicksight::LogicalTable

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::Quicksight::LogicalTable object:

  $service_obj->Method(Att1 => { Alias => $value, ..., Source => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::Quicksight::LogicalTable object:

  $result = $service_obj->Method(...);
  $result->Att1->Alias

=head1 DESCRIPTION

A I<logical table> is a unit that joins and that data transformations
operate on. A logical table has a source, which can be either a
physical table or result of a join. When a logical table points to a
physical table, the logical table acts as a mutable copy of that
physical table through transform operations.

=head1 ATTRIBUTES


=head2 B<REQUIRED> Alias => Str

  A display name for the logical table.


=head2 DataTransforms => ArrayRef[L<Paws::Quicksight::TransformOperation>]

  Transform operations that act on this logical table.


=head2 B<REQUIRED> Source => L<Paws::Quicksight::LogicalTableSource>

  Source of this logical table.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::Quicksight>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

