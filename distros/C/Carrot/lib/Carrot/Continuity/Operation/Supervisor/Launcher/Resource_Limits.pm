﻿package Carrot::Continuity::Operation::Supervisor::Launcher::Resource_Limits
# /type class
# /implements [=component_pkg=]::_Plugin_Prototype
# /attribute_type ::Many_Declared::Ordered
# /capability "Enforce resource limits upon a process."
{
	use strict;
	use warnings 'FATAL' => 'all';

# =--------------------------------------------------------------------------= #

sub attribute_construction
# /type method
# /effect "Constructs the attribute(s) of a newly created instance."
# //parameters
#	setting  +multiple
# //returns
{
	my $this = shift(\@ARGUMENTS);

	$this->[ATR_SETTINGS] = {};
	foreach my $setting (@ARGUMENTS)
	{
		if ($setting =~ m{^(\w+)=(.*)$})
		{
			$this->[ATR_SETTINGS]{$1} = $2;

		} else {
			die("Unknown format of resource limit '$setting'.");
		}
	}
	return;
}

sub effect
# /type implementation
{
	my ($this) = @ARGUMENTS;

	while (my ($name, $value) = each($this->[ATR_SETTINGS]))
	{
#FIXME
	}

	return;
}

# =--------------------------------------------------------------------------= #

	return(PERL_FILE_LOADED);
}
# //revision_control
#	version 1.1.100
#	branch main
#	maturity alpha
# /license MPL-2.0 (Mozilla Public License v2.0)
# /copyright "(C) 2009-2014 Winfried Trümper <win@carrot-programming.org>"