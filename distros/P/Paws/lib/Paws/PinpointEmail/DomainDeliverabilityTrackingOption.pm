package Paws::PinpointEmail::DomainDeliverabilityTrackingOption;
  use Moose;
  has Domain => (is => 'ro', isa => 'Str');
  has InboxPlacementTrackingOption => (is => 'ro', isa => 'Paws::PinpointEmail::InboxPlacementTrackingOption');
  has SubscriptionStartDate => (is => 'ro', isa => 'Str');
1;

### main pod documentation begin ###

=head1 NAME

Paws::PinpointEmail::DomainDeliverabilityTrackingOption

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::PinpointEmail::DomainDeliverabilityTrackingOption object:

  $service_obj->Method(Att1 => { Domain => $value, ..., SubscriptionStartDate => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::PinpointEmail::DomainDeliverabilityTrackingOption object:

  $result = $service_obj->Method(...);
  $result->Att1->Domain

=head1 DESCRIPTION

An object that contains information about the Deliverability dashboard
subscription for a verified domain that you use to send email and
currently has an active Deliverability dashboard subscription. If a
Deliverability dashboard subscription is active for a domain, you gain
access to reputation, inbox placement, and other metrics for the
domain.

=head1 ATTRIBUTES


=head2 Domain => Str

  A verified domain thatE<rsquo>s associated with your AWS account and
currently has an active Deliverability dashboard subscription.


=head2 InboxPlacementTrackingOption => L<Paws::PinpointEmail::InboxPlacementTrackingOption>

  An object that contains information about the inbox placement data
settings for the domain.


=head2 SubscriptionStartDate => Str

  The date, in Unix time format, when you enabled the Deliverability
dashboard for the domain.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::PinpointEmail>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

