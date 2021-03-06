package Strehler::FormFu::Element::Category;
$Strehler::FormFu::Element::Category::VERSION = '1.6.8';
use strict;
use Moose;

extends 'HTML::FormFu::Element::Fieldset';

has _name => (
    is => 'rw',
    default => sub { [] },
    lazy => 1,
);

has _label => (
    is => 'rw',
    default => sub { [] },
    lazy => 1,
);

has _not_required => (
    is => 'rw',
    default => sub { [] },
    lazy => 1,
);




after BUILD => sub {
    my $self = shift;
    my $root_path = __FILE__;
    $root_path =~ s/FormFu\/Element\/Category\.pm//;
    $self->load_config_file($root_path . "forms/admin/elements/category_multi.yml");
    return;
};

sub label { ## no critic qw(Subroutines::RequireArgUnpacking)
    my ( $self, $arg ) = @_;

    return $self->_label if @_ == 1;

    if ( defined $arg ) {
        $self->_label($arg);
        $self->get_all_element({ name => 'category-name' })->label($arg);
    }
    return $self;
}
sub name { ## no critic qw(Subroutines::RequireArgUnpacking)
    my ( $self, $arg ) = @_;

    return $self->_name if @_ == 1;

    if ( defined $arg ) {
        $self->_name($arg);
        my $name_element = $self->get_element({ name => 'category' });
        if($name_element)
        {
            $name_element->name($arg);
            $name_element->id($arg);
        }
    }
    return $self;
}
sub not_required { ## no critic qw(Subroutines::RequireArgUnpacking)
    my ( $self, $arg ) = @_;
    return $self->_not_required if @_ == 1;
    if ( defined $arg ) {
        $self->_not_required($arg);
        if($arg == 1)
        {
            $self->get_all_element({ name => 'category-name' })->_constraints([]);
        }
    }

    return;
} 

=encoding utf8

=head1 NAME

Strehler::FormFu::Element::Category - FormFu Element for Strehler Category Selector.

=head1 DESCRIPTION

A FormFu element to encapsulate all the frontend logic for category selection. It's just a Block element with a particular configuration file hard-coded in it.
Category selector needs to be identified in a clear way and needs a fixed structure because it has to interact with Strehler javascript library.

This element hasn't the standard HTML::FormFu elements namespace because it makes sense only in a Strehler system.

=head1 SYNOPSIS

In article form:

    - type: "+Strehler::FormFu::Element::Category"

=head1 PARAMETERS

=over 4

=item label

The label displayed for the field. "Category" is the default value.

=item name

The name of the field containing information about the category (the ID). "category" is the default value.

=item not_required

Category is usually mandatory on categorized entities. If you want a category field NOT required set this parameter to 1.

=back

=head1 GENERATED HTML

    <fieldset class="category-widget">
        <div class="sel-category-input">
            <div>
                <label>Category</label>
                <input name="category-name" type="text" class="sel-category-name">
            </div>
            <button class="btn btn-warning sel-category-back" type="button">
                &lt;
            </button>
            <img class="sel-category-loader" 
                 src="/strehler/images/ajax-loader.gif" 
                 style="display: none;">
        </div>
        <div>
            <select name="category-combo" class="sel-category-combo">
                <option value="1">cat1</option>
                <option value="2">cat2</option>
            </select>
        </div>
        <input name="category" type="hidden" value="22" class="sel-category-id" id="category">
        <input name="category-parent" type="hidden" class="sel-category-parent" value="">
    </fieldset>


Options are inserted dinamically during form generation.
Sub-category display attributed is managed by javascript.

=head1 YAML CONFIGURATION

For the complete configuration see in the package: forms/admin/elements/category_multi.yml

=cut

1;
