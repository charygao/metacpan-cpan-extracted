
package Paws::DocDB::ModifyDBCluster;
  use Moose;
  has ApplyImmediately => (is => 'ro', isa => 'Bool');
  has BackupRetentionPeriod => (is => 'ro', isa => 'Int');
  has CloudwatchLogsExportConfiguration => (is => 'ro', isa => 'Paws::DocDB::CloudwatchLogsExportConfiguration');
  has DBClusterIdentifier => (is => 'ro', isa => 'Str', required => 1);
  has DBClusterParameterGroupName => (is => 'ro', isa => 'Str');
  has DeletionProtection => (is => 'ro', isa => 'Bool');
  has EngineVersion => (is => 'ro', isa => 'Str');
  has MasterUserPassword => (is => 'ro', isa => 'Str');
  has NewDBClusterIdentifier => (is => 'ro', isa => 'Str');
  has Port => (is => 'ro', isa => 'Int');
  has PreferredBackupWindow => (is => 'ro', isa => 'Str');
  has PreferredMaintenanceWindow => (is => 'ro', isa => 'Str');
  has VpcSecurityGroupIds => (is => 'ro', isa => 'ArrayRef[Str|Undef]');

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'ModifyDBCluster');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::DocDB::ModifyDBClusterResult');
  class_has _result_key => (isa => 'Str', is => 'ro', default => 'ModifyDBClusterResult');
1;

### main pod documentation begin ###

=head1 NAME

Paws::DocDB::ModifyDBCluster - Arguments for method ModifyDBCluster on L<Paws::DocDB>

=head1 DESCRIPTION

This class represents the parameters used for calling the method ModifyDBCluster on the
L<Amazon DocumentDB with MongoDB compatibility|Paws::DocDB> service. Use the attributes of this class
as arguments to method ModifyDBCluster.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to ModifyDBCluster.

=head1 SYNOPSIS

    my $rds = Paws->service('DocDB');
    my $ModifyDBClusterResult = $rds->ModifyDBCluster(
      DBClusterIdentifier               => 'MyString',
      ApplyImmediately                  => 1,            # OPTIONAL
      BackupRetentionPeriod             => 1,            # OPTIONAL
      CloudwatchLogsExportConfiguration => {
        DisableLogTypes => [ 'MyString', ... ],          # OPTIONAL
        EnableLogTypes  => [ 'MyString', ... ],          # OPTIONAL
      },    # OPTIONAL
      DBClusterParameterGroupName => 'MyString',             # OPTIONAL
      DeletionProtection          => 1,                      # OPTIONAL
      EngineVersion               => 'MyString',             # OPTIONAL
      MasterUserPassword          => 'MyString',             # OPTIONAL
      NewDBClusterIdentifier      => 'MyString',             # OPTIONAL
      Port                        => 1,                      # OPTIONAL
      PreferredBackupWindow       => 'MyString',             # OPTIONAL
      PreferredMaintenanceWindow  => 'MyString',             # OPTIONAL
      VpcSecurityGroupIds         => [ 'MyString', ... ],    # OPTIONAL
    );

    # Results:
    my $DBCluster = $ModifyDBClusterResult->DBCluster;

    # Returns a L<Paws::DocDB::ModifyDBClusterResult> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/rds/ModifyDBCluster>

=head1 ATTRIBUTES


=head2 ApplyImmediately => Bool

A value that specifies whether the changes in this request and any
pending changes are asynchronously applied as soon as possible,
regardless of the C<PreferredMaintenanceWindow> setting for the
cluster. If this parameter is set to C<false>, changes to the cluster
are applied during the next maintenance window.

The C<ApplyImmediately> parameter affects only the
C<NewDBClusterIdentifier> and C<MasterUserPassword> values. If you set
this parameter value to C<false>, the changes to the
C<NewDBClusterIdentifier> and C<MasterUserPassword> values are applied
during the next maintenance window. All other changes are applied
immediately, regardless of the value of the C<ApplyImmediately>
parameter.

Default: C<false>



=head2 BackupRetentionPeriod => Int

The number of days for which automated backups are retained. You must
specify a minimum value of 1.

Default: 1

Constraints:

=over

=item *

Must be a value from 1 to 35.

=back




=head2 CloudwatchLogsExportConfiguration => L<Paws::DocDB::CloudwatchLogsExportConfiguration>

The configuration setting for the log types to be enabled for export to
Amazon CloudWatch Logs for a specific instance or cluster. The
C<EnableLogTypes> and C<DisableLogTypes> arrays determine which logs
are exported (or not exported) to CloudWatch Logs.



=head2 B<REQUIRED> DBClusterIdentifier => Str

The cluster identifier for the cluster that is being modified. This
parameter is not case sensitive.

Constraints:

=over

=item *

Must match the identifier of an existing C<DBCluster>.

=back




=head2 DBClusterParameterGroupName => Str

The name of the cluster parameter group to use for the cluster.



=head2 DeletionProtection => Bool

Specifies whether this cluster can be deleted. If C<DeletionProtection>
is enabled, the cluster cannot be deleted unless it is modified and
C<DeletionProtection> is disabled. C<DeletionProtection> protects
clusters from being accidentally deleted.



=head2 EngineVersion => Str

The version number of the database engine to which you want to upgrade.
Changing this parameter results in an outage. The change is applied
during the next maintenance window unless the C<ApplyImmediately>
parameter is set to C<true>.



=head2 MasterUserPassword => Str

The password for the master database user. This password can contain
any printable ASCII character except forward slash (/), double quote
("), or the "at" symbol (@).

Constraints: Must contain from 8 to 100 characters.



=head2 NewDBClusterIdentifier => Str

The new cluster identifier for the cluster when renaming a cluster.
This value is stored as a lowercase string.

Constraints:

=over

=item *

Must contain from 1 to 63 letters, numbers, or hyphens.

=item *

The first character must be a letter.

=item *

Cannot end with a hyphen or contain two consecutive hyphens.

=back

Example: C<my-cluster2>



=head2 Port => Int

The port number on which the cluster accepts connections.

Constraints: Must be a value from C<1150> to C<65535>.

Default: The same port as the original cluster.



=head2 PreferredBackupWindow => Str

The daily time range during which automated backups are created if
automated backups are enabled, using the C<BackupRetentionPeriod>
parameter.

The default is a 30-minute window selected at random from an 8-hour
block of time for each AWS Region.

Constraints:

=over

=item *

Must be in the format C<hh24:mi-hh24:mi>.

=item *

Must be in Universal Coordinated Time (UTC).

=item *

Must not conflict with the preferred maintenance window.

=item *

Must be at least 30 minutes.

=back




=head2 PreferredMaintenanceWindow => Str

The weekly time range during which system maintenance can occur, in
Universal Coordinated Time (UTC).

Format: C<ddd:hh24:mi-ddd:hh24:mi>

The default is a 30-minute window selected at random from an 8-hour
block of time for each AWS Region, occurring on a random day of the
week.

Valid days: Mon, Tue, Wed, Thu, Fri, Sat, Sun

Constraints: Minimum 30-minute window.



=head2 VpcSecurityGroupIds => ArrayRef[Str|Undef]

A list of virtual private cloud (VPC) security groups that the cluster
will belong to.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method ModifyDBCluster in L<Paws::DocDB>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

