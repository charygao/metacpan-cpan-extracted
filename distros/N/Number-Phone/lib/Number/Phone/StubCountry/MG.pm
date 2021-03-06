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
package Number::Phone::StubCountry::MG;
use base qw(Number::Phone::StubCountry);

use strict;
use warnings;
use utf8;
our $VERSION = 1.20200606132000;

my $formatters = [
                {
                  'format' => '$1 $2 $3 $4',
                  'leading_digits' => '[23]',
                  'national_rule' => '0$1',
                  'pattern' => '(\\d{2})(\\d{2})(\\d{3})(\\d{2})'
                }
              ];

my $validators = {
                'fixed_line' => '
          2072[29]\\d{4}|
          20(?:
            2\\d|
            4[47]|
            5[3467]|
            6[279]|
            7[35]|
            8[268]|
            9[245]
          )\\d{5}
        ',
                'geographic' => '
          2072[29]\\d{4}|
          20(?:
            2\\d|
            4[47]|
            5[3467]|
            6[279]|
            7[35]|
            8[268]|
            9[245]
          )\\d{5}
        ',
                'mobile' => '3[2-49]\\d{7}',
                'pager' => '',
                'personal_number' => '',
                'specialrate' => '',
                'toll_free' => '',
                'voip' => '22\\d{7}'
              };
my %areanames = ();
$areanames{en}->{2612022} = "Antananarivo";
$areanames{en}->{2612044} = "Antsirabe";
$areanames{en}->{2612047} = "Ambositra";
$areanames{en}->{2612053} = "Toamasina";
$areanames{en}->{2612054} = "Ambatondrazaka";
$areanames{en}->{2612056} = "Moramanga";
$areanames{en}->{2612057} = "Maroantsetra\/Sainte\ Marie";
$areanames{en}->{2612062} = "Mahajanga";
$areanames{en}->{2612067} = "Antsohihy";
$areanames{en}->{2612069} = "Maintirano";
$areanames{en}->{26120722} = "Manakara";
$areanames{en}->{26120729} = "Mananjary";
$areanames{en}->{2612073} = "Farafangana";
$areanames{en}->{2612075} = "Fianarantsoa";
$areanames{en}->{2612082} = "Antsiranana";
$areanames{en}->{2612086} = "Nosy\ Be";
$areanames{en}->{2612088} = "Sambava";
$areanames{en}->{2612092} = "Taolañaro";
$areanames{en}->{2612094} = "Toliary";
$areanames{en}->{2612095} = "Morondava";

    sub new {
      my $class = shift;
      my $number = shift;
      $number =~ s/(^\+261|\D)//g;
      my $self = bless({ number => $number, formatters => $formatters, validators => $validators, areanames => \%areanames}, $class);
      return $self if ($self->is_valid());
      my $prefix = qr/^(?:0|([24-9]\d{6})$)/;
      my @matches = $number =~ /$prefix/;
      if (defined $matches[-1]) {
        no warnings 'uninitialized';
        $number =~ s/$prefix/20$1/;
      }
      else {
        $number =~ s/$prefix//;
      }
      $self = bless({ number => $number, formatters => $formatters, validators => $validators, areanames => \%areanames}, $class);
      return $self->is_valid() ? $self : undef;
    }
1;