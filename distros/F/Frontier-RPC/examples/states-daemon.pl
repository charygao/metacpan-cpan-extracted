#
# Copyright (C) 1998 Ken MacLeod
# See the file COPYING for distribution terms.
#
# $Id: states-daemon.pl,v 1.1.1.1 1998/04/14 03:50:48 ken Exp $
#

use Frontier::Daemon;

@states = (qw/Alabama Alaska Arizona Arkansas California Colorado Connecticut
	   Delaware Florida Georgia Hawaii Idaho Illinois Indiana Iowa Kansas
	   Kentucky Louisiana Maine Maryland Massachusetts Michigan Minnesota
	   Mississippi Missouri Montana Nebraska Nevada/, 'New Hampshire',
	   'New Jersey', 'New Mexico', 'New York', 'North Carolina',
	   'North Dakota', qw/Ohio Oklahoma Oregon Pennsylvania/, 'Rhode Island',
	   'South Carolina', 'South Dakota', qw/Tennessee Texas Utah Vermont
	   Virginia Washington/, 'West Virginia', 'Wisconsin', 'Wyoming');

sub get_state_name {
    my $state_num = shift;

    return $states[$state_num - 1];
}

sub get_state_list {
    my $num_list = shift;

    my ($state_num, @state_list);
    foreach $state_num (@$num_list) {
	push @state_list, $states[$state_num - 1];
    }

    return join(',', @state_list);
}

sub get_state_struct {
    my $struct = shift;

    my ($state_num, @state_list);
    foreach $state_num (values %$struct) {
	push @state_list, $states[$state_num - 1];
    }

    return join(',', @state_list);
}

sub echo {
    return [@_];
}
    

new Frontier::Daemon
    LocalPort => 8000,
    methods => {
	'examples.getStateName'   => \&get_state_name,
	'examples.getStateList'   => \&get_state_list,
	'examples.getStateStruct' => \&get_state_struct,
	'echo'                    => \&echo,
    };
