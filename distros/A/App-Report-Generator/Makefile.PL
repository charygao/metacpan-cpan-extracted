# Note: this file was auto-generated by Module::Build::Compat version 0.3607
use ExtUtils::MakeMaker;
WriteMakefile
(
          'NAME' => 'App::Report::Generator',
          'VERSION_FROM' => 'lib/App/Report/Generator.pm',
          'PREREQ_PM' => {
                           'App::Cmd' => '0.300',
                           'App::Cmd::Tester' => '0.300',
                           'Carp' => 0,
                           'Config::Any' => 0,
                           'DBD::Sys' => '0.102',
                           'File::Basename' => 0,
                           'File::ConfigDir' => '0.003',
                           'File::Find::Rule' => '0.30',
                           'File::Path' => 0,
                           'File::Slurp' => 0,
                           'JSON::Any' => 0,
                           'Report::Generator' => '0.002',
                           'Template' => '2.00',
                           'Template::Plugin::DBI' => '2.65',
                           'Test::More' => '0.90'
                         },
          'INSTALLDIRS' => 'site',
          'EXE_FILES' => [],
          'PL_FILES' => {}
        )
;
