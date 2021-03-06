package DNS::Hetzner::API::Zones;

# ABSTRACT: Zones

# ---
# This class is auto-generated by bin/get_hetzner_info.pl
# ---

use v5.20;

use Moo;
use Types::Standard qw(:all);

use Mojo::Base -strict, -signatures;

extends 'DNS::Hetzner';

with 'DNS::Hetzner::Utils';
with 'MooX::Singleton';

use JSON::Validator;
use Carp;

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'zones' } );

sub get_export ($self, $params = {}) {
    my $spec   =     {
        'properties' => { 'ZoneID' => { 'type' => 'string', }, },
        'required'   => [ 'ZoneID', ],
        'type'       => 'object',
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        $params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params->{$_} ?
            ($_ => $params->{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:ZoneID/export',
        { type => 'get' },
        \%request_params,
    );
}

sub create ($self, $params = {}) {
    my $spec   =     {
        'components' => {
            'BaseZone' => {
                'properties' => {
                    'created' => {
                        'description' => 'Time zone was created',
                        'format'      => 'date-time',
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                    'id' => {
                        'description' => 'ID of zone',
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                    'is_secondary_dns' => {
                        'description' =>
                          'Indicates if a zone is a secondary DNS zone',
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'boolean',
                    },
                    'legacy_dns_host' => {
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                    'legacy_ns' => {
                        'items' => { 'type' => 'string', },
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'array',
                    },
                    'modified' => {
                        'description' => 'Time zone was last updated',
                        'format'      => 'date-time',
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                    'name' => {
                        'description' => 'Name of zone',
                        'type'        => 'string',
                    },
                    'ns' => {
                        'items' => { 'type' => 'string', },
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'array',
                    },
                    'owner' => {
                        'description' => 'Owner of zone',
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                    'paused' => {
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'boolean',
                    },
                    'permission' => {
                        'description' => 'Zone\'s permissions',
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                    'project' => {
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                    'records_count' => {
                        'description' =>
                          'Amount of records associated to this zone',
                        'format' => 'uint64',
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'integer',
                    },
                    'registrar' => {
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                    'status' => {
                        'description' => 'Status of zone',
                        'enum'        => [ 'verified', 'failed', 'pending', ],
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                    'ttl' => {
                        'description' => 'TTL of zone',
                        'format'      => 'uint64',
                        'type'        => 'integer',
                    },
                    'txt_verification' => {
                        'description' =>
    'Shape of the TXT record that has to be set to verify a zone. If name and token are empty, no TXT record needs to be set',
                        'properties' => {
                            'name' => {
                                'description' => 'Name of the TXT record',
                                'readOnly'    => bless(
                                    do { \( my $o = 1 ) },
                                    'JSON::PP::Boolean'
                                ),
                                'type' => 'string',
                            },
                            'token' => {
                                'description' => 'Value of the TXT record',
                                'readOnly'    => bless(
                                    do { \( my $o = 1 ) },
                                    'JSON::PP::Boolean'
                                ),
                                'type' => 'string',
                            },
                        },
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'object',
                    },
                    'verified' => {
                        'description' => 'Verification of zone',
                        'format'      => 'date-time',
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                },
                'type' => 'object',
            },
            'Zone' => {
                'allOf'    => [ { '$ref' => '#/components/schemas/BaseZone', }, ],
                'required' => [ 'name', ],
                'type'     => 'object',
            },
            'ZoneResponse' => {
                'allOf' => [ { '$ref' => '#/components/schemas/BaseZone', }, ],
                'type'  => 'object',
            },
        },
        'properties' =>
          { '' => { 'schema' => { '$ref' => '#/components/schemas/Zone', }, }, },
        'required' => [],
        'type'     => 'object',
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        $params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params->{$_} ?
            ($_ => $params->{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '',
        { type => 'post' },
        \%request_params,
    );
}

sub list ($self, $params = {}) {
    my $spec   =     {
        'properties' => {},
        'required'   => [],
        'type'       => 'object',
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        $params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params->{$_} ?
            ($_ => $params->{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '',
        { type => 'get' },
        \%request_params,
    );
}

sub create_import ($self, $params = {}) {
    my $spec   =     {
        'properties' => {
            '' => {
                'description' => 'Zone file to import',
                'type'        => 'string',
            },
            'ZoneID' => { 'type' => 'string', },
        },
        'required' => [ 'ZoneID', ],
        'type'     => 'object',
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        $params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params->{$_} ?
            ($_ => $params->{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:ZoneID/import',
        { type => 'post' },
        \%request_params,
    );
}

sub update ($self, $params = {}) {
    my $spec   =     {
        'components' => {
            'BaseZone' => {
                'properties' => {
                    'created' => {
                        'description' => 'Time zone was created',
                        'format'      => 'date-time',
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                    'id' => {
                        'description' => 'ID of zone',
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                    'is_secondary_dns' => {
                        'description' =>
                          'Indicates if a zone is a secondary DNS zone',
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'boolean',
                    },
                    'legacy_dns_host' => {
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                    'legacy_ns' => {
                        'items' => { 'type' => 'string', },
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'array',
                    },
                    'modified' => {
                        'description' => 'Time zone was last updated',
                        'format'      => 'date-time',
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                    'name' => {
                        'description' => 'Name of zone',
                        'type'        => 'string',
                    },
                    'ns' => {
                        'items' => { 'type' => 'string', },
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'array',
                    },
                    'owner' => {
                        'description' => 'Owner of zone',
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                    'paused' => {
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'boolean',
                    },
                    'permission' => {
                        'description' => 'Zone\'s permissions',
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                    'project' => {
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                    'records_count' => {
                        'description' =>
                          'Amount of records associated to this zone',
                        'format' => 'uint64',
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'integer',
                    },
                    'registrar' => {
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                    'status' => {
                        'description' => 'Status of zone',
                        'enum'        => [ 'verified', 'failed', 'pending', ],
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                    'ttl' => {
                        'description' => 'TTL of zone',
                        'format'      => 'uint64',
                        'type'        => 'integer',
                    },
                    'txt_verification' => {
                        'description' =>
    'Shape of the TXT record that has to be set to verify a zone. If name and token are empty, no TXT record needs to be set',
                        'properties' => {
                            'name' => {
                                'description' => 'Name of the TXT record',
                                'readOnly'    => bless(
                                    do { \( my $o = 1 ) },
                                    'JSON::PP::Boolean'
                                ),
                                'type' => 'string',
                            },
                            'token' => {
                                'description' => 'Value of the TXT record',
                                'readOnly'    => bless(
                                    do { \( my $o = 1 ) },
                                    'JSON::PP::Boolean'
                                ),
                                'type' => 'string',
                            },
                        },
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'object',
                    },
                    'verified' => {
                        'description' => 'Verification of zone',
                        'format'      => 'date-time',
                        'readOnly' =>
                          bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
                        'type' => 'string',
                    },
                },
                'type' => 'object',
            },
            'Zone' => {
                'allOf'    => [ { '$ref' => '#/components/schemas/BaseZone', }, ],
                'required' => [ 'name', ],
                'type'     => 'object',
            },
            'ZoneResponse' => {
                'allOf' => [ { '$ref' => '#/components/schemas/BaseZone', }, ],
                'type'  => 'object',
            },
        },
        'properties' => {
            ''       => { 'schema' => { '$ref' => '#/components/schemas/Zone', }, },
            'ZoneID' => { 'type'   => 'string', },
        },
        'required' => [ 'ZoneID', ],
        'type'     => 'object',
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        $params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params->{$_} ?
            ($_ => $params->{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:ZoneID',
        { type => 'put' },
        \%request_params,
    );
}

sub delete ($self, $params = {}) {
    my $spec   =     {
        'properties' => { 'ZoneID' => { 'type' => 'string', }, },
        'required'   => [ 'ZoneID', ],
        'type'       => 'object',
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        $params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params->{$_} ?
            ($_ => $params->{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:ZoneID',
        { type => 'delete' },
        \%request_params,
    );
}

sub get ($self, $params = {}) {
    my $spec   =     {
        'properties' => { 'ZoneID' => { 'type' => 'string', }, },
        'required'   => [ 'ZoneID', ],
        'type'       => 'object',
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        $params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params->{$_} ?
            ($_ => $params->{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:ZoneID',
        { type => 'get' },
        \%request_params,
    );
}

sub create_validate ($self, $params = {}) {
    my $spec   =     {
        'properties' => {
            '' => {
                'description' => 'Zone file to validate',
                'type'        => 'string',
            },
        },
        'required' => [ '', ],
        'type'     => 'object',
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        $params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params->{$_} ?
            ($_ => $params->{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/file/validate',
        { type => 'post' },
        \%request_params,
    );
}


1;

__END__

=pod

=encoding UTF-8

=head1 NAME

DNS::Hetzner::API::Zones - Zones

=head1 VERSION

version 0.01

=head1 SYNOPSIS

    use DNS::Hetzner;

    my $api_key = '1234abc';
    my $dns     = DNS::Hetzner->new(
        token => $api_key,
    );

    $dns->records->create(
    );

=head1 ATTRIBUTES

=over 4

=item * endpoint

=back

=head1 METHODS

=head2 get_export

Export a zone file.

    $dns->Zones->get_export(HASH(0x55fcc724f0b8));

=head2 create

Creates a new zone.

    $dns->Zones->create(HASH(0x55fcc7389db0));

=head2 list

Returns paginated zones associated with the user. Limited to 100 zones per request.

    $dns->Zones->list(HASH(0x55fcc7385d80));

=head2 create_import

Import a zone file in text/plain format.

    $dns->Zones->create_import(HASH(0x55fcc7385f60));

=head2 update

Updates a zone.

    $dns->Zones->update(HASH(0x55fcc73894f8));

=head2 delete

Deletes a zone.

    $dns->Zones->delete(HASH(0x55fcc7383988));

=head2 get

Returns an object containing all information about a zone. Zone to get is identified by 'ZoneID'.

    $dns->Zones->get(HASH(0x55fcc7384030));

=head2 create_validate

Validate a zone file in text/plain format.

    $dns->Zones->create_validate(HASH(0x55fcc737d918));

=head1 AUTHOR

Renee Baecker <reneeb@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2020 by Renee Baecker.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
