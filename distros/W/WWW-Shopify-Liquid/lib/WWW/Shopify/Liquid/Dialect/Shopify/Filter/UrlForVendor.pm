#!/usr/bin/perl
use strict;
use warnings;

package WWW::Shopify::Liquid::Dialect::Shopify::Filter::UrlForVendor; use base 'WWW::Shopify::Liquid::Filter';
sub max_arguments { return 1; }
sub operate { return "/collections/vendors?q=" . uri_escape($_[3]); }

1;