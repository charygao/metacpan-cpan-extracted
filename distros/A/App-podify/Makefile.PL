# Generated by git-ship. See 'git-ship --man' for help or https://github.com/jhthorsen/app-git-ship
use ExtUtils::MakeMaker;
WriteMakefile(
  NAME => 'App::podify',
  AUTHOR => 'Jan Henning Thorsen <jhthorsen@cpan.org>',
  LICENSE => 'artistic_2',
  ABSTRACT_FROM => 'lib/App/podify.pm',
  VERSION_FROM => 'lib/App/podify.pm',
  EXE_FILES => [qw( script/podify.pl )],
  META_MERGE => {
    resources => {
      bugtracker => 'https://github.com/jhthorsen/app-podify/issues',
      homepage => 'https://github.com/jhthorsen/app-podify',
      repository => 'https://github.com/jhthorsen/app-podify.git',
    },
  },
  BUILD_REQUIRES => {
  'Test::More' => '0.88'
}
,
  PREREQ_PM => {
  'Applify' => '0.12',
  'perl' => 'v5.10.0'
}
,
  test => {TESTS => (-e 'META.yml' ? 't/*.t' : 't/*.t xt/*.t')},
);
