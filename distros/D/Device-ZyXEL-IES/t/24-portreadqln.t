use strict;
use warnings;
use Test::More tests => 8;

use Net::SNMP qw(:asn1);
use Device::ZyXEL::IES;
use Data::Dumper;

my $d = Device::ZyXEL::IES->new(
  hostname => 'localhost',  
  get_community => 'public');

my $s_adsl = Device::ZyXEL::IES::Slot->new(
  id => 3, ies => $d);

my $s_vdsl = Device::ZyXEL::IES::Slot->new(
  id => 4, ies => $d);

my $p_adsl = Device::ZyXEL::IES::Port->new(
  id => 301, slot => $s_adsl );

my $p_vdsl = Device::ZyXEL::IES::Port->new(
  id => 401, slot => $s_vdsl );

# Hooking for test ============================================================
# hook allows snmpget from Net::SNMP::Util
{
 no warnings;

 *{Net::SNMP::_send_pdu} = sub {
    my ( $this ) = @_;
    foreach my $oid ( keys %{$this->{_pdu}{_var_bind_list}} ){
      if ( $oid =~ /^\.1\.3\.6\.1\.4\.1\.890\.1\.5\.13\.5\.6\.3\.1\.3\.0\.3$/ ) {
	    $this->{_pdu}{_var_bind_list}{ $oid } = 'ALC1248G-51'; # slot 3 ADSL
	  }
      elsif ( $oid =~ /^\.1\.3\.6\.1\.4\.1\.890\.1\.5\.13\.5\.6\.3\.1\.3\.0\.4$/ ) {
	    $this->{_pdu}{_var_bind_list}{ $oid } = 'VLC1348G-51'; # slot 4 VDSL
	  }
      elsif ( $oid =~ /^\.1\.3\.6\.1\.4\.1\.890\.1\.5\.13\.5\.13\.4\.3\.1\.[456]\.301$/ ) { # ADSL port qln cpe first and second, and dslam
				 my @w = (44715, 64943, 64920, 64902, 64916, 64955, 64973, 65012, 65031, 65066, 65063, 65009, 65022, 65066, 65075, 65150, 65141, 65173, 65128, 65172, 65216, 65198, 65223, 65169, 65175, 65241, 65233, 65173, 65196, 65223, 64926, 65228, 65251, 65235, 65274, 65264, 65271, 65263, 65266, 65256, 65277, 65270, 65271, 65286, 65292, 65301, 65320, 65338, 65348, 65361, 65378, 65390, 65403, 65417, 65431, 65445, 65458, 65472, 65482, 65493, 65503, 65511, 65518, 65524, 65528, 65532, 65535, 0, 1, 1, 2, 1, 1, 0, 0, 0, 65535, 65535, 65534, 65534, 65533, 65533, 65532, 65532, 65531, 65531, 65531, 65531, 65530, 65530, 65530, 65530, 65529, 65529, 65529, 65529, 65528, 65528, 65528, 65528, 65528, 65528, 65528, 65528, 65529, 65529, 65529, 65529, 65530, 65530, 65530, 65530, 65530, 65530, 65530, 65530, 65530, 65530, 65530, 65530, 65530, 65530, 65530, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65531, 65530, 65530, 65530, 65530, 65530, 65530, 65530, 65530, 65530, 65530, 65530, 65529, 65529, 65529, 65529, 65530, 65530, 65529, 65529, 65529, 65529, 65529, 65528, 65528, 65528, 65528, 65528, 65528, 65528, 65528, 65528, 65528, 65527, 65527, 65527, 65527, 65527, 65527, 65526, 65527, 65527, 65527, 65527, 65526, 65526, 65526, 65526, 65526, 65526, 65526, 65526, 65526, 65526, 65526, 65526, 65525, 65525, 65525, 65525, 65525, 65525, 65525, 65526, 65525, 65525, 65525, 65525, 65525, 65525, 65525, 65525, 65525, 65525, 65525, 65525, 65525, 65525, 65525, 65525, 65525, 65524, 65524, 65524, 65524, 65524, 65525, 65525, 65525, 65525, 65524, 65524, 65524, 65524, 65524, 65524, 65524, 65524, 65524, 65524, 65523, 65523);
         $this->{_pdu}{_var_bind_list}{ $oid } = pack("(n)*", @w);
      }
      elsif ( $oid =~ /^\.1\.3\.6\.1\.4\.1\.890\.1\.5\.13\.5\.13\.8\.2\.1\.2[78]\.401$/ ) { # VDSL port qln down and up
				 my @w = (255, 255, 193, 192, 195, 198, 198, 199, 200, 201, 201, 201, 201, 201, 203, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 213, 214, 214, 214, 213, 214, 213, 214, 213, 213, 213, 213, 214, 213, 214, 213, 212, 214, 214, 214, 213, 214, 213, 215, 214, 213, 214, 213, 212, 214, 213, 214, 215, 213, 214, 213, 214, 214, 215, 214, 213, 214, 213, 213, 214, 213, 213, 213, 213, 213, 213, 210, 212, 213, 213, 214, 213, 214, 214, 214, 214, 213, 213, 213, 213, 214, 214, 214, 213, 214, 214, 213, 214, 213, 213, 213, 214, 214, 213, 213, 212, 213, 213, 212, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255);
         $this->{_pdu}{_var_bind_list}{ $oid } = pack("(C)*", @w);
      }
      elsif ( $oid =~ /^\.1\.3\.6\.1\.4\.1\.890\.1\.5\.13\.5\.13\.8\.2\.1\.3[89]\.401$/ ) { # VDSL port hlog down and up group size
         $this->{_pdu}{_var_bind_list}{ $oid } = 4;
			}
      else {
         $this->{_pdu}{_var_bind_list}{ $oid } = "?";
      }
    }
								
    return ($this->{_nonblocking}) ? 1 : $this->var_bind_list();
 }

};
								  
my ($pdr, $t);

$pdr = $p_adsl->read_qln_near();
$t = $p_adsl->qln_near();
ok( $t->[0] == -2082.1 );
ok( $p_adsl->qln_near_grpsize() == 1);

$pdr = $p_vdsl->read_qln_near();
$t = $p_vdsl->qln_near();
ok( $t->[2] == -119.5 );
ok( $p_vdsl->qln_near_grpsize() == 4);

$pdr = $p_adsl->read_qln_far();
$t = $p_adsl->qln_far();
ok( $t->[0] == -2082.1 );
ok( $p_adsl->qln_near_grpsize() == 1);

$pdr = $p_vdsl->read_qln_far();
$t = $p_vdsl->qln_far();
ok( $t->[2] == -119.5 );
ok( $p_vdsl->qln_far_grpsize() == 4);
