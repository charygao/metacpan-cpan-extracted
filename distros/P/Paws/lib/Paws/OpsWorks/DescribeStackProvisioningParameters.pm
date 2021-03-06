
package Paws::OpsWorks::DescribeStackProvisioningParameters;
  use Moose;
  has StackId => (is => 'ro', isa => 'Str', required => 1);

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'DescribeStackProvisioningParameters');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::OpsWorks::DescribeStackProvisioningParametersResult');
  class_has _result_key => (isa => 'Str', is => 'ro');
1;

### main pod documentation begin ###

=head1 NAME

Paws::OpsWorks::DescribeStackProvisioningParameters - Arguments for method DescribeStackProvisioningParameters on L<Paws::OpsWorks>

=head1 DESCRIPTION

This class represents the parameters used for calling the method DescribeStackProvisioningParameters on the
L<AWS OpsWorks|Paws::OpsWorks> service. Use the attributes of this class
as arguments to method DescribeStackProvisioningParameters.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to DescribeStackProvisioningParameters.

=head1 SYNOPSIS

    my $opsworks = Paws->service('OpsWorks');
    my $DescribeStackProvisioningParametersResult =
      $opsworks->DescribeStackProvisioningParameters(
      StackId => 'MyString',

      );

    # Results:
    my $AgentInstallerUrl =
      $DescribeStackProvisioningParametersResult->AgentInstallerUrl;
    my $Parameters = $DescribeStackProvisioningParametersResult->Parameters;

# Returns a L<Paws::OpsWorks::DescribeStackProvisioningParametersResult> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/opsworks/DescribeStackProvisioningParameters>

=head1 ATTRIBUTES


=head2 B<REQUIRED> StackId => Str

The stack ID.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method DescribeStackProvisioningParameters in L<Paws::OpsWorks>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

