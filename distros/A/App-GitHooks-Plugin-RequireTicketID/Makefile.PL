# Note: this file was auto-generated by Module::Build::Compat version 0.4205
require 5.010;
use ExtUtils::MakeMaker;
WriteMakefile
(
  'test' => {
              'TESTS' => 't/*.t'
            },
  'INSTALLDIRS' => 'site',
  'NAME' => 'App::GitHooks::Plugin::RequireTicketID',
  'VERSION_FROM' => 'lib/App/GitHooks/Plugin/RequireTicketID.pm',
  'PL_FILES' => {},
  'PREREQ_PM' => {
                   'Test::Requires::Git' => '1.005',
                   'Test::More' => '0.94',
                   'App::GitHooks' => 0,
                   'Capture::Tiny' => 0,
                   'Test::Exception' => 0,
                   'Test::FailWarnings' => 0,
                   'Git::Repository' => 0
                 },
  'EXE_FILES' => []
)
;
