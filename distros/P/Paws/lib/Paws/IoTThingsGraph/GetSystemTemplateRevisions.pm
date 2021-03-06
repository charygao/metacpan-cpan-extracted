
package Paws::IoTThingsGraph::GetSystemTemplateRevisions;
  use Moose;
  has Id => (is => 'ro', isa => 'Str', traits => ['NameInRequest'], request_name => 'id' , required => 1);
  has MaxResults => (is => 'ro', isa => 'Int', traits => ['NameInRequest'], request_name => 'maxResults' );
  has NextToken => (is => 'ro', isa => 'Str', traits => ['NameInRequest'], request_name => 'nextToken' );

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'GetSystemTemplateRevisions');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::IoTThingsGraph::GetSystemTemplateRevisionsResponse');
  class_has _result_key => (isa => 'Str', is => 'ro');
1;

### main pod documentation begin ###

=head1 NAME

Paws::IoTThingsGraph::GetSystemTemplateRevisions - Arguments for method GetSystemTemplateRevisions on L<Paws::IoTThingsGraph>

=head1 DESCRIPTION

This class represents the parameters used for calling the method GetSystemTemplateRevisions on the
L<AWS IoT Things Graph|Paws::IoTThingsGraph> service. Use the attributes of this class
as arguments to method GetSystemTemplateRevisions.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to GetSystemTemplateRevisions.

=head1 SYNOPSIS

    my $iotthingsgraph = Paws->service('IoTThingsGraph');
    my $GetSystemTemplateRevisionsResponse =
      $iotthingsgraph->GetSystemTemplateRevisions(
      Id         => 'MyUrn',
      MaxResults => 1,                # OPTIONAL
      NextToken  => 'MyNextToken',    # OPTIONAL
      );

    # Results:
    my $NextToken = $GetSystemTemplateRevisionsResponse->NextToken;
    my $Summaries = $GetSystemTemplateRevisionsResponse->Summaries;

 # Returns a L<Paws::IoTThingsGraph::GetSystemTemplateRevisionsResponse> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/iotthingsgraph/GetSystemTemplateRevisions>

=head1 ATTRIBUTES


=head2 B<REQUIRED> Id => Str

The ID of the system template.

The ID should be in the following format.

C<urn:tdm:REGION/ACCOUNT ID/default:system:SYSTEMNAME>



=head2 MaxResults => Int

The maximum number of results to return in the response.



=head2 NextToken => Str

The string that specifies the next page of results. Use this when
you're paginating results.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method GetSystemTemplateRevisions in L<Paws::IoTThingsGraph>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

