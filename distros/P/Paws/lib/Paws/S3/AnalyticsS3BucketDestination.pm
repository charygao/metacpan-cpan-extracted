package Paws::S3::AnalyticsS3BucketDestination;
  use Moose;
  has Bucket => (is => 'ro', isa => 'Str', required => 1);
  has BucketAccountId => (is => 'ro', isa => 'Str');
  has Format => (is => 'ro', isa => 'Str', required => 1);
  has Prefix => (is => 'ro', isa => 'Str');
1;

### main pod documentation begin ###

=head1 NAME

Paws::S3::AnalyticsS3BucketDestination

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::S3::AnalyticsS3BucketDestination object:

  $service_obj->Method(Att1 => { Bucket => $value, ..., Prefix => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::S3::AnalyticsS3BucketDestination object:

  $result = $service_obj->Method(...);
  $result->Att1->Bucket

=head1 DESCRIPTION

Contains information about where to publish the analytics results.

=head1 ATTRIBUTES


=head2 B<REQUIRED> Bucket => Str

  The Amazon Resource Name (ARN) of the bucket to which data is exported.


=head2 BucketAccountId => Str

  The account ID that owns the destination bucket. If no account ID is
provided, the owner will not be validated prior to exporting data.


=head2 B<REQUIRED> Format => Str

  Specifies the file format used when exporting data to Amazon S3.


=head2 Prefix => Str

  The prefix to use when exporting data. The prefix is prepended to all
results.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::S3>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

