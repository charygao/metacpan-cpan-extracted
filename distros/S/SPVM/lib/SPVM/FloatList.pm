package SPVM::FloatList;

1;

=head1 NAME

SPVM::FloatList - Continuous dynamic float array

=head1 SYNOPSYS
  
  use SPVM::FloatList;
  
  # Create a float list
  my $float_list = SPVM::FloatList->new;

  # Create a float list with array
  my $float_list = SPVM::FloatList->newa([1.5f, 2.5f, 3.5f]);
  
  # Get list length
  my $length = $float_list->length;
  
  # Push float value
  $float_list->push(3.5f);

  # Pop float value.
  my $float_value = $float_list->pop;

  # Unshift float value.
  $float_list->unshift(3.2f);
  
  # Shift float value.
  my $float_value = $float_list->shift;
  
  # Set float value.
  $float_list->set(2, 3.2f);

  # Get float value.
  my $float_value = $float_list->get(2);

  # Insert float value
  $float_list->insert(1, 3);

  # Remove float value
  my $float_value = $float_list->remove(1);

  # Convert SPVM::FloatList to float array.
  my $float_array = $float_list->to_array;

=head1 DESCRIPTION

L<SPVM::FloatList> is continuous dynamic float array.

=head1 CLASS METHODS

=head2 new

    sub new : SPVM::FloatList ()

Create a new L<SPVM::FloatList> object.

=head2 newa

    sub newa : SPVM::FloatList ($array : float[])

Create a new L<SPVM::FloatList> object with specific C<float> array.

=head1 INSTANCE METHODS

=head2 length
  
  sub length : int ()

Get list length.

=head2 push
  
  sub push : void ($self : self, $value : float)

Appending the value to the end of list.

=head2 pop

  sub pop : float ($self : self)

Pops and returns the last value of the list, shortening the array by one element
If there are no elements in the list, exception occur.

=head2 unshift

  sub unshift : void ($self : self, $value : float)

Appending the value to the top of list.

=head2 shift

  sub shift : float ($self : self)

Shifts the first value of the list off and returns it, shortening
the array by 1 and moving everything down.
If there are no elements in the list, exception occur.

=head2 set

  sub set : void ($self : self, $index : int, $value : float)

Set the value with index.

=head2 get

  sub get : float ($self : self, $index : int)

Get the value with index.

=head2 insert

  sub insert : void ($self : self, $index : int, $value : float)

Insert a element to the specific index.

=head2 remove

  sub remove : float ($self : self, $index : int)

Remove and return the element which is specified by the index.
  
=head2 to_array

  sub to_array : float[] ($self : self)

Convert L<SPVM::FloatList> to float array.
