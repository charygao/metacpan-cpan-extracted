use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Math::Random::MT',
    OBJECT        => 'MT.o _mt.o',
    VERSION_FROM  => 'MT.pm',
    ABSTRACT_FROM => 'MT.pm',
    AUTHOR        => 'Abhijit Menon-Sen',
    PREREQ_PM     => {
        'Test::More'          => 0,
        'Test::Number::Delta' => 0,
                     },
    LICENSE       => 'bsd',
);
