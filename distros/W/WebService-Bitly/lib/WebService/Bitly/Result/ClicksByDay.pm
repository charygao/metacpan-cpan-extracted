package WebService::Bitly::Result::ClicksByDay;

use warnings;
use strict;
use Carp;

use base qw(WebService::Bitly::Result);

use WebService::Bitly::Util;

sub new {
    my ($class, $result_clicks) = @_;
    my $self = $class->SUPER::new($result_clicks);

    $self->{results}
        = WebService::Bitly::Util->make_entries($self->data->{clicks_by_day});
    for my $result ($self->results) {   # nest Entry object
        my $clicks = WebService::Bitly::Util->make_entries($result->clicks);
        $result->{clicks} = $clicks;
    }

    return $self;
}

sub results {
    my $results = shift->{results};
    return wantarray ? @$results : $results;
}

1;
