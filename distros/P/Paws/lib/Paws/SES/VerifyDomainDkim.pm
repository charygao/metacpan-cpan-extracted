
package Paws::SES::VerifyDomainDkim;
  use Moose;
  has Domain => (is => 'ro', isa => 'Str', required => 1);

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'VerifyDomainDkim');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::SES::VerifyDomainDkimResponse');
  class_has _result_key => (isa => 'Str', is => 'ro', default => 'VerifyDomainDkimResult');
1;

### main pod documentation begin ###

=head1 NAME

Paws::SES::VerifyDomainDkim - Arguments for method VerifyDomainDkim on L<Paws::SES>

=head1 DESCRIPTION

This class represents the parameters used for calling the method VerifyDomainDkim on the
L<Amazon Simple Email Service|Paws::SES> service. Use the attributes of this class
as arguments to method VerifyDomainDkim.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to VerifyDomainDkim.

=head1 SYNOPSIS

    my $email = Paws->service('SES');
    # VerifyDomainDkim
    # The following example generates DKIM tokens for a domain that has been
    # verified with Amazon SES:
    my $VerifyDomainDkimResponse =
      $email->VerifyDomainDkim( 'Domain' => 'example.com' );

    # Results:
    my $DkimTokens = $VerifyDomainDkimResponse->DkimTokens;

    # Returns a L<Paws::SES::VerifyDomainDkimResponse> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/email/VerifyDomainDkim>

=head1 ATTRIBUTES


=head2 B<REQUIRED> Domain => Str

The name of the domain to be verified for Easy DKIM signing.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method VerifyDomainDkim in L<Paws::SES>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

