use utf8;
package Schema::RackTables::0_20_0::Result::Object;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::RackTables::0_20_0::Result::Object

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<Object>

=cut

__PACKAGE__->table("Object");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'char'
  is_nullable: 1
  size: 255

=head2 label

  data_type: 'char'
  is_nullable: 1
  size: 255

=head2 objtype_id

  data_type: 'integer'
  default_value: 1
  extra: {unsigned => 1}
  is_nullable: 0

=head2 asset_no

  data_type: 'char'
  is_nullable: 1
  size: 64

=head2 has_problems

  data_type: 'enum'
  default_value: 'no'
  extra: {list => ["yes","no"]}
  is_nullable: 0

=head2 comment

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "name",
  { data_type => "char", is_nullable => 1, size => 255 },
  "label",
  { data_type => "char", is_nullable => 1, size => 255 },
  "objtype_id",
  {
    data_type => "integer",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "asset_no",
  { data_type => "char", is_nullable => 1, size => 64 },
  "has_problems",
  {
    data_type => "enum",
    default_value => "no",
    extra => { list => ["yes", "no"] },
    is_nullable => 0,
  },
  "comment",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<asset_no>

=over 4

=item * L</asset_no>

=back

=cut

__PACKAGE__->add_unique_constraint("asset_no", ["asset_no"]);

=head1 RELATIONS

=head2 attribute_values

Type: has_many

Related object: L<Schema::RackTables::0_20_0::Result::AttributeValue>

=cut

__PACKAGE__->has_many(
  "attribute_values",
  "Schema::RackTables::0_20_0::Result::AttributeValue",
  {
    "foreign.object_id"  => "self.id",
    "foreign.object_tid" => "self.objtype_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cached_pvms

Type: has_many

Related object: L<Schema::RackTables::0_20_0::Result::CachedPVM>

=cut

__PACKAGE__->has_many(
  "cached_pvms",
  "Schema::RackTables::0_20_0::Result::CachedPVM",
  { "foreign.object_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cacti_graphs

Type: has_many

Related object: L<Schema::RackTables::0_20_0::Result::CactiGraph>

=cut

__PACKAGE__->has_many(
  "cacti_graphs",
  "Schema::RackTables::0_20_0::Result::CactiGraph",
  { "foreign.object_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 ipv4_allocations

Type: has_many

Related object: L<Schema::RackTables::0_20_0::Result::IPv4Allocation>

=cut

__PACKAGE__->has_many(
  "ipv4_allocations",
  "Schema::RackTables::0_20_0::Result::IPv4Allocation",
  { "foreign.object_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 ipv4_lbs

Type: has_many

Related object: L<Schema::RackTables::0_20_0::Result::IPv4LB>

=cut

__PACKAGE__->has_many(
  "ipv4_lbs",
  "Schema::RackTables::0_20_0::Result::IPv4LB",
  { "foreign.object_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 ipv4_nats

Type: has_many

Related object: L<Schema::RackTables::0_20_0::Result::IPv4NAT>

=cut

__PACKAGE__->has_many(
  "ipv4_nats",
  "Schema::RackTables::0_20_0::Result::IPv4NAT",
  { "foreign.object_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 ipv6_allocations

Type: has_many

Related object: L<Schema::RackTables::0_20_0::Result::IPv6Allocation>

=cut

__PACKAGE__->has_many(
  "ipv6_allocations",
  "Schema::RackTables::0_20_0::Result::IPv6Allocation",
  { "foreign.object_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 mount_operations

Type: has_many

Related object: L<Schema::RackTables::0_20_0::Result::MountOperation>

=cut

__PACKAGE__->has_many(
  "mount_operations",
  "Schema::RackTables::0_20_0::Result::MountOperation",
  { "foreign.object_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 object_histories

Type: has_many

Related object: L<Schema::RackTables::0_20_0::Result::ObjectHistory>

=cut

__PACKAGE__->has_many(
  "object_histories",
  "Schema::RackTables::0_20_0::Result::ObjectHistory",
  { "foreign.id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 object_logs

Type: has_many

Related object: L<Schema::RackTables::0_20_0::Result::ObjectLog>

=cut

__PACKAGE__->has_many(
  "object_logs",
  "Schema::RackTables::0_20_0::Result::ObjectLog",
  { "foreign.object_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 ports

Type: has_many

Related object: L<Schema::RackTables::0_20_0::Result::Port>

=cut

__PACKAGE__->has_many(
  "ports",
  "Schema::RackTables::0_20_0::Result::Port",
  { "foreign.object_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 rack_space_objects

Type: has_many

Related object: L<Schema::RackTables::0_20_0::Result::RackSpace>

=cut

__PACKAGE__->has_many(
  "rack_space_objects",
  "Schema::RackTables::0_20_0::Result::RackSpace",
  { "foreign.object_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 rack_space_racks

Type: has_many

Related object: L<Schema::RackTables::0_20_0::Result::RackSpace>

=cut

__PACKAGE__->has_many(
  "rack_space_racks",
  "Schema::RackTables::0_20_0::Result::RackSpace",
  { "foreign.rack_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 rack_thumbnail

Type: might_have

Related object: L<Schema::RackTables::0_20_0::Result::RackThumbnail>

=cut

__PACKAGE__->might_have(
  "rack_thumbnail",
  "Schema::RackTables::0_20_0::Result::RackThumbnail",
  { "foreign.rack_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 vlanswitch

Type: might_have

Related object: L<Schema::RackTables::0_20_0::Result::VLANSwitch>

=cut

__PACKAGE__->might_have(
  "vlanswitch",
  "Schema::RackTables::0_20_0::Result::VLANSwitch",
  { "foreign.object_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-10-22 23:01:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xq0a1c/iFQyhoOPe10Fysw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
