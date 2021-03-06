
use blib;
use Carp;

$SIG{__DIE__} = sub {die Carp::longmess(@_);};

use PDLA;
use PDLA::Graphics::TriD;
use PDLA::Graphics::TriD::Image;
use PDLA::IO::Pic;

$s = 10;
$k = zeroes($s,$s);

$x = $k->xvals();
random($k->inplace); $x += $k;

$y = $k->yvals();
random($k->inplace); $y += $k;

random($k->inplace);
$z = $k;

$x /= $s; $y /= $s; $z /= $s;


$x = new PDLA::Graphics::TriD::Lattice([$x,$y,$z]);
$y = new PDLA::Graphics::TriD::Points([$x,$y,$z+1]);

$win = PDLA::Graphics::TriD::get_current_window();
$win->clear_objects();
$win->add_object($x);
$win->add_object($y);

#$PDLA::Graphics::TriD::verbose=1;
#$win->twiddle();
#exit;

$nx = zeroes(3,20);
$nc = zeroes(3,20);
random($nx->inplace);
random($nc->inplace);
print "NX: $nx, NC: $nc\n";

use PDLA::Graphics::OpenGL;
# glShadeModel (&GL_FLAT);
glShadeModel (&GL_SMOOTH);

$lb = $win->glpRasterFont("5x8",0,255);
print "LIST: $lb\n";

$win->add_object(new TOBJ());
$win->twiddle();

package TOBJ;
BEGIN{@TOBJ::ISA = qw/PDLA::Graphics::TriD::Object/;}
use PDLA::Graphics::OpenGLQ;
use PDLA::Graphics::OpenGL;

sub new {
	bless {},$_[0];
}

sub togl {
	glDisable(&GL_LIGHTING);
	line_3x_3c(
#		$::x->slice("0:2"),$::y->slice("0:2")
		$::nx,$::nc
	);
	glColor3f(1,0,1);
	glRasterPos3f(0,0,0.5);
	PDLA::Graphics::OpenGL::glpPrintString($::lb,"HELLO HELLO HELLO GLWORLD!!!");
	glEnable(&GL_LIGHTING);
}

