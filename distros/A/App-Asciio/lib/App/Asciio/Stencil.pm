package App::Asciio::Stencil ;
#~ package App::Asciio ;

use strict ;
use warnings ;

use Readonly ;

BEGIN 
{
use Sub::Exporter -setup => { exports => [ qw(create_box create_element) ] } ;
}

sub create_box
{
my (%element_definition) = @_ ;

use App::Asciio::stripes::editable_box2 ;
my $element = new App::Asciio::stripes::editable_box2
					({
					TEXT_ONLY => '',
					TITLE => '',
					EDITABLE => 1,
					RESIZABLE => 1,
					%element_definition,
					}) ;

unless($element_definition{WITH_FRAME})
	{
	# default object attribute is with frame, remove it
	my $box_type = $element->get_box_type() ;
	my ($title, $text) = $element->get_text() ;

	Readonly my  $TITLE_SEPARATOR => 1 ;
	Readonly my  $DISPLAY => 0 ;

	for (0 .. $#$box_type)
		{
		next if $_ == $TITLE_SEPARATOR && $title eq '' ;
		
		$box_type->[$_][$DISPLAY] = 0 ;
		}

	$element->set_box_type($box_type) ;
	}
	
$element->shrink() ;

if($element_definition{WITH_SIZE})
	{
	$element->resize(0, 0, @{$element_definition{WITH_SIZE}}) ;
	}
	
# add name to be seen in the stencil list
$element->{NAME} = $element_definition{NAME} ;

return $element ;
}

sub create_element
{
my (%element_definition) = @_ ;

my $element ;

my $code =  <<"EOE" ;

use $element_definition{CLASS} ;

\$element = new $element_definition{CLASS} (\\%element_definition) ;

\$element->{NAME} = \$element_definition{NAME} ;

EOE

eval $code ;

if($@)
	{
	use Data::TreeDumper ;
	warn "Can't create new element with definition:\n" ;
	warn DumpTree \%element_definition ;
	warn $code ;
	warn $@ ;
	}

return $element ;
} 

#----------------------------------------------------------------------------------------------------------------------

1 ;
