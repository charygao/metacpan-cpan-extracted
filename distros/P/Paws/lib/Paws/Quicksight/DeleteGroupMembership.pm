
package Paws::Quicksight::DeleteGroupMembership;
  use Moose;
  has AwsAccountId => (is => 'ro', isa => 'Str', traits => ['ParamInURI'], uri_name => 'AwsAccountId', required => 1);
  has GroupName => (is => 'ro', isa => 'Str', traits => ['ParamInURI'], uri_name => 'GroupName', required => 1);
  has MemberName => (is => 'ro', isa => 'Str', traits => ['ParamInURI'], uri_name => 'MemberName', required => 1);
  has Namespace => (is => 'ro', isa => 'Str', traits => ['ParamInURI'], uri_name => 'Namespace', required => 1);

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'DeleteGroupMembership');
  class_has _api_uri  => (isa => 'Str', is => 'ro', default => '/accounts/{AwsAccountId}/namespaces/{Namespace}/groups/{GroupName}/members/{MemberName}');
  class_has _api_method  => (isa => 'Str', is => 'ro', default => 'DELETE');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::Quicksight::DeleteGroupMembershipResponse');
1;

### main pod documentation begin ###

=head1 NAME

Paws::Quicksight::DeleteGroupMembership - Arguments for method DeleteGroupMembership on L<Paws::Quicksight>

=head1 DESCRIPTION

This class represents the parameters used for calling the method DeleteGroupMembership on the
L<Amazon QuickSight|Paws::Quicksight> service. Use the attributes of this class
as arguments to method DeleteGroupMembership.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to DeleteGroupMembership.

=head1 SYNOPSIS

    my $quicksight = Paws->service('Quicksight');
    my $DeleteGroupMembershipResponse = $quicksight->DeleteGroupMembership(
      AwsAccountId => 'MyAwsAccountId',
      GroupName    => 'MyGroupName',
      MemberName   => 'MyGroupMemberName',
      Namespace    => 'MyNamespace',

    );

    # Results:
    my $RequestId = $DeleteGroupMembershipResponse->RequestId;
    my $Status    = $DeleteGroupMembershipResponse->Status;

    # Returns a L<Paws::Quicksight::DeleteGroupMembershipResponse> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/quicksight/DeleteGroupMembership>

=head1 ATTRIBUTES


=head2 B<REQUIRED> AwsAccountId => Str

The ID for the AWS account that the group is in. Currently, you use the
ID for the AWS account that contains your Amazon QuickSight account.



=head2 B<REQUIRED> GroupName => Str

The name of the group that you want to delete the user from.



=head2 B<REQUIRED> MemberName => Str

The name of the user that you want to delete from the group membership.



=head2 B<REQUIRED> Namespace => Str

The namespace. Currently, you should set this to C<default>.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method DeleteGroupMembership in L<Paws::Quicksight>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

