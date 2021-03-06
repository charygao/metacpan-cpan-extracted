package Paws::GroundStation::DecodeConfig;
  use Moose;
  has UnvalidatedJSON => (is => 'ro', isa => 'Str', request_name => 'unvalidatedJSON', traits => ['NameInRequest'], required => 1);
1;

### main pod documentation begin ###

=head1 NAME

Paws::GroundStation::DecodeConfig

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::GroundStation::DecodeConfig object:

  $service_obj->Method(Att1 => { UnvalidatedJSON => $value, ..., UnvalidatedJSON => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::GroundStation::DecodeConfig object:

  $result = $service_obj->Method(...);
  $result->Att1->UnvalidatedJSON

=head1 DESCRIPTION

Information about the decode C<Config>.

=head1 ATTRIBUTES


=head2 B<REQUIRED> UnvalidatedJSON => Str

  Unvalidated JSON of a decode C<Config>.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::GroundStation>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

