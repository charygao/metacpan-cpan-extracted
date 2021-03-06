use utf8;
package Schema::RackTables::0_20_11::Result::PatchCableHeapLog;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::RackTables::0_20_11::Result::PatchCableHeapLog

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

=head1 TABLE: C<PatchCableHeapLog>

=cut

__PACKAGE__->table("PatchCableHeapLog");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 heap_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 user

  data_type: 'char'
  is_nullable: 0
  size: 64

=head2 message

  data_type: 'char'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "heap_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "date",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  "user",
  { data_type => "char", is_nullable => 0, size => 64 },
  "message",
  { data_type => "char", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 heap

Type: belongs_to

Related object: L<Schema::RackTables::0_20_11::Result::PatchCableHeap>

=cut

__PACKAGE__->belongs_to(
  "heap",
  "Schema::RackTables::0_20_11::Result::PatchCableHeap",
  { id => "heap_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2016-05-12 22:07:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yj1NNnUl0C4bQIKxfpBEfQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
