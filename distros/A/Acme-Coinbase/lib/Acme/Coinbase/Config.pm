package Acme::Coinbase::Config;
# vim: set ts=4 sw=4 expandtab showmatch
#
use strict;

# FOR MOOSE
use Moose; # automatically turns on strict and warnings
#use Config::INI::Reader;
use Config::IniFiles;
use Data::Dumper;

has 'config_file'    => (is => 'rw', isa => 'Str');
has 'config_reader'   => (is => 'rw');

sub read_config {
    my $self = shift;
    die "$0: no config file" unless $self->config_file;
    print "$0: Config file is " . $self->config_file . "\n";
    #my $config_hash = Config::INI::Reader->read_file( $self->config_file );
    my $config = Config::IniFiles->new(); # -file => $self->config_file);
    $config->SetFileName( $self->config_file ) || die "$0: Can't set config filename\n";;
    $config->ReadConfig();
    #print "READ: " . $config->OutputConfig();
    $self->config_reader( $config );
}
sub get_param {
    my ($self, $section, $param) = @_;
    return "" unless($self->config_reader) ;
    return $self->config_reader->val( $section, $param ) || "";
}

sub dump {
    my $self = shift;

    my @sections = $self->config_reader->Sections();
    return "Sections: " . Dumper( \@sections ) . "\n";
}

# dummy data
#has 'api_key'    => (is => 'rw', isa => 'Str', default=>"lmnop");
#has 'api_secret'  => (is => 'rw', isa => 'Str', default=>"qwerty");

#############################################
# we expect a config file, if used, to look like:
#  [default]
#  api_key    = keyasdakjb34234kj
#  api_secret = secretk3j4204h554j2h3409u34bn
#############################################

1;

=head1 NAME

Acme::Coinbase::Config --  DEPRECATED. Use Finance::GDAX::API or WebService::Coinbase

=head1 SYNOPSIS

Example of a usage goes here, such as

    my $conf = new Acme::Coinbase::Config( config_file=>$filename);
    my $conf->read_config();
    my $val = $conf->get_param( "section", "param" );

=head1 DESCRIPTION

Manages reading a config file.

=head1 METHODS

=over 4

=item my $conf = Acme::Coinbase::Config->new( );

returns a new object.  

=item conf->read_config()

reads the config file

=item conf->get_param( "section", "param")

reads the given parameter from the given section. 

=back

=head1 COPYRIGHT

Copyright (c) 2018 Josh Rabinowitz, All Rights Reserved.

=head1 AUTHORS

Josh Rabinowitz

=cut    

