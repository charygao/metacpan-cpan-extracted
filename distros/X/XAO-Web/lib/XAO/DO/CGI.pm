=head1 NAME

XAO::DO::CGI - CGI interface for XAO::Web

=head1 DESCRIPTION

This is an extension of the standard CGI package that overrides its param()
method. If the current site has a 'charset' parameter in siteconfig then
parameters received from CGI are decoded from that charset into Perl
native unicode strings.

=over

=cut

###############################################################################
package XAO::DO::CGI;
use strict;
use Encode;
use XAO::Utils;
use XAO::Objects;

###############################################################################

sub new ($%) {
    my $proto=shift;
    my $args=get_args(\@_);

    my $cgi;
    if($args->{'cgi'}) {
        $cgi=$args->{'cgi'};
    }
    elsif($args->{'query'}) {
        require CGI;
        $cgi=CGI->new($args->{'query'});
    }
    elsif($args->{'no_cgi'}) {
        require CGI;
        $cgi=CGI->new('foo=bar');
    }
    else {
        require CGI;
        $cgi=CGI->new();
    }

    $cgi || die "Cannot create proxied CGI instance";

    my $self={
        cgi => $cgi,
    };

    bless $self,ref($proto) || $proto;
}

###############################################################################

our $AUTOLOAD;

sub AUTOLOAD {
    my $self=shift;
    return undef if !$self->{'cgi'};
    my @mpath=split('::',$AUTOLOAD);
    my $method=$mpath[$#mpath];
    my $code=$self->{'cgi'}->can($method);
    if(!$code) {
        return if $method eq 'DESTROY';
        die "No method $method on $self->{'cgi'}";
    }
    return $code->($self->{'cgi'},@_);
}

###############################################################################

sub can {
    my ($self,$method)=@_;
    return $self->SUPER::can($method) || $self->{'cgi'}->can($method);
}

###############################################################################

sub cookie ($@) {
    my $self=shift;
    if(@_) {
        my @c1=caller(1);
        if(!@c1 || $c1[3]!~/get_cookie/) {
            my @c0=caller(0);
            eprint "Using CGI::cookie() method is deprecated, consider switching to \$config->get_cookie() in ".join(':',map { $_ || '<undef>' } ($c0[1],$c0[2]));
        }
    }
    return $self->{'cgi'}->cookie(@_);
}

###############################################################################

sub set_param_charset($$) {
    my ($self,$charset)=@_;

    my $old=$self->{'xao_param_charset'};
    $self->{'xao_param_charset'}=$charset;

    return $old;
}

###############################################################################

sub get_param_charset($$) {
    my $self=shift;
    return $self->{'xao_param_charset'};
}

###############################################################################

sub param ($;$) {
    my $self=shift;

    my $charset=$self->{'xao_param_charset'};

    if(!$charset) {
        if(wantarray) {
            return $self->{'cgi'}->multi_param(@_);
        }
        else {
            return $self->{'cgi'}->param(@_);
        }
    }
    else {
        if(wantarray) {
            return map {
                ref($_) ? $_ : Encode::decode($charset,$_)
            } $self->{'cgi'}->multi_param(@_);
        }
        else {
            my $value=$self->{'cgi'}->param(@_);
            return ref($value) ? $value : Encode::decode($charset,$value);
        }
    }
}

###############################################################################

sub Vars ($) {
    my $self=shift;

    my $charset=$self->{'xao_param_charset'};

    if(!$charset) {
        return $self->{'cgi'}->Vars();
    }

    # There is a known incompatibility in this implementation -- our
    # hash is never tied and cannot be used to modify the CGI object
    # values.
    #
    my %vb=$self->{'cgi'}->Vars();
    my %vu;
    foreach my $param (keys %vb) {
        $vu{Encode::decode($charset,$param)}=Encode::decode($charset,$vb{$param});
    }

    return wantarray ? %vu : \%vu;
}

###############################################################################

sub multi_param ($;$) {
    my $self=shift;
    return $self->param(@_);
}

###############################################################################
1;
__END__

=back

=head1 AUTHORS

Copyright (c) 2006 Ejelta LLC
Andrew Maltsev, am@ejelta.com
