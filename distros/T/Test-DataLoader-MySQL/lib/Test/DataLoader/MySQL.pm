package Test::DataLoader::MySQL;
use strict;
use warnings;
use DBI;
use DBD::mysql;
use Carp;
use base qw(Exporter);
our $VERSION = '0.1.0';
use 5.008;

=head1 NAME

Test::DataLoader::MySQL - Load testdata into MySQL database

=head1 SYNOPSIS

  my $data = Test::DataLoader::MySQL->new($dbh);
  $data->add('foo', #table name
             1,     # data id
             {# data_href: column => value
                 id => 1, 
                 name => 'aaa',
             },
             ['id']); # primary keys
  $data->add('foo', 2,
             {
                 id => 2,
                 name => 'bbb',
             },
             ['id']);
  $data->load('foo', 1); #load data into database
  # ... tests using database
  $data->clear;# when finished

if table has auto_increment

  $data->add('foo', 1,
           {
               name => 'aaa',
           },
           ['id']);
  my $keys = $data->load('foo', 1);#load data and get auto_increment
  is( $keys->{id}, 2); # get key value(generated by auto_increment)
  # ... tests using database
  $data->clear;# when finished

read from external file

  # data.pm
  my $data = Test::DataLoader::MySQL->init(); # use init(not new)
  $data->add('foo', 1,
             {
                id => 1,
                name => 'aaa',
             },
             ['id']);
  # in your testcode
  my $data = Test::DataLoader::MySQL->new($dbh);
  $data->load('foo', 1);
  # ... tests using database
  $data->clear;# when finished

=head1 DESCRIPTION

Load testdata into MySQL database.

=cut

=head1 methods

=cut

my $singleton; #instance object is shared for reading data from external file.
END {#delete data if test code is abort
    if (defined $singleton &&  @{ $singleton->{loaded} } ) {
        $singleton->clear;
    }
}

=head2 new($dbh, %options)

create new instance
parameter $dbh(provided by DBI) is required;
If Keep option is NOT specified(default), loaded data is deleted when instance is destroyed, otherwise(specified Keep option) loaded data is remain.

  #$dbh = DBI->connect(...);

  my $data = Test::DataLoader::MySQL->new($dbh); # loaded data is deleted when $data is DESTROYed
  # or
  my $data = Test::DataLoader::MySQL->new($dbh, Keep => 1); # loaded data is remain
  # or
  my $data = Test::DataLoader::MySQL->new($dbh, DeleteBeforeInsert => 1); # delete data which has same keys before load

if you want to use external file and in external file, use init() instead of new().

=cut

sub new {
    my $class = shift;
    my ($dbh, %options) = @_;
    my $self = defined $singleton ? $singleton : {};

    $self = {
        dbh => $dbh,
        loaded   => [],
        keynames => undef,#keys set in  set_keys()
        Keep               => !!$options{Keep},
        DeleteBeforeInsert => !!$options{DeleteBeforeInsert},
    };

    bless $self, $class;
    $singleton = $self;
    return $self;
}

=head2 add($table_name, $data_id, $data_href, $keynames_aref)

add testdata into this modules (not loading testdata)

  $data->add('foo',  # table_name
              1,     # data_id, 
              {      # data which you want to load into database. specified by hash_ref
                 id => 1,
                 name => 'aaa',
              },
              ['id'] #key(s), specified by array_ref, this is important.
              );

table_name and data_id is like a database's key. For example, table_name is 'foo' and data_id is 1 and 'foo' and 2 is dealt with defferent data even if contained data is equal( ex id=>1, name=>'aaa').

Key is important, because when $data is DESTROYed, this module delete all data which had been loaded and deleted data is found by specified key(s) in this method.

if set_keys() was called before, $keynames_aref is ommittable.

=cut

sub add {
    my $self = shift;
    my ($table_name, $data_id, $data_href, $key_aref) = @_;

    carp "already exists $table_name : $data_id" if ( exists $self->{data} &&
                                                      exists $self->{data}->{$table_name}->{$data_id} );
    $self->{data}->{$table_name}->{$data_id} = { data => $data_href, key => $key_aref };
}

=head2 load

load testdata from this module into database.

 $data->load('foo', 1);

first parameter is table_name, second parameter is data_id. meaning of them are same as specified in add-method.
third parameter is option href, if you want to alter data with add method. for example,

 $data->add('foo', 1, { id=>1, name=>'aaa' }); #registered name is 'aaa'
 $data->load('foo', 1, { name=>'bbb' });       #but loaded name is 'bbb' because option href is specified.

return hash_ref. it contains database key and value. this is useful for AUTO_INCREMENT key.

 my $key = $data->load('foo', 1);
 my $id = $key->{id};

=cut

sub load {
    my $self = shift;
    my ($table_name, $data_id, $option_href) = @_;

    my %data = $self->_data_with_option($table_name, $data_id, $option_href);
    my $keynames_aref = $self->_get_keys($table_name, $data_id);

    return $self->_load($table_name, $keynames_aref, %data);
}

sub _get_keys {
    my $self = shift;
    my ($table_name, $data_id) = @_;
    my $keynames_aref = $self->{data}->{$table_name}->{$data_id}->{key};
    if ( $self->_aref_is_empty($keynames_aref) ) {
        $keynames_aref = $self->{keynames}->{$table_name};
    }
    return $keynames_aref;
}

sub _data_with_option {
    my $self = shift;
    my ($table_name, $data_id, $option_href) = @_;
    my %data = %{$self->_data($table_name, $data_id)};

    if ( defined $option_href ) {
        for my $key ( keys %{$option_href} ) {
            $data{$key} = $option_href->{$key};
        }
    }
    return %data;
}



=head2 load_direct($table_name, $data_href, $keynames_aref)

load testdata from this module into database directly.

 $data->load_direct('foo', { id=>1, name=>'aaa' }, ['id']);

first parameter is table_name, second parameter is hashref for data.

for example, 

 my $key = $data->load_direct('foo', { id=>1, name=>'aaa' }, ['id']);

is equivalent to 

 $data->add('foo', 1, { id=>1, name=>'aaa' }, ['id']);
 my $key = $data->load('foo', 1);

if set_keys() was called before, $keynames_aref is ommittable.

=cut


sub load_direct {
    my $self = shift;
    my ($table_name, $data_href, $keynames_aref) = @_;
    my %data = %{ $data_href };
    if ( $self->_aref_is_empty($keynames_aref) ) {
        $keynames_aref = $self->{keynames}->{$table_name};
    }

    return $self->_load($table_name, $keynames_aref, %data);
}

sub _load {
    my $self = shift;
    my ($table_name, $keynames_aref, %data) = @_;

    croak "primary keys are not defined\n" if ( $self->_aref_is_empty($keynames_aref) );
    if ( $self->{DeleteBeforeInsert} && $self->_data_for_key_exists($keynames_aref, %data) ) {
        $self->_delete($table_name, \%data, $keynames_aref);
    }
    $self->_do_insert($table_name, %data);
    my $keys = $self->_primary_keys($keynames_aref, \%data);
    $self->{dbh}->do('commit');

    push @{$self->{loaded}}, [$table_name, \%data, $keynames_aref];

    return $keys;

}

sub _aref_is_empty {
    my $self = shift;
    my ($keynames_aref) = @_;
    return !defined $keynames_aref || !@{ $keynames_aref };
}

sub _data_for_key_exists {
    my $self = shift;
    my ($keynames_aref, %data) = @_;
    for my $key ( @{ $keynames_aref } ) {
        return 0 if ( !exists $data{$key} );
    }
    return 1;
}



sub _do_insert {
    my $self = shift;
    my ($table_name, %data) = @_;
    my $dbh = $self->{dbh};
    my $sth = $dbh->prepare($self->_insert_sql($table_name, %data)) || croak $dbh->errstr;
    my $i=1;
    for my $column ( sort keys %data ) {
        $sth->bind_param($i++, $data{$column});
    }
    $sth->execute() || croak $dbh->errstr;
    $sth->finish;
}

=head2 load_file

add data from external file

 $data->load_file('data.pm');

parameter is filename.

=cut

sub load_file {
    my $self = shift;
    my ( $filename ) = @_;
    require $filename;
    croak("can't read $filename") if ( $@ );
}

=head2 init

create new instance for external file

 my $data = Test::DataLoader::MySQL->init();
 #$data->add(...

=cut

sub init {
    my $class = shift;
    my $self = {};
    if ( defined $singleton ) {
        $self = $singleton;
    }
    else {
        bless $self, $class;
        $singleton = $self;
    }
    return $self;
}

=head2 set_keys($table_name, $keynames_aref)
set primary key information

=cut
sub set_keys {
    my $self = shift;
    my($table_name, $keynames_aref) = @_;
    $self->{keynames}->{$table_name} = $keynames_aref;
}

sub _primary_keys {
    my $self = shift;
    my ($keynames_aref, $data_href) = @_;

    my $result;
    for my $key ( @{ $keynames_aref } ) {
        if ( !defined $data_href->{$key} ) { #for auto_increment
            $data_href->{$key} = $self->_last_insert_id() || undef; #if LAST_INSERT_ID returns '0' its not auto_increment
        }
        $result->{$key} = $data_href->{$key}

    }
    return $result;
}

sub _last_insert_id {
    my $self = shift;

    my $dbh = $self->{dbh};
    my $sth = $dbh->prepare("select LAST_INSERT_ID() from dual") || croak $dbh->errstr;
    $sth->execute() || croak $dbh->errstr;
    if ( my @id = $sth->fetchrow_array ) {
        return $id[0];
    }
    return;
}


=head2 do_select

do select statement

  $data->do_select('foo', "id=1");

first parameter is table_name which you want to select. second parameter is where closure. Omitting second parameter is not allowed, if you want to use all data,  use condition which is aloways true such as "1=1".

=cut

sub do_select {
    my $self = shift;
    my ($table, $condition) = @_;
    my $dbh = $self->{dbh};
    croak( "Error: condition undefined" ) if !defined $condition;

    my $sth = $dbh->prepare("select * from $table where $condition");
    $sth->execute();

    my @result;
    while( my $item = $sth->fetchrow_hashref ) {
        push @result, $item;
    }
    $sth->finish();

    return @result if wantarray;
    return $result[0];
}

sub _insert_sql {
    my $self = shift;
    my ($table_name, %data) = @_;
    my $sql = sprintf("insert into %s set ", $table_name);
    $sql .= join(',', map { "$_=?" } sort keys %data);
    return $sql;
}

sub _data {
    my $self = shift;
    my ($table_name, $data_id) = @_;
    croak "$table_name not found"               if ( !exists $self->{data}->{$table_name} );
    croak "$data_id for $table_name not found"  if ( !exists $self->{data}->{$table_name}->{$data_id} );
    return $self->{data}->{$table_name}->{$data_id}->{data};
}


sub DESTROY {
    my $self = shift;
    if ( @{ $self->{loaded} } ) {
        carp "clear was not called in $0";
        $self->clear;
    }

}

=head2 clear

clear all loaded data from database;

=cut

sub clear {
    my $self = shift;
    my $dbh = $self->{dbh};
    if ( $self->{Keep} || !defined $dbh ) {
        $self->{loaded} = [];
        return;
    }

    for my $loaded ( reverse @{ $self->{loaded} } ) {
        $self->_delete_loaded($loaded);
    }
    $dbh->do('commit');
    $self->{loaded} = [];
}

sub _delete_loaded {
    my $self = shift;
    my ($loaded) = @_;

    my( $table_name, $data_href, $keynames_aref ) = @{ $loaded };
    $self->_delete($table_name, $data_href, $keynames_aref);
}

sub _delete {
    my $self = shift;
    my ($table_name, $data_href, $keynames_aref) = @_;
    my $dbh = $self->{dbh};
    my %data = %{ $data_href };
    my @keys = @{ $keynames_aref };
    my $condition = join(' And ', map { 
        defined $data{$_} ? "$_=?" : "$_ IS NULL"
    } @keys);
    my $sth = $dbh->prepare("delete from $table_name where $condition");
    my $i=1;
    for my $key ( @keys ) {
        $sth->bind_param($i++, $data{$key});
    }
    $sth->execute() || croak $dbh->errstr;
}

1;
__END__

=head1 AUTHOR

Takuya Tsuchida E<lt>tsucchi@cpan.orgE<gt>


=head1 REPOSITORY

L<http://github.com/tsucchi/Test-DataLoader-MySQL>


=head1 COPYRIGHT AND LICENSE

Copyright (c) 2009-2010 Takuya Tsuchida

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

