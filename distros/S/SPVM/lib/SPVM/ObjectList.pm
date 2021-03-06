package SPVM::ObjectList;

1;

=head1 NAME

SPVM::ObjectList - Continuous dynamic object array

=head1 SYNOPSYS
  
  use SPVM::ObjectList;
  
  # Create a object list
  my $object_list = SPVM::ObjectList->new;

  # Create a object list with array
  my $object_list = SPVM::ObjectList->newa([(object)SPVM::Byte->new(1), SPVM::Int->new(2), SPVM::Long->new(3)]);
  
  # Get list length
  my $length = $object_list->length;
  
  # Push object value
  $object_list->push(SPVM::Long->new(3));

  # Pop object value.
  my $object_value = $object_list->pop;

  # Unshift object value.
  $object_list->unshift(SPVM::Long->new(3));
  
  # Shift object value.
  my $object_value = $object_list->shift;
  
  # Set object value.
  $object_list->set(2, SPVM::Long->new(3));
  
  # Get object value.
  my $object_value = $object_list->get(2);

  # Insert object value
  $object_list->insert(1, SPVM::Long->new(3));

  # Remove object value
  my $object_value = $object_list->remove(1);

  # Convert SPVM::ObjectList to object array.
  my $object_array = $object_list->to_array;

=head1 DESCRIPTION

L<SPVM::ObjectList> is continuous dynamic object array.

=head1 CLASS METHODS

=head2 new

    sub new : SPVM::ObjectList ()

Create a new L<SPVM::ObjectList> object.

=head2 newa

    sub newa : SPVM::ObjectList ($array : object[])

Create a new L<SPVM::ObjectList> object with specific C<object> array.

=head1 INSTANCE METHODS

=head2 length
  
  sub length : int ()

Get list length.

=head2 push
  
  sub push : void ($self : self, $value : object)

Appending the value to the end of list.

=head2 pop

  sub pop : object ($self : self)

Pops and returns the last value of the list, shortening the array by one element
If there are no elements in the list, exception occur.
            
=head2 unshift

  sub unshift : void ($self : self, $value : object)

Appending the value to the top of list.

=head2 shift

  sub shift : object ($self : self)

Shifts the first value of the list off and returns it, shortening
the array by 1 and moving everything down.
If there are no elements in the list, exception occur.

=head2 set

  sub set : void ($self : self, $index : int, $value : object)

Set the value with index.

=head2 get

  sub get : object ($self : self, $index : int)

Get the value with index.

=head2 insert

  sub insert : void ($self : self, $index : int, $value : object)

Insert a element to the specific index.

=head2 remove

  sub remove : object ($self : self, $index : int)

Remove and return the element which is specified by the index.
  
=head2 to_array

  sub to_array : object[] ($self : self)

Convert L<SPVM::ObjectList> to object array.
