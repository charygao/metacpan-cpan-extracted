package CSS::Prepare::Property::Padding;

use Modern::Perl;
use CSS::Prepare::Property::Expansions;
use CSS::Prepare::Property::Values;



sub parse {
    my $self        = shift;
    my $has_hack    = shift;
    my $location    = shift;
    my %declaration = @_;
    
    my $property = $declaration{'property'};
    my $value    = $declaration{'value'};
    my %canonical;
    my @errors;
    
    my $valid_property_or_error = sub {
            my $type  = shift;
            
            my $sub      = "is_${type}_value";
            my $is_valid = 0;
            
            eval {
                no strict 'refs';
                $is_valid = &$sub( $value );
            };
            
            if ( $is_valid ) {
                $canonical{ $property } = shorten_length_value( $value );
            }
            else {
                $type =~ s{_}{-}g;
                push @errors, {
                        error => "invalid ${type} property: '${value}'"
                    };
            }
        };
    
    foreach my $direction qw( top right bottom left ) {
        &$valid_property_or_error( 'padding_width' )
            if "padding-${direction}" eq $property;
    }
    
    if ( 'padding' eq $property ) {
        my $shorthand_properties = qr{
                ^
                (?: $padding_width_value )
                (?: \s+ $padding_width_value )?
                (?: \s+ $padding_width_value )?
                (?: \s+ $padding_width_value )?
                $
            }x;
        
        if ( $value =~ m{$shorthand_properties}x ) {
            %canonical = expand_trbl_shorthand(
                    'padding-%s',
                    $value
                );
        }
        else {
            push @errors, {
                    error => "invalid padding property: '${value}'"
                };
        }
    }
    
    return \%canonical, \@errors;
}
sub output {
    my $self  = shift;
    my $block = shift;
    
    my @padding;
    my @output;
    foreach my $direction qw( top right bottom left ) {
        my $key = "padding-${direction}";
        my $value = $block->{ $key };
        
        push @padding,
            sprintf $self->output_format, "${key}:", $value
                if defined $value;
    }
    
    if ( 4 == scalar @padding ) {
        my( $value, undef )
            = collapse_trbl_shorthand( 'padding-%s', $block );
        push @output, sprintf $self->output_format, "padding:", $value;
    }
    else {
        push @output, @padding;
    }
    
    return @output;
}

1;
