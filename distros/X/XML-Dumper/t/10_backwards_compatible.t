use strict;
use warnings;

use Test;
use XML::Dumper;

BEGIN { plan tests => 1 }

sub check( $$$ );

check "0.71 backwards-compatible with 0.40", <<XML
<perldata>
 <hashref memory_address="0x8103854">
  <item key="a">1</item>
  <item key="b">2</item>
 </hashref>
</perldata>
XML
, <<XML;
<perldata>
 <hash memory_address="0x8103854">
  <item key="a">1</item>
  <item key="b">2</item>
 </hash>
</perldata>
XML

# ============================================================
sub check( $$$ ) {
# ============================================================
	my $test = shift;
	my $new_xml = shift;
	my $old_xml = shift;

	my $old = xml2pl( $old_xml );

	my $roundtrip_xml = pl2xml( $old );

	if( xml_compare( $new_xml, $roundtrip_xml )) {
		ok( 1 );
		return;
	}

	print STDERR
		"\nTest for $test failed: data doesn't match!\n\n" . 
		"Got:\n----\n'$old_xml'\n----\n".
		"Came up with:\n----\n'$roundtrip_xml'\n----\n";

	ok( 0 );
}

__END__

Just wanted to inform you that it doesnt deal with
reused address. Is this normal behaviour ?

For example if we had:

==code

use XML::Dumper;
my $x = { a => 1, b => 2 };
my $y = { c => $x, d => $x, };

my $xml = pl2xml( $y );
my $data = xml2pl( $xml );

==code

The $data->{d} will point to empty hash instead of $x;

Here is some debugger output:

 DB<1> x $y;
0  HASH(0x840db78)
   'c' => HASH(0x81fa33c)
      'a' => 1
      'b' => 2
   'd' => HASH(0x81fa33c)
      -> REUSED_ADDRESS
  DB<2>
main::(test.pl:14):     my $data = xml2pl( $xml );
  DB<2> x $xml;
0  '<perldata>
 <hashref>
  <item key="c">
   <hashref>
    <item key="a">1</item>
    <item key="b">2</item>
   </hashref>
  </item>
  <item key="d">
   <hashref>
   </hashref>
  </item>
 </hashref>
</perldata>
'
  DB<3> n
main::(test.pl:16):     1;
  DB<3> x $data;
0  HASH(0x8453168)
   'c' => HASH(0x845a0e4)
      'a' => 1
      'b' => 2
   'd' => HASH(0x845a0fc)
        empty hash

