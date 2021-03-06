package Paws::MediaConvert::DolbyVisionLevel6Metadata;
  use Moose;
  has MaxCll => (is => 'ro', isa => 'Int', request_name => 'maxCll', traits => ['NameInRequest']);
  has MaxFall => (is => 'ro', isa => 'Int', request_name => 'maxFall', traits => ['NameInRequest']);
1;

### main pod documentation begin ###

=head1 NAME

Paws::MediaConvert::DolbyVisionLevel6Metadata

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::MediaConvert::DolbyVisionLevel6Metadata object:

  $service_obj->Method(Att1 => { MaxCll => $value, ..., MaxFall => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::MediaConvert::DolbyVisionLevel6Metadata object:

  $result = $service_obj->Method(...);
  $result->Att1->MaxCll

=head1 DESCRIPTION

Use these settings when you set DolbyVisionLevel6Mode to SPECIFY to
override the MaxCLL and MaxFALL values in your input with new values.

=head1 ATTRIBUTES


=head2 MaxCll => Int

  Maximum Content Light Level. Static HDR metadata that corresponds to
the brightest pixel in the entire stream. Measured in nits.


=head2 MaxFall => Int

  Maximum Frame-Average Light Level. Static HDR metadata that corresponds
to the highest frame-average brightness in the entire stream. Measured
in nits.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::MediaConvert>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

