package VMOMI::CAMServerRefusedConnection;
use parent 'VMOMI::InvalidCAMServer';

use strict;
use warnings;

our @class_ancestors = ( 
    'InvalidCAMServer',
    'ActiveDirectoryFault',
    'VimFault',
    'MethodFault',
);

our @class_members = ( );

sub get_class_ancestors {
    return @class_ancestors;
}

sub get_class_members {
    my $class = shift;
    my @super_members = $class->SUPER::get_class_members();
    return (@super_members, @class_members);
}

1;
