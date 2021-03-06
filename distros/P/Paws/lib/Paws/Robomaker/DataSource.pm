package Paws::Robomaker::DataSource;
  use Moose;
  has Name => (is => 'ro', isa => 'Str', request_name => 'name', traits => ['NameInRequest']);
  has S3Bucket => (is => 'ro', isa => 'Str', request_name => 's3Bucket', traits => ['NameInRequest']);
  has S3Keys => (is => 'ro', isa => 'ArrayRef[Paws::Robomaker::S3KeyOutput]', request_name => 's3Keys', traits => ['NameInRequest']);
1;

### main pod documentation begin ###

=head1 NAME

Paws::Robomaker::DataSource

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::Robomaker::DataSource object:

  $service_obj->Method(Att1 => { Name => $value, ..., S3Keys => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::Robomaker::DataSource object:

  $result = $service_obj->Method(...);
  $result->Att1->Name

=head1 DESCRIPTION

Information about a data source.

=head1 ATTRIBUTES


=head2 Name => Str

  The name of the data source.


=head2 S3Bucket => Str

  The S3 bucket where the data files are located.


=head2 S3Keys => ArrayRef[L<Paws::Robomaker::S3KeyOutput>]

  The list of S3 keys identifying the data source files.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::Robomaker>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

