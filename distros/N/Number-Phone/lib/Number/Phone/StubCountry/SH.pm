# automatically generated file, don't edit



# Copyright 2011 David Cantrell, derived from data from libphonenumber
# http://code.google.com/p/libphonenumber/
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
package Number::Phone::StubCountry::SH;
use base qw(Number::Phone::StubCountry);

use strict;
use warnings;
use utf8;
our $VERSION = 1.20200606132001;

my $formatters = [];

my $validators = {
                'fixed_line' => '
          2(?:
            [0-57-9]\\d|
            6[4-9]
          )\\d\\d
        ',
                'geographic' => '
          2(?:
            [0-57-9]\\d|
            6[4-9]
          )\\d\\d
        ',
                'mobile' => '[56]\\d{4}',
                'pager' => '',
                'personal_number' => '',
                'specialrate' => '',
                'toll_free' => '',
                'voip' => '262\\d\\d'
              };
my %areanames = ();
$areanames{fr}->{29022} = "Jamestown";
$areanames{fr}->{29023} = "Sainte\-Hélène";
$areanames{fr}->{29024} = "Sainte\-Hélène";
$areanames{fr}->{290264} = "Sainte\-Hélène";
$areanames{fr}->{290265} = "Sainte\-Hélène";
$areanames{fr}->{290266} = "Sainte\-Hélène";
$areanames{fr}->{290267} = "Sainte\-Hélène";
$areanames{fr}->{290268} = "Sainte\-Hélène";
$areanames{fr}->{290269} = "Sainte\-Hélène";
$areanames{fr}->{29027} = "Sainte\-Hélène";
$areanames{fr}->{2908} = "Tristan\ da\ Cunha";
$areanames{en}->{29022} = "Jamestown";
$areanames{en}->{29023} = "St\.\ Helena";
$areanames{en}->{29024} = "St\.\ Helena";
$areanames{en}->{290264} = "St\.\ Helena";
$areanames{en}->{290265} = "St\.\ Helena";
$areanames{en}->{290266} = "St\.\ Helena";
$areanames{en}->{290267} = "St\.\ Helena";
$areanames{en}->{290268} = "St\.\ Helena";
$areanames{en}->{290269} = "St\.\ Helena";
$areanames{en}->{29027} = "St\.\ Helena";
$areanames{en}->{2908} = "Tristan\ da\ Cunha";

    sub new {
      my $class = shift;
      my $number = shift;
      $number =~ s/(^\+290|\D)//g;
      my $self = bless({ number => $number, formatters => $formatters, validators => $validators, areanames => \%areanames}, $class);
        return $self->is_valid() ? $self : undef;
    }
1;