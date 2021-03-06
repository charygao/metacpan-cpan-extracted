package Paws::ES::MasterUserOptions;
  use Moose;
  has MasterUserARN => (is => 'ro', isa => 'Str');
  has MasterUserName => (is => 'ro', isa => 'Str');
  has MasterUserPassword => (is => 'ro', isa => 'Str');
1;

### main pod documentation begin ###

=head1 NAME

Paws::ES::MasterUserOptions

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::ES::MasterUserOptions object:

  $service_obj->Method(Att1 => { MasterUserARN => $value, ..., MasterUserPassword => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::ES::MasterUserOptions object:

  $result = $service_obj->Method(...);
  $result->Att1->MasterUserARN

=head1 DESCRIPTION

Credentials for the master user: username and password, ARN, or both.

=head1 ATTRIBUTES


=head2 MasterUserARN => Str

  ARN for the master user (if IAM is enabled).


=head2 MasterUserName => Str

  The master user's username, which is stored in the Amazon Elasticsearch
Service domain's internal database.


=head2 MasterUserPassword => Str

  The master user's password, which is stored in the Amazon Elasticsearch
Service domain's internal database.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::ES>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

