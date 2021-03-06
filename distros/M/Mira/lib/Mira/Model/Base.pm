package Mira::Model::Base;
$Mira::Model::Base::VERSION = '00.07.56';

use strict;
use warnings;
use 5.012;

sub new {
  my $class = shift;
  my $self = {};

  bless $self, $class;
  return $self;
}

sub add {
  my $self = shift;
  my $utid = shift;
  my $values = shift;

  $self->{$utid} = $values;

}

1;
