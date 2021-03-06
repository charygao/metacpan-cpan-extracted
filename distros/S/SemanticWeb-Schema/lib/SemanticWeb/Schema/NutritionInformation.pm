use utf8;

package SemanticWeb::Schema::NutritionInformation;

# ABSTRACT: Nutritional information about the recipe.

use Moo;

extends qw/ SemanticWeb::Schema::StructuredValue /;


use MooX::JSON_LD 'NutritionInformation';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v9.0.0';


has calories => (
    is        => 'rw',
    predicate => '_has_calories',
    json_ld   => 'calories',
);



has carbohydrate_content => (
    is        => 'rw',
    predicate => '_has_carbohydrate_content',
    json_ld   => 'carbohydrateContent',
);



has cholesterol_content => (
    is        => 'rw',
    predicate => '_has_cholesterol_content',
    json_ld   => 'cholesterolContent',
);



has fat_content => (
    is        => 'rw',
    predicate => '_has_fat_content',
    json_ld   => 'fatContent',
);



has fiber_content => (
    is        => 'rw',
    predicate => '_has_fiber_content',
    json_ld   => 'fiberContent',
);



has protein_content => (
    is        => 'rw',
    predicate => '_has_protein_content',
    json_ld   => 'proteinContent',
);



has saturated_fat_content => (
    is        => 'rw',
    predicate => '_has_saturated_fat_content',
    json_ld   => 'saturatedFatContent',
);



has serving_size => (
    is        => 'rw',
    predicate => '_has_serving_size',
    json_ld   => 'servingSize',
);



has sodium_content => (
    is        => 'rw',
    predicate => '_has_sodium_content',
    json_ld   => 'sodiumContent',
);



has sugar_content => (
    is        => 'rw',
    predicate => '_has_sugar_content',
    json_ld   => 'sugarContent',
);



has trans_fat_content => (
    is        => 'rw',
    predicate => '_has_trans_fat_content',
    json_ld   => 'transFatContent',
);



has unsaturated_fat_content => (
    is        => 'rw',
    predicate => '_has_unsaturated_fat_content',
    json_ld   => 'unsaturatedFatContent',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::NutritionInformation - Nutritional information about the recipe.

=head1 VERSION

version v9.0.0

=head1 DESCRIPTION

Nutritional information about the recipe.

=head1 ATTRIBUTES

=head2 C<calories>

The number of calories.

A calories should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Energy']>

=back

=head2 C<_has_calories>

A predicate for the L</calories> attribute.

=head2 C<carbohydrate_content>

C<carbohydrateContent>

The number of grams of carbohydrates.

A carbohydrate_content should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Mass']>

=back

=head2 C<_has_carbohydrate_content>

A predicate for the L</carbohydrate_content> attribute.

=head2 C<cholesterol_content>

C<cholesterolContent>

The number of milligrams of cholesterol.

A cholesterol_content should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Mass']>

=back

=head2 C<_has_cholesterol_content>

A predicate for the L</cholesterol_content> attribute.

=head2 C<fat_content>

C<fatContent>

The number of grams of fat.

A fat_content should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Mass']>

=back

=head2 C<_has_fat_content>

A predicate for the L</fat_content> attribute.

=head2 C<fiber_content>

C<fiberContent>

The number of grams of fiber.

A fiber_content should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Mass']>

=back

=head2 C<_has_fiber_content>

A predicate for the L</fiber_content> attribute.

=head2 C<protein_content>

C<proteinContent>

The number of grams of protein.

A protein_content should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Mass']>

=back

=head2 C<_has_protein_content>

A predicate for the L</protein_content> attribute.

=head2 C<saturated_fat_content>

C<saturatedFatContent>

The number of grams of saturated fat.

A saturated_fat_content should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Mass']>

=back

=head2 C<_has_saturated_fat_content>

A predicate for the L</saturated_fat_content> attribute.

=head2 C<serving_size>

C<servingSize>

The serving size, in terms of the number of volume or mass.

A serving_size should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_serving_size>

A predicate for the L</serving_size> attribute.

=head2 C<sodium_content>

C<sodiumContent>

The number of milligrams of sodium.

A sodium_content should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Mass']>

=back

=head2 C<_has_sodium_content>

A predicate for the L</sodium_content> attribute.

=head2 C<sugar_content>

C<sugarContent>

The number of grams of sugar.

A sugar_content should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Mass']>

=back

=head2 C<_has_sugar_content>

A predicate for the L</sugar_content> attribute.

=head2 C<trans_fat_content>

C<transFatContent>

The number of grams of trans fat.

A trans_fat_content should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Mass']>

=back

=head2 C<_has_trans_fat_content>

A predicate for the L</trans_fat_content> attribute.

=head2 C<unsaturated_fat_content>

C<unsaturatedFatContent>

The number of grams of unsaturated fat.

A unsaturated_fat_content should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Mass']>

=back

=head2 C<_has_unsaturated_fat_content>

A predicate for the L</unsaturated_fat_content> attribute.

=head1 SEE ALSO

L<SemanticWeb::Schema::StructuredValue>

=head1 SOURCE

The development version is on github at L<https://github.com/robrwo/SemanticWeb-Schema>
and may be cloned from L<git://github.com/robrwo/SemanticWeb-Schema.git>

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
L<https://github.com/robrwo/SemanticWeb-Schema/issues>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018-2020 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
