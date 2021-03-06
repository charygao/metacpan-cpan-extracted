package Biblio::ILL::ISO::AlreadyTriedListType;

=head1 NAME

Biblio::ILL::ISO::AlreadyTriedListType

=cut

use Biblio::ILL::ISO::ILLASNtype;
use Biblio::ILL::ISO::SEQUENCE_OF;
use Biblio::ILL::ISO::SystemId;

use Carp;

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';
#---------------------------------------------------------------------------
# Mods
# 0.01 - 2003.07.15 - original version
#---------------------------------------------------------------------------

=head1 DESCRIPTION

Biblio::ILL::ISO::AlreadyTriedListType is a derivation of Biblio::ILL::ISO::SEQUENCE_OF.

=head1 USES

 Biblio::ILL::ISO::SystemId

=head1 USED IN

 Biblio::ILL::ISO::ThirdPartyInfoType

=cut

BEGIN{@ISA = qw ( Biblio::ILL::ISO::SEQUENCE_OF 
		  Biblio::ILL::ISO::ILLASNtype 
		  );}   # inherit from ILLASNtype

=head1 FROM THE ASN DEFINITION
 
 Already-Tried-List-Type ::= SEQUENCE OF System-Id
 
=cut

=head1 METHODS

=cut
#---------------------------------------------------------------
#
#---------------------------------------------------------------
=head1

=head2 from_asn($href)

Given a properly formatted hash, builds the object.

=cut
sub from_asn {
    my $self = shift;
    my $aref = shift;

    #print "####### ref type: " . ref($aref) . "\n";
    #print "####### array count: " . @$aref . "\n";

    foreach my $elem (@$aref) {
	#print "#######   " . ref($elem) . "\n";

	my $objref = new Biblio::ILL::ISO::SystemId();
	#$objref->from_asn( $aref[$elem] );
	$objref->from_asn( $elem );
	push @{ $self->{"SEQUENCE"} }, $objref;

    }
    return $self;
}

=head1 SEE ALSO

See the README for system design notes.
See the parent class(es) for other available methods.

For more information on Interlibrary Loan standards (ISO 10160/10161),
a good place to start is:

http://www.nlc-bnc.ca/iso/ill/main.htm

=cut

=head1 AUTHOR

David Christensen, <DChristensenSPAMLESS@westman.wave.ca>

=cut


=head1 COPYRIGHT AND LICENSE

Copyright 2003 by David Christensen

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
