#!/usr/bin/env perl
use strict;
use warnings;

use lib qw(../../lib);
use Config::Pit;
use WebService::DMM;

use utf8;
binmode STDOUT, ":utf8";

my $config = pit_get('dmm.co.jp', require => {
    affiliate_id => 'DMM Affiliate ID',
    api_id       => 'DMM API ID',
});

my $dmm = WebService::DMM->new(
    affiliate_id => $config->{affiliate_id},
    api_id       => $config->{api_id},
);

my $res = $dmm->search(
    site    => 'DMM.com',
    sort    => 'date',
    service => 'monthly',
    floor   => 'cinepara',
    hits    => 10,
);

my $index = 1;
for my $item (@{ $res->items }) {
    printf "[%2d] %s\n", $index, $item->title;
    for my $actor (@{$item->actors}) {
        printf "\t%s(%s)\n", $actor->name, $actor->id;
    }
    $index++;
}
