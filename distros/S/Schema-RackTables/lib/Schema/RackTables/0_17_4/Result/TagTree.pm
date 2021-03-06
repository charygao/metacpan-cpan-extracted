use utf8;
package Schema::RackTables::0_17_4::Result::TagTree;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::RackTables::0_17_4::Result::TagTree

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

=head1 TABLE: C<TagTree>

=cut

__PACKAGE__->table("TagTree");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 parent_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 valid_realm

  data_type: 'set'
  default_value: 'file,ipv4net,ipv4vs,ipv4rspool,object,rack,user'
  extra: {list => ["file","ipv4net","ipv4vs","ipv4rspool","object","rack","user"]}
  is_nullable: 0

=head2 tag

  data_type: 'char'
  is_nullable: 1
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
  "parent_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "valid_realm",
  {
    data_type => "set",
    default_value => "file,ipv4net,ipv4vs,ipv4rspool,object,rack,user",
    extra => {
      list => [
        "file",
        "ipv4net",
        "ipv4vs",
        "ipv4rspool",
        "object",
        "rack",
        "user",
      ],
    },
    is_nullable => 0,
  },
  "tag",
  { data_type => "char", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<tag>

=over 4

=item * L</tag>

=back

=cut

__PACKAGE__->add_unique_constraint("tag", ["tag"]);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-10-22 23:04:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yTqy7fWMmfPhUCA0K+Dx4A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
