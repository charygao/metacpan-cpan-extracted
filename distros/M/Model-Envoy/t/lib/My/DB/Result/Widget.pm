package My::DB::Result::Widget;

use Moose;

extends 'DBIx::Class::Core';

__PACKAGE__->table('widgets');
__PACKAGE__->add_columns(

    'id'      => { data_type => 'integer', is_nullable => 0, },
    'name'    => { data_type => 'text',    is_nullable => 1, },
);
__PACKAGE__->set_primary_key('id');

__PACKAGE__->has_many( 'parts', 'My::DB::Result::Part', 'widget_id', );

1;
