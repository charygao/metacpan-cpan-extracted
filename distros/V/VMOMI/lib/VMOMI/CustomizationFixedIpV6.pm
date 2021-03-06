package VMOMI::CustomizationFixedIpV6;
use parent 'VMOMI::CustomizationIpV6Generator';

use strict;
use warnings;

our @class_ancestors = ( 
    'CustomizationIpV6Generator',
    'DynamicData',
);

our @class_members = ( 
    ['ipAddress', undef, 0, ],
    ['subnetMask', undef, 0, ],
);

sub get_class_ancestors {
    return @class_ancestors;
}

sub get_class_members {
    my $class = shift;
    my @super_members = $class->SUPER::get_class_members();
    return (@super_members, @class_members);
}

1;
