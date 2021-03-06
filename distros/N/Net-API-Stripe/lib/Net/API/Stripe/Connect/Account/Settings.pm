##----------------------------------------------------------------------------
## Stripe API - ~/lib/Net/API/Stripe/Connect/Account/Settings.pm
## Version v0.100.0
## Copyright(c) 2019 DEGUEST Pte. Ltd.
## Author: Jacques Deguest <@sitael.tokyo.deguest.jp>
## Created 2019/11/02
## Modified 2020/05/15
## 
##----------------------------------------------------------------------------
package Net::API::Stripe::Connect::Account::Settings;
BEGIN
{
	use strict;
	use parent qw( Net::API::Stripe::Generic );
	our( $VERSION ) = 'v0.100.0';
};

sub branding { return( shift->_set_get_object( 'branding', 'Net::API::Stripe::Connect::Account::Branding', @_ ) ); }

sub card_payments { return( shift->_set_get_object( 'card_payments', 'Net::API::Stripe::Connect::Account::Settings::CardPayments', @_ ) ); }

sub dashboard { return( shift->_set_get_object( 'dashboard', 'Net::API::Stripe::Connect::Account::Settings::Dashboard', @_ ) ); }

sub payments { return( shift->_set_get_object( 'payments', 'Net::API::Stripe::Connect::Account::Settings::Payments', @_ ) ); }

sub payouts { return( shift->_set_get_object( 'payouts', 'Net::API::Stripe::Connect::Account::Settings::Payouts', @_ ) ); }

1;

__END__

=encoding utf8

=head1 NAME

Net::API::Stripe::Connect::Account::Settings - A Stripe Account Settings Object

=head1 SYNOPSIS

    my $settings = $stripe->account->settings({
        branding => $branding_object,
        card_payments => $card_payments_object,
        dashboard => $dashboard_object,
        payments => $payments_object,
        payouts => $payouts_object,
    });

=head1 VERSION

    v0.100.0

=head1 DESCRIPTION

Options for customizing how the account functions within Stripe.

This is instantiated by method B<settings> from module L<Net::API::Stripe::Connect::Account>

=head1 CONSTRUCTOR

=over 4

=item B<new>( %ARG )

Creates a new L<Net::API::Stripe::Connect::Account::Settings> object.
It may also take an hash like arguments, that also are method of the same name.

=back

=head1 METHODS

=over 4

=item B<branding> hash

Settings used to apply the account’s branding to email receipts, invoices, Checkout, and other products.

This is a L<Net::API::Stripe::Connect::Account::Branding> object.

=item B<card_payments> hash

Settings specific to card charging on the account.

This is a L<Net::API::Stripe::Connect::Account::Settings::CardPayments> object.

=item B<dashboard> hash

Settings used to configure the account within the Stripe dashboard.

This is a L<Net::API::Stripe::Connect::Account::Settings::Dashboard> object.

=item B<payments> hash

Settings that apply across payment methods for charging on the account.

This is a L<Net::API::Stripe::Connect::Account::Settings::Payments> object.

=item B<payouts> hash

Settings specific to the account’s payouts. This is a L<Net::API::Stripe::Connect::Account::Settings::Payouts> object.

=back

=head1 API SAMPLE

	{
	  "id": "acct_fake123456789",
	  "object": "account",
	  "business_profile": {
		"mcc": null,
		"name": "My Shop, Inc",
		"product_description": "Great products shipping all over the world",
		"support_address": {
		  "city": "Tokyo",
		  "country": "JP",
		  "line1": "1-2-3 Kudan-minami, Chiyoda-ku",
		  "line2": "",
		  "postal_code": "100-0012",
		  "state": ""
		},
		"support_email": "billing@example.com",
		"support_phone": "+81312345678",
		"support_url": "",
		"url": "https://www.example.com"
	  },
	  "business_type": "company",
	  "capabilities": {
		"card_payments": "active"
	  },
	  "charges_enabled": true,
	  "country": "JP",
	  "default_currency": "jpy",
	  "details_submitted": true,
	  "email": "tech@example.com",
	  "metadata": {},
	  "payouts_enabled": true,
	  "settings": {
		"branding": {
		  "icon": "file_fake123456789",
		  "logo": null,
		  "primary_color": "#0e77ca"
		},
		"card_payments": {
		  "decline_on": {
			"avs_failure": false,
			"cvc_failure": false
		  },
		  "statement_descriptor_prefix": null
		},
		"dashboard": {
		  "display_name": "myshop-inc",
		  "timezone": "Asia/Tokyo"
		},
		"payments": {
		  "statement_descriptor": "MYSHOP, INC",
		  "statement_descriptor_kana": "ﾏｲｼｮｯﾌﾟｲﾝｸ",
		  "statement_descriptor_kanji": "マイショップインク"
		},
		"payouts": {
		  "debit_negative_balances": true,
		  "schedule": {
			"delay_days": 4,
			"interval": "weekly",
			"weekly_anchor": "thursday"
		  },
		  "statement_descriptor": null
		}
	  },
	  "type": "standard"
	}

=head1 HISTORY

=head2 v0.1

Initial version

=head1 AUTHOR

Jacques Deguest E<lt>F<jack@deguest.jp>E<gt>

=head1 SEE ALSO

Stripe API documentation:

L<https://stripe.com/docs/api/accounts/object>

=head1 COPYRIGHT & LICENSE

Copyright (c) 2019-2020 DEGUEST Pte. Ltd.

You can use, copy, modify and redistribute this package and associated
files under the same terms as Perl itself.

=cut
