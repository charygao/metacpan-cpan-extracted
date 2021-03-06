package Paws::Kendra::S3DataSourceConfiguration;
  use Moose;
  has AccessControlListConfiguration => (is => 'ro', isa => 'Paws::Kendra::AccessControlListConfiguration');
  has BucketName => (is => 'ro', isa => 'Str', required => 1);
  has DocumentsMetadataConfiguration => (is => 'ro', isa => 'Paws::Kendra::DocumentsMetadataConfiguration');
  has ExclusionPatterns => (is => 'ro', isa => 'ArrayRef[Str|Undef]');
  has InclusionPrefixes => (is => 'ro', isa => 'ArrayRef[Str|Undef]');
1;

### main pod documentation begin ###

=head1 NAME

Paws::Kendra::S3DataSourceConfiguration

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::Kendra::S3DataSourceConfiguration object:

  $service_obj->Method(Att1 => { AccessControlListConfiguration => $value, ..., InclusionPrefixes => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::Kendra::S3DataSourceConfiguration object:

  $result = $service_obj->Method(...);
  $result->Att1->AccessControlListConfiguration

=head1 DESCRIPTION

Provides configuration information for a data source to index documents
in an Amazon S3 bucket.

=head1 ATTRIBUTES


=head2 AccessControlListConfiguration => L<Paws::Kendra::AccessControlListConfiguration>

  Provides the path to the S3 bucket that contains the user context
filtering files for the data source.


=head2 B<REQUIRED> BucketName => Str

  The name of the bucket that contains the documents.


=head2 DocumentsMetadataConfiguration => L<Paws::Kendra::DocumentsMetadataConfiguration>

  


=head2 ExclusionPatterns => ArrayRef[Str|Undef]

  A list of glob patterns for documents that should not be indexed. If a
document that matches an inclusion prefix also matches an exclusion
pattern, the document is not indexed.

For more information about glob patterns, see glob (programming)
(http://wikipedia.org/wiki/Glob_%28programming%29) in I<Wikipedia>.


=head2 InclusionPrefixes => ArrayRef[Str|Undef]

  A list of S3 prefixes for the documents that should be included in the
index.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::Kendra>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

