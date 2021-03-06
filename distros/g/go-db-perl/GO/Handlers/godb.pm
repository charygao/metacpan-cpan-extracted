# $Id: godb.pm,v 1.21 2008/10/27 21:53:30 cmungall Exp $
#
# This GO module is maintained by Chris Mungall <cjm@fruitfly.org>
#
# see also - http://www.geneontology.org
#          - http://www.godatabase.org/dev
#
# You may distribute this module under the same terms as perl itself

=head1 NAME

  GO::Handlers::godb     - Stores parse XML in GO DB

=head1 SYNOPSIS

  my $handler = GO::Handler::godb->new;  
  my $apph = GO::AppHandle->new([-d=>"go_load"]);
  $handler->apph($apph);
  my $parser = GO::Parser->new;  
  $parser->handler($handler);
  $parser->parse($file);

=cut

=head1 DESCRIPTION

This module is for loading GO/OBO data into a GO Database; it handles
ontologies AND associations

The input for this module is the XML events generated by one of the
L<GO::Parser> modules

This XML is transformed into "prestore" XML using
L<GO::Handlers::godb_prestore> which is part of the go_perl library -
this prestore XML matches the GODB schema, which means a generic
XML->DB mapping can be used.

the L<DBIx::DBStag> module is used for storing the godb-prestore in
the database

=head1 SEE ALSO

L<load-go-into-db.pl>

=cut

# makes objects from parser events

package GO::Handlers::godb;
use GO::SqlWrapper qw (:all);
use DBIx::DBStag;
use base qw(GO::Handlers::base);

use strict;
use Carp;
use Data::Dumper;
use Data::Stag qw(:all);

sub apph {
    my $self = shift;
    $self->{_apph} = shift if @_;
    my $apph = $self->{_apph};
    if ($apph) {
        my $sdbh =
          DBIx::DBStag->new(-dbh=>$apph->dbh);
        $self->stagdbh($sdbh);
    }
    return $apph;
}


=head2 optimize_by_dtype

  Usage   - $handler->optimize_by_dtype('go_assoc', $append);
  Returns -
  Args    - format str, bool [optional]

Optimizes L<DBIx::DBStag> loading based on datatype

Certain tables will be cached by unique key

If $append is false, assumes you are loading some files for the first
time, and there is no need to do a SELECT/UPDATE on certain tables -
see code for details

If you are re-loading files, set $append=1

=cut

sub optimize_by_dtype {
    my $self = shift;
    my $dtype = shift;
    my $append = shift;
    return unless $dtype;
    my $sdbh = $self->stagdbh;

    # DBStag caching/bulkloading
    # 1 = cache
    # 2 = bulkload (INSERT only, no SELECT/UPDATE check)
    # 3 = cache AND bulkload

    # keep a track of unique key vals for these elements;
    # will not select if insert/update already performed
    $sdbh->is_caching_on('term', 1);
    $sdbh->is_caching_on('db', 1);
    $sdbh->is_caching_on('species', 1);

    my $BL = 2;
    my $CACHEBL = 3;
    $CACHEBL = 1 if $append;
    $BL = 0 if $append;
    # bulkload
    if ($dtype eq 'obo' || $dtype eq 'obo_text' || $dtype eq 'go_ont' ||
        $dtype eq 'obo_xml') {
        # CACHE & BULKLOAD
        # always use insert, unless we have seen the same element
        # this session
        $sdbh->is_caching_on('term',$CACHEBL);
        $sdbh->is_caching_on('term2term',$CACHEBL);
        $sdbh->is_caching_on('term_audit',$CACHEBL);
        $sdbh->is_caching_on('term_synonym',$CACHEBL);
        $sdbh->is_caching_on('term_dbxref',$CACHEBL);
    }
    if ($dtype eq 'obo' || $dtype eq 'obo_text' || $dtype eq 'go_def' ||
        $dtype eq 'obo_xml') {
        $sdbh->is_caching_on('term_definition',$BL);
    }
    if ($dtype eq 'go_assoc') {
        # BULKLOAD, NO IN-MEMORY CACHE
        # inserts only for these
        # we do not expect to find the same entity twice
        # we do not cache -- too many entities
        #$sdbh->is_caching_on('evidence',$BL);
        $sdbh->is_caching_on('evidence_dbxref',$BL);
        
        # gene products sometimes appear in different contiguous chunks
        # cache gene products
        $sdbh->is_caching_on('gene_product',1);

        # if a gene_product is split into non-contiguous chunks,
        # the godb_prestore xml will specify the same gene_product_synonym
        # a second time. With bulkload ON, this will result in 
        # error messages for duplicate keys. These are harmless but
        # we should still comment this out
        #$sdbh->is_caching_on('gene_product_synonym',$BL);
    }
    return;
}

sub stagdbh {
    my $self = shift;
    $self->{_stagdbh} = shift if @_;
    return $self->{_stagdbh};
}

sub e_dbstag_metadata {
    my $self = shift;
    my @nodes = @_;
    $self->stagdbh->_storenode($_) foreach @nodes;
    return;
}

sub e_term {
    my $self = shift;
    my @nodes = @_;
    if ($self->up(1)->name eq 'godb_prestore') {
        $self->stagdbh->_storenode($_) foreach @nodes;
        return;
    }
    else {
        return @nodes;
    }
}

sub e_db {
    my $self = shift;
    my @nodes = @_;
    if ($self->up(1)->name eq 'godb_prestore') {
        $self->stagdbh->_storenode($_) foreach @nodes;
        return;
    }
    else {
        return @nodes;
    }
}

sub e_term2term {
    my $self = shift;
    my @nodes = @_;
    if ($self->up(1)->name eq 'godb_prestore') {
        $self->stagdbh->_storenode($_) foreach @nodes;
        return;
    }
    else {
        return @nodes;
    }
}

sub e_typedef {
    my $self = shift;
    foreach my $node (@_) {
        $self->stagdbh->_storenode($node);
    }
    return;
}

sub e_relation_composition {
    my $self = shift;
    foreach my $node (@_) {
        $self->stagdbh->_storenode($node);
    }
    return;
}

sub e_relation_properties {
    my $self = shift;
    foreach my $node (@_) {
        $self->stagdbh->_storenode($node);
    }
    return;
}

sub e_instance {
    my $self = shift;
    foreach my $node (@_) {
        $self->stagdbh->_storenode($node);
    }
    return;
}

sub e_gene_product {
    my $self = shift;
    foreach my $node (@_) {
        eval {
            $self->stagdbh->_storenode($node);
        };
        if ($@) {
            # we allow for errors in gp loading
            print STDERR $node->xml;
            $self->warn("$@");
        }
    }
    return;
}

sub e_source_audit {
    my $self = shift;
    my @nodes = @_;
    # replace if exists! TODO
    $self->stagdbh->_storenode($_) foreach @nodes;
    return;
}

sub show_cache {
    my $self = shift;
    if ($self->stagdbh->can("cache_summary")) {
        print "CACHE SUMMARY\n";
        print $self->stagdbh->cache_summary->xml;
        print "\n";
    }
    return;
}

sub clear_cache {
    my $self = shift;
    $self->stagdbh->cache({});
    return;
}

1;

