#!/usr/bin/perl

use Cisco::IPPhone;

$myimage = new Cisco::IPPhone;
$mysoftkeyitem = new Cisco::IPPhone;

$data = "AAAAAAAAAA0AA8AAAAAAAAAAAA2A0000A0AAAAAAAA00000000A0AAAAAAAAAAAAAAAAAA0AA8AAAAAAAAAAAA820200A0AAAAAAAA0000000088AAAAAAAAAAAAAAAAAA0AA8AAAAAAAAAAAAAA0A00A0AAAAAAAA02000000A8AAAAAAAA000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AAAAAAAAAA0AA8AAAAAAAAAAAAAAAA02A0AAAAAAAA2A000000AAAAAAAAAAAAAAAAAAAA0AA8AAAAAAAAAAAAAAAA02A0AAAAAAAA2A000080AAAAAAAAAAAAAAAAAAAA0AA8AAAAAAAAAAAAAAAA0AA0AAAAAAAAAA000080AAAAAAAAAAAAAAAAAAAA0AA8AAAAAAAAAAAAAAAA0AA0AAAAAAAAAA0000A0AAAAAAAAAA00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000A8AAAA020000A0AAAA0200A0AAAA0A0080AAAAAAAA0200A8AAAAAA2A0000A8AAAA020000A0AAAA0200A0AAAA0A0080AAAAAAAA0200A8AAAAAA2A0000A8AAAA020000A0AAAA0200A0AAAA0A0080AAAAAAAA0A00AAAAAAAA2A0000A8AAAA020000A0AAAA0200A0AAAA0A0080AAAAAAAA0A00AAAAAAAA2A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000A8AAAA020000A0AAAAAAAAAAAAAA000080AAAAAAAAAAA0AAAAAAAA2A0000A8AAAA020000A0AAAAAAAAAAAAAA000080AAAAAAAAAAA0AAAAAAAA2A0000A8AAAA020000A0AAAAAAAAAAAA0A000080AAAAAAAAAA8AAAAAAAAA2A0000A8AAAA020000A0AAAAAAAAAAAA0A000080AAAAAAAAAAAAAAAAAAAA2A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000A8AAAA020000A0AAAAAAAAAAAA0A000080AAAA0AAAAAAAAA2AAAAA2A0000A8AAAA020000A0AAAAAAAAAAAA20000080AAAA0AAAAAAAAA0AAAAA2A0000A8AAAA020000A0AAAAAAAAAAAA2A000080AAAA0AA8AAAAAA0AAAAA2A0000A8AAAA020000A0AAAAAAAAAAAAAA000080AAAA0AA8AAAAAA02AAAA2A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000A8AAAA020000A0AAAA0200A0AAAA0A0080AAAA0AA0AAAAAA00AAAA2A0000A8AAAA020000A0AAAA0200A0AAAA0A0080AAAA0A80AAAA2A00AAAA2A0000A8AAAA020000A0AAAA0200A0AAAA0A0080AAAA0A00AAAA2A00AAAA2A00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AAAAAAAAAA0AA8AAAAAAAAAAAAAAAA0AA0AAAAAA0A00A8AA0200AAAAAAAAAAAAAAAAAA0AA8AAAAAAAAAAAAAAAA02A0AAAAAA0A00A8AA0200AAAAAAAAAAAAAAAAAA0AA8AAAAAAAAAAAAAAAA02A0AAAAAA0A00A0AA0200AAAAAAAAAAAAAAAAAA0AA8AAAAAAAAAAAAAAAA02A0AAAAAA0A00A0AA0000AAAAAAAA000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AAAAAAAAAA0AA8AAAAAAAAAAAAAA0A00A0AAAAAA0A00002A0000AAAAAAAAAAAAAAAAAA0AA8AAAAAAAAAAAAAA0200A0AAAAAA0A00002A0000AAAAAAAAAAAAAAAAAA0AA8AAAAAAAAAAAA2A0000A0AAAAAA0A0000080000AAAAAAAAAAAAAAAAAA0AA8AAAAAAAAAAAA020000A0AAAAAA0A0000080000AAAAAAAA";

# Create Menu Object
$myimage->Image( { Title => "IBM Image", Prompt => "View the image",
                 LocationX => "-1", LocationY => "-1", Width => "120",
                 Height => "44", Depth => "2", Data => "$data" });

# Add SoftKeyItems to Menu Object
$mysoftkeyitem->SoftKeyItem( { Name => "Select", URL => "SoftKey:Select", 
                               Position => "1" } );
$myimage->AddSoftKeyItemObject( { SoftKeyItem => $mysoftkeyitem });
$myimage->AddSoftKeyItem({ Name => "Exit", URL => "SoftKey:Exit", 
                          Position => "2" });

# Print the Menu Object to the Phone
print $myimage->Content;

__END__
~;
