package Paws::SageMaker::SharingSettings;
  use Moose;
  has NotebookOutputOption => (is => 'ro', isa => 'Str');
  has S3KmsKeyId => (is => 'ro', isa => 'Str');
  has S3OutputPath => (is => 'ro', isa => 'Str');
1;

### main pod documentation begin ###

=head1 NAME

Paws::SageMaker::SharingSettings

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::SageMaker::SharingSettings object:

  $service_obj->Method(Att1 => { NotebookOutputOption => $value, ..., S3OutputPath => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::SageMaker::SharingSettings object:

  $result = $service_obj->Method(...);
  $result->Att1->NotebookOutputOption

=head1 DESCRIPTION

The sharing settings.

=head1 ATTRIBUTES


=head2 NotebookOutputOption => Str

  The notebook output option.


=head2 S3KmsKeyId => Str

  The AWS Key Management Service encryption key ID.


=head2 S3OutputPath => Str

  The Amazon S3 output path.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::SageMaker>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

