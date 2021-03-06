package Template::Like::Plugin::Dumper;

use strict;
use Data::Dumper;

#=====================================================================
# new
#---------------------------------------------------------------------
# - API
# <% USE Dumper %>
# <% Dumper.dump(variable) %>
#---------------------------------------------------------------------
# - args
# $params ... PARAMS ( HASHREF )
#---------------------------------------------------------------------
# - returns
# Template::Like::Plugin::Dumper Object.
#---------------------------------------------------------------------
# - Example
# <% USE Dumper(indent=4) %>
# <% Dumper.dump(variable) %>
#=====================================================================
sub new {
  my $class   = shift;
  my $context = shift;
  my $params  = ref $_[0] ? $_[0] : {@_};
  
  my $dumper = Data::Dumper->new([]);
  
  for my $key ( keys %{ $params } ) {
    my $method = ucfirst( $key );
    if ($dumper->can($method)) {
      $dumper->$method( $params->{ $key } );
    }
  }
  
  return bless { _CONTEXT => $context, dumper => $dumper }, $class;
}



#=====================================================================
# dump
#---------------------------------------------------------------------
# - API
# 
#---------------------------------------------------------------------
# - args
# 
#---------------------------------------------------------------------
# - returns
# 
#---------------------------------------------------------------------
# - Example
# <% Dumper.dump(variable) %>
#=====================================================================
sub dump {
  my $self = shift;
  
  $self->dumper->Reset;
  $self->dumper->Values(\@_);
  
  my $data = $self->dumper->Dump(@_);
  
  return $data;
}

#=====================================================================
# dump_html
#---------------------------------------------------------------------
# - API
# 
#---------------------------------------------------------------------
# - args
# 
#---------------------------------------------------------------------
# - returns
# 
#---------------------------------------------------------------------
# - Example
# <% Dumper.dump_html(variable) %>
#=====================================================================
sub dump_html {
  my $self = shift;
  
  my $data = $self->dump(@_);
  
  return $self->{'_CONTEXT'}->filter('html_line_break',
    $self->{'_CONTEXT'}->filter('html', $data)
  );
}

#=====================================================================
# Data::Dumper Object
#=====================================================================
sub dumper { shift->{'dumper'} }

1;