# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.005.
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Use Hash::Util::FieldHash or ties, depending on availability",
  "AUTHOR" => "\x{5d9}\x{5d5}\x{5d1}\x{5dc} \x{5e7}\x{5d5}\x{5d2}'\x{5de}\x{5df} (Yuval Kogman) <nothingmuch\@woobling.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Hash-Util-FieldHash-Compat",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.006",
  "NAME" => "Hash::Util::FieldHash::Compat",
  "PREREQ_PM" => {
    "Exporter" => 0,
    "constant" => 0,
    "parent" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "Test::More" => "0.88"
  },
  "VERSION" => "0.11",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Exporter" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "Test::More" => "0.88",
  "constant" => 0,
  "parent" => 0,
  "strict" => 0,
  "warnings" => 0
);

# inserted by Dist::Zilla::Plugin::DynamicPrereqs 0.029
if (not eval 'require Hash::Util::FieldHash') {
  requires('Tie::RefHash::Weak', '0.08');
  requires('Tie::RefHash', '1.38');
  requires('Scalar::Util');
}


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

# inserted by Dist::Zilla::Plugin::DynamicPrereqs 0.029
sub _add_prereq {
  my ($mm_key, $module, $version_or_range) = @_;
  warn "$module already exists in $mm_key -- need to do a sane metamerge!"
    if exists $WriteMakefileArgs{$mm_key}{$module}
      and $WriteMakefileArgs{$mm_key}{$module} ne ($version_or_range || 0);
  warn "$module already exists in FallbackPrereqs -- need to do a sane metamerge!"
    if exists $FallbackPrereqs{$module} and $FallbackPrereqs{$module} ne ($version_or_range || 0);
  $WriteMakefileArgs{$mm_key}{$module} = $FallbackPrereqs{$module} = $version_or_range || 0;
  return;
}

sub requires { goto &runtime_requires }

sub runtime_requires {
  my ($module, $version_or_range) = @_;
  _add_prereq(PREREQ_PM => $module, $version_or_range);
}
