# Note: this file was auto-generated by Module::Build::Compat version 0.03
use ExtUtils::MakeMaker;
WriteMakefile
(
          'NAME' => 'Fuse::PDF',
          'VERSION_FROM' => 'lib/Fuse/PDF.pm',
          'PREREQ_PM' => {
                           'CAM::PDF' => '1.11',
                           'Carp' => '0',
                           'Fcntl' => '0',
                           'Fuse' => '0.08',
                           'MIME::Base64' => '3',
                           'POSIX' => '0',
                           'Readonly' => '1.00',
                           'Test::Class' => '0',
                           'Test::More' => '0.62',
                           'Test::Virtual::Filesystem' => '0.08'
                         },
          'INSTALLDIRS' => 'site',
          'EXE_FILES' => [
                           'bin/mount_pdf'
                         ],
          'PL_FILES' => {}
        )
;
