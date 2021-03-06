use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Catalyst::Authentication::Credential::Testing',
    VERSION_FROM => 'lib/Catalyst/Authentication/Credential/Testing.pm',
    PREREQ_PM    => {
        'Catalyst::Authentication::Credential::Password' => 0,
        'Carp'                                           => 0,
        'Catalyst::Exception'                            => 0,
        'Test::More'                                     => 0,
    },
);

