package Paws::Transfer::DescribedUser;
  use Moose;
  has Arn => (is => 'ro', isa => 'Str', required => 1);
  has HomeDirectory => (is => 'ro', isa => 'Str');
  has HomeDirectoryMappings => (is => 'ro', isa => 'ArrayRef[Paws::Transfer::HomeDirectoryMapEntry]');
  has HomeDirectoryType => (is => 'ro', isa => 'Str');
  has Policy => (is => 'ro', isa => 'Str');
  has Role => (is => 'ro', isa => 'Str');
  has SshPublicKeys => (is => 'ro', isa => 'ArrayRef[Paws::Transfer::SshPublicKey]');
  has Tags => (is => 'ro', isa => 'ArrayRef[Paws::Transfer::Tag]');
  has UserName => (is => 'ro', isa => 'Str');
1;

### main pod documentation begin ###

=head1 NAME

Paws::Transfer::DescribedUser

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::Transfer::DescribedUser object:

  $service_obj->Method(Att1 => { Arn => $value, ..., UserName => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::Transfer::DescribedUser object:

  $result = $service_obj->Method(...);
  $result->Att1->Arn

=head1 DESCRIPTION

Returns properties of the user that you want to describe.

=head1 ATTRIBUTES


=head2 B<REQUIRED> Arn => Str

  This property contains the unique Amazon Resource Name (ARN) for the
user that was requested to be described.


=head2 HomeDirectory => Str

  This property specifies the landing directory (or folder), which is the
location that files are written to or read from in an Amazon S3 bucket
for the described user. An example is C</I<your s3 bucket
name>/home/I<username> >.


=head2 HomeDirectoryMappings => ArrayRef[L<Paws::Transfer::HomeDirectoryMapEntry>]

  Logical directory mappings that you specified for what S3 paths and
keys should be visible to your user and how you want to make them
visible. You will need to specify the "C<Entry>" and "C<Target>" pair,
where C<Entry> shows how the path is made visible and C<Target> is the
actual S3 path. If you only specify a target, it will be displayed as
is. You will need to also make sure that your AWS IAM Role provides
access to paths in C<Target>.

In most cases, you can use this value instead of the scope down policy
to lock your user down to the designated home directory ("chroot"). To
do this, you can set C<Entry> to '/' and set C<Target> to the
HomeDirectory parameter value.

In most cases, you can use this value instead of the scope down policy
to lock your user down to the designated home directory ("chroot"). To
do this, you can set C<Entry> to '/' and set C<Target> to the
HomeDirectory parameter value.


=head2 HomeDirectoryType => Str

  The type of landing directory (folder) you mapped for your users' to
see when they log into the SFTP server. If you set it to C<PATH>, the
user will see the absolute Amazon S3 bucket paths as is in their SFTP
clients. If you set it C<LOGICAL>, you will need to provide mappings in
the C<HomeDirectoryMappings> for how you want to make S3 paths visible
to your user.


=head2 Policy => Str

  Specifies the name of the policy in use for the described user.


=head2 Role => Str

  This property specifies the IAM role that controls your user's access
to your Amazon S3 bucket. The policies attached to this role will
determine the level of access you want to provide your users when
transferring files into and out of your Amazon S3 bucket or buckets.
The IAM role should also contain a trust relationship that allows the
SFTP server to access your resources when servicing your SFTP user's
transfer requests.


=head2 SshPublicKeys => ArrayRef[L<Paws::Transfer::SshPublicKey>]

  This property contains the public key portion of the Secure Shell (SSH)
keys stored for the described user.


=head2 Tags => ArrayRef[L<Paws::Transfer::Tag>]

  This property contains the key-value pairs for the user requested. Tag
can be used to search for and group users for a variety of purposes.


=head2 UserName => Str

  This property is the name of the user that was requested to be
described. User names are used for authentication purposes. This is the
string that will be used by your user when they log in to your SFTP
server.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::Transfer>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

