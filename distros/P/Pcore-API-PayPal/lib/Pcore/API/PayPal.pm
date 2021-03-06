package Pcore::API::PayPal v0.3.5;

use Pcore -dist, -class, -res, -const;
use Pcore::Util::Data qw[from_json to_json to_b64];

const our $SANDBOX_ENDPOINT => 'https://api.sandbox.paypal.com';
const our $LIVE_ENDPOINT    => 'https://api.paypal.com';

has id     => ( required => 1 );
has secret => ( required => 1 );
has sandbox => (1);    # Bool

has _access_token => ( init_arg => undef );

sub _get_access_token ( $self, $cb ) {
    if ( $self->{_access_token} && $self->{_access_token}->{expires} > time ) {
        $cb->( $self->{_access_token} );

        return;
    }

    P->http->post(
        ( $self->{sandbox} ? $SANDBOX_ENDPOINT : $LIVE_ENDPOINT ) . '/v1/oauth2/token',
        headers => [
            'Content-Type' => 'application/x-www-form-urlencoded',
            Acccept        => 'application/json',
            Authorization  => 'Basic ' . to_b64( "$self->{id}:$self->{secret}", $EMPTY ),
        ],
        data => 'grant_type=client_credentials',
        sub ($res) {
            $self->{_access_token} = from_json $res->{data};

            $self->{_access_token}->{expires} = time + $self->{_access_token}->{expires_in} - 5;

            $cb->( $self->{_access_token} );

            return;
        }
    );

    return;
}

# https://developer.paypal.com/docs/api/payments/#payment_create
sub create_payment ( $self, $payment, $cb ) {
    $self->_get_access_token( sub ($access_token) {
        my $url = ( $self->{sandbox} ? $SANDBOX_ENDPOINT : $LIVE_ENDPOINT ) . '/v1/payments/payment';

        P->http->post(
            $url,
            headers => [
                'Content-Type' => 'application/json',
                Acccept        => 'application/json',
                Authorization  => "$access_token->{token_type} $access_token->{access_token}",
            ],
            data => to_json($payment),
            sub ($res) {
                my $api_res;

                if ( !$res ) {
                    my $data = $res->{data} ? from_json $res->{data} : {};

                    $api_res = res [ $res->{status}, $data->{message} // $res->{reason} ];
                }
                else {
                    my $data = from_json $res->{data};

                    if ( $data->{state} eq 'failed' ) {
                        $api_res = res [ 400, $data->{failure_reason} ], $data;
                    }
                    else {
                        $api_res = res 200, $data;
                    }
                }

                $cb->($api_res);

                return;
            }
        );

        return;
    } );

    return;
}

# https://developer.paypal.com/docs/api/payments/#payment_execute
sub exec_payment ( $self, $payment_id, $payer_id, $cb ) {
    $self->_get_access_token( sub ($access_token) {
        my $url = ( $self->{sandbox} ? $SANDBOX_ENDPOINT : $LIVE_ENDPOINT ) . "/v1/payments/payment/$payment_id/execute";

        P->http->post(
            $url,
            headers => [
                'Content-Type' => 'application/json',
                Acccept        => 'application/json',
                Authorization  => "$access_token->{token_type} $access_token->{access_token}",
            ],
            data => to_json( { payer_id => $payer_id } ),
            sub ($res) {
                my $api_res;

                if ( !$res ) {
                    my $data = $res->{data} ? from_json $res->{data} : {};

                    $api_res = res [ $res->{status}, $data->{message} // $res->{reason} ];
                }
                else {
                    my $data = from_json $res->{data};

                    if ( $data->{state} eq 'failed' ) {
                        $api_res = res [ 400, $data->{failure_reason} ], $data;
                    }
                    else {
                        $api_res = res 200, $data;
                    }
                }

                $cb->($api_res);

                return;
            }
        );

        return;
    } );

    return;
}

# https://developer.paypal.com/docs/api/payments.payouts-batch#payouts
sub payout ( $self, $payment, $cb ) {
    $self->_get_access_token( sub ($access_token) {
        my $url = ( $self->{sandbox} ? $SANDBOX_ENDPOINT : $LIVE_ENDPOINT ) . '/v1/payments/payouts?sync_mode=true';

        P->http->post(
            $url,
            headers => [
                'Content-Type' => 'application/json',
                Acccept        => 'application/json',
                Authorization  => "$access_token->{token_type} $access_token->{access_token}",
            ],
            data => to_json($payment),
            sub ($res) {
                my $api_res;

                if ( !$res ) {
                    my $data = $res->{data} ? from_json $res->{data} : {};

                    $api_res = res [ $res->{status}, $res->{reason} ], $data;
                }
                else {
                    my $data = from_json $res->{data};

                    $api_res = res 200, $data;
                }

                $cb->($api_res);

                return;
            }
        );

        return;
    } );

    return;
}

1;
## -----SOURCE FILTER LOG BEGIN-----
##
## PerlCritic profile "pcore-script" policy violations:
## +------+----------------------+----------------------------------------------------------------------------------------------------------------+
## | Sev. | Lines                | Policy                                                                                                         |
## |======+======================+================================================================================================================|
## |    3 | 89                   | Subroutines::ProhibitManyArgs - Too many arguments                                                             |
## +------+----------------------+----------------------------------------------------------------------------------------------------------------+
##
## -----SOURCE FILTER LOG END-----
__END__
=pod

=encoding utf8

=head1 NAME

Pcore::API::PayPal

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=head1 METHODS

=head1 SEE ALSO

=head1 AUTHOR

zdm <zdm@softvisio.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by zdm.

=cut
