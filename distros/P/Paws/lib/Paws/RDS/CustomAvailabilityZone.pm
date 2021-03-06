package Paws::RDS::CustomAvailabilityZone;
  use Moose;
  has CustomAvailabilityZoneId => (is => 'ro', isa => 'Str');
  has CustomAvailabilityZoneName => (is => 'ro', isa => 'Str');
  has CustomAvailabilityZoneStatus => (is => 'ro', isa => 'Str');
  has VpnDetails => (is => 'ro', isa => 'Paws::RDS::VpnDetails');
1;

### main pod documentation begin ###

=head1 NAME

Paws::RDS::CustomAvailabilityZone

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::RDS::CustomAvailabilityZone object:

  $service_obj->Method(Att1 => { CustomAvailabilityZoneId => $value, ..., VpnDetails => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::RDS::CustomAvailabilityZone object:

  $result = $service_obj->Method(...);
  $result->Att1->CustomAvailabilityZoneId

=head1 DESCRIPTION

A custom Availability Zone (AZ) is an on-premises AZ that is integrated
with a VMware vSphere cluster.

For more information about RDS on VMware, see the I<RDS on VMware User
Guide.>
(https://docs.aws.amazon.com/AmazonRDS/latest/RDSonVMwareUserGuide/rds-on-vmware.html)

=head1 ATTRIBUTES


=head2 CustomAvailabilityZoneId => Str

  The identifier of the custom AZ.

Amazon RDS generates a unique identifier when a custom AZ is created.


=head2 CustomAvailabilityZoneName => Str

  The name of the custom AZ.


=head2 CustomAvailabilityZoneStatus => Str

  The status of the custom AZ.


=head2 VpnDetails => L<Paws::RDS::VpnDetails>

  Information about the virtual private network (VPN) between the VMware
vSphere cluster and the AWS website.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::RDS>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

