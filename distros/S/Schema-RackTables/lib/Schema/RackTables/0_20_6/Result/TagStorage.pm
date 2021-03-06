use utf8;
package Schema::RackTables::0_20_6::Result::TagStorage;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::RackTables::0_20_6::Result::TagStorage

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

=head1 TABLE: C<TagStorage>

=cut

__PACKAGE__->table("TagStorage");

=head1 ACCESSORS

=head2 entity_realm

  data_type: 'enum'
  default_value: 'object'
  extra: {list => ["file","ipv4net","ipv4rspool","ipv4vs","ipvs","ipv6net","location","object","rack","user","vst"]}
  is_nullable: 0

=head2 entity_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 tag_id

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 tag_is_assignable

  data_type: 'enum'
  default_value: 'yes'
  extra: {list => ["yes","no"]}
  is_foreign_key: 1
  is_nullable: 0

=head2 user

  data_type: 'char'
  is_nullable: 1
  size: 64

=head2 date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "entity_realm",
  {
    data_type => "enum",
    default_value => "object",
    extra => {
      list => [
        "file",
        "ipv4net",
        "ipv4rspool",
        "ipv4vs",
        "ipvs",
        "ipv6net",
        "location",
        "object",
        "rack",
        "user",
        "vst",
      ],
    },
    is_nullable => 0,
  },
  "entity_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "tag_id",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "tag_is_assignable",
  {
    data_type => "enum",
    default_value => "yes",
    extra => { list => ["yes", "no"] },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "user",
  { data_type => "char", is_nullable => 1, size => 64 },
  "date",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
);

=head1 UNIQUE CONSTRAINTS

=head2 C<entity_tag>

=over 4

=item * L</entity_realm>

=item * L</entity_id>

=item * L</tag_id>

=back

=cut

__PACKAGE__->add_unique_constraint("entity_tag", ["entity_realm", "entity_id", "tag_id"]);

=head1 RELATIONS

=head2 tag_tree

Type: belongs_to

Related object: L<Schema::RackTables::0_20_6::Result::TagTree>

=cut

__PACKAGE__->belongs_to(
  "tag_tree",
  "Schema::RackTables::0_20_6::Result::TagTree",
  { id => "tag_id", is_assignable => "tag_is_assignable" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-10-22 23:01:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ji5/R+20u6FLCEf7X8V45w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
