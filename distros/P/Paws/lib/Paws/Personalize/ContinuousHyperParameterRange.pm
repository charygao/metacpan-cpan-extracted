package Paws::Personalize::ContinuousHyperParameterRange;
  use Moose;
  has MaxValue => (is => 'ro', isa => 'Num', request_name => 'maxValue', traits => ['NameInRequest']);
  has MinValue => (is => 'ro', isa => 'Num', request_name => 'minValue', traits => ['NameInRequest']);
  has Name => (is => 'ro', isa => 'Str', request_name => 'name', traits => ['NameInRequest']);
1;

### main pod documentation begin ###

=head1 NAME

Paws::Personalize::ContinuousHyperParameterRange

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::Personalize::ContinuousHyperParameterRange object:

  $service_obj->Method(Att1 => { MaxValue => $value, ..., Name => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::Personalize::ContinuousHyperParameterRange object:

  $result = $service_obj->Method(...);
  $result->Att1->MaxValue

=head1 DESCRIPTION

Provides the name and range of a continuous hyperparameter.

=head1 ATTRIBUTES


=head2 MaxValue => Num

  The maximum allowable value for the hyperparameter.


=head2 MinValue => Num

  The minimum allowable value for the hyperparameter.


=head2 Name => Str

  The name of the hyperparameter.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::Personalize>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

