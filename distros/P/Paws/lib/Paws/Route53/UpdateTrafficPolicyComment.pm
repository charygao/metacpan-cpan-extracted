
package Paws::Route53::UpdateTrafficPolicyComment;
  use Moose;
  has Comment => (is => 'ro', isa => 'Str', required => 1);
  has Id => (is => 'ro', isa => 'Str', uri_name => 'Id', traits => ['ParamInURI'], required => 1);
  has Version => (is => 'ro', isa => 'Int', uri_name => 'Version', traits => ['ParamInURI'], required => 1);

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'UpdateTrafficPolicyComment');
  class_has _api_uri  => (isa => 'Str', is => 'ro', default => '/2013-04-01/trafficpolicy/{Id}/{Version}');
  class_has _api_method  => (isa => 'Str', is => 'ro', default => 'POST');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::Route53::UpdateTrafficPolicyCommentResponse');
  class_has _result_key => (isa => 'Str', is => 'ro');
  
1;

### main pod documentation begin ###

=head1 NAME

Paws::Route53::UpdateTrafficPolicyComment - Arguments for method UpdateTrafficPolicyComment on L<Paws::Route53>

=head1 DESCRIPTION

This class represents the parameters used for calling the method UpdateTrafficPolicyComment on the
L<Amazon Route 53|Paws::Route53> service. Use the attributes of this class
as arguments to method UpdateTrafficPolicyComment.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to UpdateTrafficPolicyComment.

=head1 SYNOPSIS

    my $route53 = Paws->service('Route53');
    my $UpdateTrafficPolicyCommentResponse =
      $route53->UpdateTrafficPolicyComment(
      Comment => 'MyTrafficPolicyComment',
      Id      => 'MyTrafficPolicyId',
      Version => 1,

      );

    # Results:
    my $TrafficPolicy = $UpdateTrafficPolicyCommentResponse->TrafficPolicy;

    # Returns a L<Paws::Route53::UpdateTrafficPolicyCommentResponse> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/route53/UpdateTrafficPolicyComment>

=head1 ATTRIBUTES


=head2 B<REQUIRED> Comment => Str

The new comment for the specified traffic policy and version.



=head2 B<REQUIRED> Id => Str

The value of C<Id> for the traffic policy that you want to update the
comment for.



=head2 B<REQUIRED> Version => Int

The value of C<Version> for the traffic policy that you want to update
the comment for.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method UpdateTrafficPolicyComment in L<Paws::Route53>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

