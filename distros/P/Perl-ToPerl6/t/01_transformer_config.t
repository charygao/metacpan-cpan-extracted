#!perl

use 5.006001;
use strict;
use warnings;

use Carp qw< confess >;

use Perl::ToPerl6::TransformerConfig;

use Test::More tests => 24;

#-----------------------------------------------------------------------------

{
    my $config =
        Perl::ToPerl6::TransformerConfig->new('Some::Transformer');

    is(
        $config->get_transformer_short_name(),
        'Some::Transformer',
        'Transformer short name gets saved.',
    );
    is(
        $config->get_set_themes(),
        undef,
        'set_themes is undef when not specified.',
    );
    is(
        $config->get_add_themes(),
        undef,
        'add_themes is undef when not specified.',
    );
    is(
        $config->get_necessity(),
        undef,
        'necessity is undef when not specified.',
    );
    ok(
        $config->is_empty(),
        'is_empty() is true when there were no configuration values.',
    );

    my @parameter_names = $config->get_parameter_names();
    is(
        scalar @parameter_names,
        0,
        'There are no parameter names left.',
    );

    test_standard_parameters_undef_via_get($config);
}

{
    my $config =
        Perl::ToPerl6::TransformerConfig->new(
            'Some::Other::Transformer',
            {
                custom_parameter   => 'blargh',

                # Standard parameters
                set_themes                      => 'thingy',
                add_themes                      => 'another thingy',
                necessity                        => 'harsh'
            }
        );

    is(
        $config->get_transformer_short_name(),
        'Some::Other::Transformer',
        'Transformer short name gets saved.',
    );
    is(
        $config->get_set_themes(),
        'thingy',
        'set_themes gets saved.',
    );
    is(
        $config->get_add_themes(),
        'another thingy',
        'add_themes gets saved.',
    );
    is(
        $config->get_necessity(),
        'harsh',
        'necessity gets saved.',
    );
    is(
        $config->get('custom_parameter'),
        'blargh',
        'custom_parameter gets saved.',
    );
    ok(
        ! $config->is_empty(),
        'is_empty() is false when there were configuration values.',
    );

    my @parameter_names = $config->get_parameter_names();
    is(
        scalar @parameter_names,
        1,
        'There is one parameter name left after construction.',
    );
    is(
        $parameter_names[0],
        'custom_parameter',
        'There parameter name is the expected value.',
    );

    test_standard_parameters_undef_via_get($config);

    $config->remove('custom_parameter');
    ok(
        $config->is_empty(),
        'is_empty() is true after removing "custom_parameter".',
    );

    @parameter_names = $config->get_parameter_names();
    is(
        scalar @parameter_names,
        0,
        'There are no parameter names left after removing "custom_parameter".',
    );
}


sub test_standard_parameters_undef_via_get {
    my ($config) = @_;
    my $transformer_short_name = $config->get_transformer_short_name();

    foreach my $parameter (
        qw<
            set_themes
            add_themes
            necessity
            _non_public_data
        >
    ) {
        is(
            $config->get($parameter),
            undef,
            qq<"$parameter" is not defined via get() for $transformer_short_name.>,
        )
    }

    return;
}

#-----------------------------------------------------------------------------

# ensure we return true if this test is loaded by
# t/01_transformer_config.t_without_optional_dependencies.t
1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :
