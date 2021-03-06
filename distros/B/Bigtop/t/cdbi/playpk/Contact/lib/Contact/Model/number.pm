package Contact::Model::number;
use strict; use warnings;

use base 'Gantry::Utils::CDBI', 'Exporter';

use Contact::Model::GEN::number;

our $NUMBER = 'Contact::Model::number';

our @EXPORT_OK = ( '$NUMBER' );

1;

=head1 NAME

Contact::Model::number - model for number table (stub part)

=head1 DESCRIPTION

This model inherits from Gantry::Utils::CDBI and uses its generated
helper Contact::Model::GEN::number.

It was generated by Bigtop, but is NOT subject to regeneration.

=cut
