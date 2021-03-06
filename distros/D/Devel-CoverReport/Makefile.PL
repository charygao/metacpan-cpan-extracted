# Note: this file was auto-generated by Module::Build::Compat version 0.40
require 5.008000;
use ExtUtils::MakeMaker;
WriteMakefile
(
  'PL_FILES' => {},
  'INSTALLDIRS' => 'site',
  'NAME' => 'Devel::CoverReport',
  'EXE_FILES' => [
                   'bin/cover_report',
                   'bin/prove_cover'
                 ],
  'VERSION_FROM' => 'lib/Devel/CoverReport.pm',
  'PREREQ_PM' => {
                   'Getopt::Long' => '2.36',
                   'Pod::Usage' => '1.35',
                   'FindBin' => '1.47',
                   'Storable' => '2.15',
                   'YAML::Syck' => '1.05',
                   'Params::Validate' => '0.88',
                   'Data::Compare' => '1.22',
                   'Carp::Assert::More' => '1.12',
                   'File::Path' => '1.07',
                   'JSON' => '2.17',
                   'Devel::Cover' => '0.74',
                   'App::Prove' => '3.11',
                   'File::Slurp' => '9999.13',
                   'Cwd' => '3.12'
                 }
)
;
