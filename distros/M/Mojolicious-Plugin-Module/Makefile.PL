# Note: this file was auto-generated by Module::Build::Compat version 0.4003
require 5.014;
use ExtUtils::MakeMaker;
WriteMakefile
(
  'PL_FILES' => {},
  'INSTALLDIRS' => 'site',
  'EXE_FILES' => [],
  'NAME' => 'Mojolicious::Plugin::Module',
  'PREREQ_PM' => {
                   'Module::Load' => 0,
                   'YAML' => 0,
                   'Mojolicious' => 4,
                   'Hash::Merge::Simple' => '0.051',
                   'Test::More' => 0,
                   'File::Copy::Recursive' => 0,
                   'Carp' => 0
                 },
  'VERSION_FROM' => 'lib/Mojolicious/Plugin/Module.pm'
)
;
