package Perspective;
use strict;
use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

use Math::Trig;
use lib('.');
use Vector3D;

$VERSION     = 1.00;
@ISA         = qw(Exporter);
@EXPORT      = ();
@EXPORT_OK   = qw(&new);
%EXPORT_TAGS = ( DEFAULT => [qw(&new)],
                   Both    => [qw(&new)]);

sub new  {
	my ($pkg,$rho,$theta,$phi) = @_;
	bless {
		_rho => $rho,
		_theta => $theta,
		_phi => $phi,
		_v11 => ( -sin( $phi ) ),
		_v12 => ( -cos( $phi ) * cos( $theta ) ),
		_v13 => ( -sin( $phi ) * cos( $theta ) ),
		_v21 => (  cos( $phi ) ),
		_v22 => ( -cos( $phi ) * sin( $theta ) ),
		_v23 => ( -sin( $phi ) * sin( $theta ) ),
		_v32 => (  sin( $phi ) ),
		_v33 => ( -cos( $phi ) ),
		_v43 => ( $rho )
	}, $pkg;
}

sub getrho 	{ my $obj = shift; return $obj->{_rho}; }
sub gettheta 	{ my $obj = shift; return $obj->{_theta}; }
sub getphi 	{ my $obj = shift; return $obj->{_phi}; }
sub getv11 	{ my $obj = shift; return $obj->{_v11}; }
sub getv12 	{ my $obj = shift; return $obj->{_v12}; }
sub getv13 	{ my $obj = shift; return $obj->{_v13}; }
sub getv21 	{ my $obj = shift; return $obj->{_v21}; }
sub getv22 	{ my $obj = shift; return $obj->{_v22}; }
sub getv23 	{ my $obj = shift; return $obj->{_v23}; }
sub getv32 	{ my $obj = shift; return $obj->{_v32}; }
sub getv33 	{ my $obj = shift; return $obj->{_v33}; }
sub getv43 	{ my $obj = shift; return $obj->{_v43}; }

sub setrho 	{ my $obj = shift; $obj->{_rho} = shift; }
sub settheta 	{ my $obj = shift; $obj->{_theta} = shift; }
sub setphi 	{ my $obj = shift; $obj->{_phi} = shift; }
sub setv11 	{ my $obj = shift; $obj->{_v11} = shift; }
sub setv12 	{ my $obj = shift; $obj->{_v12} = shift; }
sub setv13 	{ my $obj = shift; $obj->{_v13} = shift; }
sub setv21 	{ my $obj = shift; $obj->{_v21} = shift; }
sub setv22 	{ my $obj = shift; $obj->{_v22} = shift; }
sub setv23 	{ my $obj = shift; $obj->{_v23} = shift; }
sub setv32 	{ my $obj = shift; $obj->{_v32} = shift; }
sub setv33 	{ my $obj = shift; $obj->{_v33} = shift; }
sub setv43 	{ my $obj = shift; $obj->{_v43} = shift; }

sub eyecoord {
	my $obj = shift;
	my $pw = shift;
	my $pe = shift;
	my $x = $pw->getx();
	my $y = $pw->gety();
	my $z = $pw->getz();
	my $v11 = $obj->getv11();
	my $v12 = $obj->getv12();
	my $v13 = $obj->getv13();
	my $v21 = $obj->getv21();
	my $v22 = $obj->getv22();
	my $v23 = $obj->getv23();
	my $v32 = $obj->getv32();
	my $v33 = $obj->getv33();
	my $v43 = $obj->getv43();
	$pe->setx( $v11 * $x + $v21 * $y );
	$pe->sety( $v12 * $x + $v22 * $y + $v32 * $z);
	$pe->setz( $v13 * $x + $v23 * $y + $v33 * $z + $v43);
}

sub perspective {
	my $obj = shift;
	my $p	= shift;
	my $refpx = shift;
	my $refpy = shift;
	my $pe 	= new Vector3D( 0.0, 0.0, 0.0 );

	$obj->eyecoord ( $p, $pe );
	$$refpx = $pe->getx() / (1E-7 + $pe->getz());
	$$refpy = $pe->gety() / (1E-7 + $pe->getz());
}	

1;
  