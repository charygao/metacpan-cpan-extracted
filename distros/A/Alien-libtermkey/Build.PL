use strict;
use warnings;

use lib 'inc';
use Alien::make::Module::Build;

my $build = Alien::make::Module::Build->new(
   module_name => 'Alien::libtermkey',
   tarball => 'libtermkey-0.22.tar.gz',
   pkgconfig_module => "termkey",
   pkgconfig_version => "0.22",
   use_bundled => ( scalar grep { $_ eq "--use-bundled" } @ARGV ),

   alien_requires => [
      [ any =>
         [ pkgconfig => "unibilium", atleast_version => "0.1.0" ],
         # libtermkey can also use ncursesw and curses.h, but if none of those
         # are available anyway we'll want to pull in Alien::unibilium. Best
         # just to do it now and ignore those anyway
         [ alien => "Alien::unibilium" => '0.15' ],
      ],
   ],
   build_requires => {
      'File::Basename' => 0,
      'File::Path' => '2.07',
      'File::Spec' => 0,
   },
   configure_requires => {
      'perl' => '5.010', # //
   },
   license => 'perl',
   create_license => 1,
   create_readme  => 1,
);

$build->create_build_script;
