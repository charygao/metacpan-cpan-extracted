package blx::xsdsql::schema_repository::sql::pg::binding;

use strict;  # use strict is for PBP
use Filter::Include;
include blx::xsdsql::include;
#line 7

use base qw(blx::xsdsql::schema_repository::sql::generic::binding);

use blx::xsdsql::ut::ut qw(nvl);


sub _manip_value {
	my ($self,$col,$value,%params)=@_;
	my $t=$col->get_attrs_value(qw(TYPE_DUMPER));
	affirm { defined $t } "attribute TYPE_DUMPER not set for column ".nvl($col->get_full_name);
	if (defined $value) {
		if ($t->{BASE} eq 'boolean') {
			if ($value eq 'true' || $value eq '1') {
				$value=1 ;
			}
			elsif($value eq 'false' || $value eq '0') {
				$value=0;
			}
			else {
				croak  "'$value': unknow value for type boolean"
			}
		}
	}
	$value;
}
sub _get_sql_drop_table {
	my ($self,%params)=@_;
	'drop table if exists %t cascade';
}

sub _get_sql_drop_view {
	my ($self,%params)=@_;
	'drop view if exists %v';
}


sub _get_next_sequence {
	my ($self,%params)=@_;
	$self->{PREPARE_SEQUENCE}=$self->{DB_CONN}->prepare("select nextval('".$self->{SEQUENCE_NAME}."')")
		unless defined $self->{PREPARE_SEQUENCE};
	$self->{PREPARE_SEQUENCE}->execute;
	my $r=$self->{PREPARE_SEQUENCE}->fetchrow_arrayref;
	$r->[0];
}	

sub _information_tables {
	my ($self,%params)=@_;
	my $prep=undef;
	my $pref=$self->{EXECUTE_OBJECTS_PREFIX};
	if (defined $pref  && $pref=~/\.$/) { 
		my ($cat,$schema)=$pref=~/^([^\.]+)\.([^\.]+)/;
		($schema)=$pref=~/^([^\.]+)/ unless defined $schema;
		affirm { defined $schema } "$pref: the param 'EXECUTE_OBJECTS_PREFIX' is not correct"
					.' - must be [<catalog_name>.]<schema_name>.';
		unless (defined $cat) {
			$prep=$self->{DB_CONN}->prepare(q(select catalog_name from information_schema.schemata));
			$prep->execute;
			my $r=$prep->fetchrow_arrayref;
			$prep->finish;
			affirm { defined $r } 'query not return a row';
			$cat=$r->[0];
			affirm { defined $cat } 'errore retrieve current catalog_name';
		 }
		$prep=$self->{DB_CONN}->prepare(q(
			select table_name 
			from information_schema.tables
			where table_catalog=? and table_schema=?
			)
		);
		$prep->bind_param(1,$cat);
		$prep->bind_param(2,$schema);
	}
	else {
		$prep=$self->{DB_CONN}->prepare(
			q(
			select t.table_name from 
				information_schema.tables t
				join information_schema.schemata s on t.table_catalog=s.catalog_name and t.table_schema = s.schema_name
			)
		);
	}
	$prep->execute;
	my @t=();
	while(my $r=$prep->fetchrow_arrayref) {
		push @t,$r->[0];
	}
	$prep->finish;
	return wantarray ? @t : \@t;
}

sub finish {
	my ($self,%params)=@_;
	local $self->{DB_CONN}->{RaiseError}=1;
	(delete $self->{PREPARE_SEQUENCE})->finish if defined $self->{PREPARE_SEQUENCE};
	return $self->SUPER::finish(%params);
}


1;


__END__

=head1  NAME

blx::xsdsql::schema_repository::sql::pg::binding -  a binding class for postgresql

=cut

=head1 SYNOPSIS

  use blx::xsdsql::schema_repository::sql::pg::binding

=cut


=head1 DESCRIPTION

this package is a class - instance it with the method new



=head1 VERSION

0.10.0

=cut

=head1 FUNCTIONS

see the methods of  blx::xsdsql::schema_repository::sql::generic::binding


=head1 EXPORT

None by default.


=head1 EXPORT_OK

none

=head1 SEE ALSO

See blx::xsdsql::schema_repository::sql::generic::binding   - this class inerith for it

See blx:.xsdsql::generator for generate the schema of the database and blx::xsdsql::parser  for parse a xsd file (schema file)

=head1 AUTHOR

lorenzo.bellotti, E<lt>pauseblx@gmail.comE<gt>

=head1 COPYRIGHT

Copyright (C) 2010 by lorenzo.bellotti

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut

