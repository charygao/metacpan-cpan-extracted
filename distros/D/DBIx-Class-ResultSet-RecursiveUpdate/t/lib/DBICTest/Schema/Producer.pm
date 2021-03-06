package # hide from PAUSE 
    DBICTest::Schema::Producer;

use base 'DBIx::Class::Core';

__PACKAGE__->table('producer');
__PACKAGE__->add_columns(
  'producerid' => {
    data_type => 'integer',
    is_auto_increment => 1
  },
  'name' => {
    data_type => 'varchar',
    size      => 100,
  },
);
__PACKAGE__->set_primary_key('producerid');
__PACKAGE__->add_unique_constraint(prod_name => [ qw/name/ ]);

__PACKAGE__->has_many(
    producer_to_cd => 'DBICTest::Schema::CD_to_Producer' => 'producer'
);
__PACKAGE__->many_to_many('cds', 'producer_to_cd', 'cd');

__PACKAGE__->resultset_class( __PACKAGE__ . '::ResultSet');

package DBICTest::Schema::Producer::ResultSet;

use base qw( DBIx::Class::ResultSet::RecursiveUpdate );


1;
