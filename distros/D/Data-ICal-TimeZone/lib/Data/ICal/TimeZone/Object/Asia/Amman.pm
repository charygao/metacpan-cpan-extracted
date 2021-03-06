# this class is autogenerated.  use make_zones to regenerate
package Data::ICal::TimeZone::Object::Asia::Amman;
use strict;
use base qw( Data::ICal::TimeZone::Object );

my $data = join '', <DATA>;
close DATA; # avoid leaking many many filehandles
__PACKAGE__->new->_load( $data );

1;
__DATA__
BEGIN:VCALENDAR
PRODID:-//My Organization//NONSGML My Product//EN
VERSION:2.0
BEGIN:VTIMEZONE
TZID:Asia/Amman
X-LIC-LOCATION:Asia/Amman
BEGIN:DAYLIGHT
TZOFFSETFROM:+0200
TZOFFSETTO:+0300
TZNAME:EEST
DTSTART:19700326T000000
RRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=-1TH
END:DAYLIGHT
BEGIN:STANDARD
TZOFFSETFROM:+0300
TZOFFSETTO:+0200
TZNAME:EET
DTSTART:19701030T010000
RRULE:FREQ=YEARLY;BYMONTH=10;BYDAY=-1FR
END:STANDARD
END:VTIMEZONE
END:VCALENDAR
