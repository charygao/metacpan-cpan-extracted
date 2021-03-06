#!/usr/bin/perl 

package GrabzItBaseOptions;

use URI::Escape;

sub new
{
    my $class = shift;       
    
    my $self = { };
    $self->{"customId"} = '';
    $self->{"country"} = '';
    $self->{"exportURL"} = '';
    $self->{"encryptionKey"} = '';
    $self->{"delay"} = 0;
	$self->{"post"} = '';
	$self->{"proxy"} = '';

    bless $self, $class;

    return $self;
}

#
# The custom identifier that you are passing through to the web service
#
sub customId
{
    my $self = shift;   
    if (scalar(@_) == 1)
    {
        $self->{"customId"} = shift;
    }
    return $self->{"customId"};
}

#
# The country the capture should be created from: Default = "", Singapore = "SG", UK = "UK", US = "US"
#
sub country
{
    my $self = shift;   
    if (scalar(@_) == 1)
    {
        $self->{"country"} = shift;
    }
    return $self->{"country"};
}

#
# The encryption key that will be used to encrypt your capture
#
sub encryptionKey
{
    my $self = shift;   
    if (scalar(@_) == 1)
    {
        $self->{"encryptionKey"} = shift;
    }
    return $self->{"encryptionKey"};
}

#
# The export URL that should be used to transfer the capture to a third party location
#
sub exportURL
{
    my $self = shift;   
    if (scalar(@_) == 1)
    {
        $self->{"exportURL"} = shift;
    }
    return $self->{"exportURL"};
}

#
# The HTTP proxy that should be used to create the capture
#
sub proxy
{
    my $self = shift;   
    if (scalar(@_) == 1)
    {
        $self->{"proxy"} = shift;
    }
    return $self->{"proxy"};
}

sub _appendPostParameter($$$)
{
	my ($self, $qs, $name, $value) = @_;
	my $val = '';
	if ($name ne '')
	{
		$val = uri_escape($name);
		$val .= "=";
		if ($value ne '')
		{
			$val .= uri_escape($value);
		}
	}
	if ($val eq '')
	{
		return $qs;
	}
	if ($qs ne '')
	{
		$qs .= "&"; 
	}
	$qs .= $val;
	return $qs;
}

sub createParameters($$$$$)
{
    my ($self, $applicationKey, $sig, $callBackURL, $dataName, $dataValue) = @_;
    
    my %params = {}; 
    $params->{'key'} = $applicationKey;
    $params->{'country'} = $self->country();
    $params->{'export'} = $self->exportURL();
    $params->{'encryption'} = $self->encryptionKey();
	$params->{'proxy'} = $self->proxy();
    $params->{'customid'} = $self->customId();
    $params->{'callback'} = $callBackURL;
    $params->{'sig'} = $sig;
    $params->{$dataName} = $dataValue;
    
    return $params;
}
1;