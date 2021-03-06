use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Leading::Zeros',
    license             => 'perl',
    dist_author         => 'Damian Conway <DCONWAY@cpan.org>',
    dist_version_from   => 'lib/Leading/Zeros.pm',
    requires => {
        'Test::More' => 0,
        'version'    => 0,
    },
    add_to_cleanup      => [ 'Leading-Zeros-*' ],
);

$builder->create_build_script();
