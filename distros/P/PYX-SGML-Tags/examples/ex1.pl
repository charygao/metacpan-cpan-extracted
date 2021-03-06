#!/usr/bin/env perl

use strict;
use warnings;

use PYX::SGML::Tags;

# Input.
my $pyx = <<'END';
(element
-data
)element
END

# Object.
my $obj = PYX::SGML::Tags->new;

# Process.
$obj->parse($pyx);
print "\n";

# Output:
# <element>data</element>