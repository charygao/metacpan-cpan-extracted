package Sah::SchemaR::cryptoexchange::currency_pair;

our $DATE = '2020-03-08'; # DATE
our $VERSION = '0.015'; # VERSION

our $rschema = ["str",[{description=>"\nCurrency pair is string in the form of *currency1*/*currency2*, where\n*currency1* is called the base currency and must be a known cryptocurrency code\n(e.g. LTC) while *currency2* is the quote (or price) currency and must be a\nknown fiat currency or a known cryptocurrency code (e.g. USD, or BTC).\n\nCryptocurrency code is checked against catalog in <pm:CryptoCurrency::Catalog>,\nwhile fiat currency code is checked against <pm:Locale::Codes::Currency_Codes>.\n\nWill be normalized to uppercase.\n\n",match=>qr(\A\S+/\S+\z),summary=>"Currency pair, e.g. LTC/USD","x.perl.coerce_rules"=>["From_str::to_cryptoexchange_currency_pair"]}],["str"]];

1;
# ABSTRACT: Currency pair, e.g. LTC/USD

__END__

=pod

=encoding UTF-8

=head1 NAME

Sah::SchemaR::cryptoexchange::currency_pair - Currency pair, e.g. LTC/USD

=head1 VERSION

This document describes version 0.015 of Sah::SchemaR::cryptoexchange::currency_pair (from Perl distribution Sah-Schemas-CryptoCurrency), released on 2020-03-08.

=head1 DESCRIPTION

This module is automatically generated by Dist::Zilla::Plugin::Sah::Schemas during distribution build.

A Sah::SchemaR::* module is useful if a client wants to quickly lookup the base type of a schema without having to do any extra resolving. With Sah::Schema::*, one might need to do several lookups if a schema is based on another schema, and so on. Compare for example L<Sah::Schema::poseven> vs L<Sah::SchemaR::poseven>, where in Sah::SchemaR::poseven one can immediately get that the base type is C<int>. Currently L<Perinci::Sub::Complete> uses Sah::SchemaR::* instead of Sah::Schema::* for reduced startup overhead when doing tab completion.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Sah-Schemas-CryptoCurrency>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Sah-Schemas-CryptoCurrency>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Sah-Schemas-CryptoCurrency>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2020, 2019, 2018 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
