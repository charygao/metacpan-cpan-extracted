# Note: this file was auto-generated by Module::Build::Compat version 0.3607
require 5.006;
use ExtUtils::MakeMaker;
WriteMakefile
(
          'test' => {
                      'TESTS' => 't/*.t'
                    },
          'PL_FILES' => {},
          'INSTALLDIRS' => 'site',
          'NAME' => 'Test::Builder::Mock::Class',
          'EXE_FILES' => [],
          'VERSION_FROM' => 'lib/Test/Builder/Mock/Class.pm',
          'PREREQ_PM' => {
                           'namespace::clean' => 0,
                           'Test::Builder' => 0,
                           'Test::Mock::Class' => '0.0303',
                           'Moose' => '0.89'
                         }
        )
;
