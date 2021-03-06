
package Paws::DocDB::DBClusterMessage;
  use Moose;
  has DBClusters => (is => 'ro', isa => 'ArrayRef[Paws::DocDB::DBCluster]', request_name => 'DBCluster', traits => ['NameInRequest',]);
  has Marker => (is => 'ro', isa => 'Str');

  has _request_id => (is => 'ro', isa => 'Str');
1;

### main pod documentation begin ###

=head1 NAME

Paws::DocDB::DBClusterMessage

=head1 ATTRIBUTES


=head2 DBClusters => ArrayRef[L<Paws::DocDB::DBCluster>]

A list of clusters.


=head2 Marker => Str

An optional pagination token provided by a previous request. If this
parameter is specified, the response includes only records beyond the
marker, up to the value specified by C<MaxRecords>.


=head2 _request_id => Str


=cut

