package App::FfmpegUtils;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2020-06-04'; # DATE
our $DIST = 'App-FfmpegUtils'; # DIST
our $VERSION = '0.003'; # VERSION

use 5.010001;
use strict;
use warnings;
use Log::ger;

use Perinci::Exporter;

our %SPEC;

$SPEC{':package'} = {
    v => 1.1,
    summary => 'Utilities related to ffmpeg',
};

our %arg0_files = (
    files => {
        'x.name.is_plural' => 1,
        'x.name.singular' => 'file',
        schema => ['array*' => of => 'filename*'],
        req => 1,
        pos => 0,
        slurpy => 1,
    },
);

our %argopt_ffmpeg_path = (
    ffmpeg_path => {
        schema => 'filename*',
    },
);

sub _nearest {
    sprintf("%d", $_[0]/$_[1]) * $_[1];
}

$SPEC{reencode_video} = {
    v => 1.1,
    summary => 'Re-encode video (using ffmpeg and H.264 codec)',
    description => <<'_',

This utility runs ffmpeg to re-encode your video files. It is a wrapper to
simplify invocation of ffmpeg. It selects the appropriate ffmpeg options for
you, allows you to specify multiple files, and picks appropriate output
filenames. It also sports a `--dry-run` option to let you see ffmpeg options to
be used without actually running ffmpeg.

This utility is usually used to reduce the file size (and optionally video
width/height) of videos so they are smaller, while minimizing quality loss. The
default setting is roughly similar to how Google Photos encodes videos (max
1080p).

The default settings are:

    -v:c libx264
    -preset veryslow (to get the best compression rate, but with the slowest encoding time)
    -crf 28 (0-51, subjectively sane is 18-28, 18 ~ visually lossless, 28 ~ visually acceptable)

when a downsizing is requested (using the `--downsize-to` option), this utility
first checks each input video if it is indeed larger than the requested final
size. If it is, then the `-vf scale` option is added. This utility also
calculates a valid size for ffmpeg, since using `-vf scale=-1:720` sometimes
results in failure due to odd number.

Audio streams are copied, not re-encoded.

Output filenames are:

    ORIGINAL_NAME.crf28.mp4

or (if downsizing is done):

    ORIGINAL_NAME.480p-crf28.mp4

_
    args => {
        %arg0_files,
        %argopt_ffmpeg_path,
        crf => {
            schema => ['int*', between=>[0,51]],
        },
        downsize_to => {
            schema => ['str*', in=>['', '480p', '720p', '1080p']],
            default => '1080p',
            description => <<'_',

Downsizing will only be done if the input video is indeed larger then the target
downsize.

To disable downsizing, set `--downsize-to` to '' (empty string), or specify on
`--dont-downsize` on the CLI.

_
            cmdline_aliases => {
                dont_downsize => {summary=>"Alias for --downsize-to ''", is_flag=>1, code=>sub {$_[0]{downsize_to} = ''}},
                no_downsize   => {summary=>"Alias for --downsize-to ''", is_flag=>1, code=>sub {$_[0]{downsize_to} = ''}},
            },
        },
    },
    features => {
        dry_run => 1,
    },
    examples => [
        {
            summary => 'The default setting is to downsize to 1080p',
            src => 'reencode-video *',
            src_plang => 'bash',
            test => 0,
            'x.doc.show_result' => 0,
        },
        {
            summary => 'Do not downsize',
            src => 'reencode-video --dont-downsize *',
            src_plang => 'bash',
            test => 0,
            'x.doc.show_result' => 0,
        },
        {
            summary => 'Downsize to 480p but make it "visually lossless"',
            src => 'reencode-video --downsize-to 480p --crf 18 *',
            src_plang => 'bash',
            test => 0,
            'x.doc.show_result' => 0,
        },
    ],
};
sub reencode_video {
    require File::Which;
    require IPC::System::Options;
    require Media::Info;

    my %args = @_;

    my $ffmpeg_path = $args{ffmpeg_path} // File::Which::which("ffmpeg");
    my $downsize_to = $args{downsize_to};

    unless ($args{-dry_run}) {
        return [400, "Cannot find ffmpeg in path"] unless defined $ffmpeg_path;
        return [400, "ffmpeg path $ffmpeg_path is not executable"] unless -f $ffmpeg_path;
    }

    for my $file (@{$args{files}}) {
        log_info "Processing file %s ...", $file;

        unless (-f $file) {
            log_error "No such file %s, skipped", $file;
            next;
        }

        my $res = Media::Info::get_media_info(media => $file);
        unless ($res->[0] == 200) {
            log_error "Can't get media information fod %s: %s - %s, skipped",
                $file, $res->[0], $res->[1];
            next;
        }
        my $video_info = $res->[2];

        my $crf = $args{crf} // 28;
        my @ffmpeg_args = (
            "-i", $file,
        );

        my $downsized;
      DOWNSIZE: {
            last unless $downsize_to;
            my $ratio;
            if ($downsize_to eq '480p') {
                last unless $video_info->{video_shortest_side} > 480;
                $ratio = $video_info->{video_shortest_side} / 480;
            } elsif ($downsize_to eq '720p') {
                last unless $video_info->{video_shortest_side} > 720;
                $ratio = $video_info->{video_shortest_side} / 720;
            } elsif ($downsize_to eq '1080p') {
                last unless $video_info->{video_shortest_side} > 1080;
                $ratio = $video_info->{video_shortest_side} / 1080;
            } else {
                die "Invalid downsize_to value '$downsize_to'";
            }

            $downsized++;
            push @ffmpeg_args, "-vf", sprintf(
                "scale=%d:%d",
                _nearest($video_info->{video_width} / $ratio, 2),  # make sure divisible by 2 (optimum is divisible by 16, then 8, then 4)
                _nearest($video_info->{video_height} / $ratio, 2),
            );
        } # DOWNSIZE

        my $output_file = $file;
        my $ext = $downsized ? ".$downsize_to-crf$crf.mp4" : ".crf$crf.mp4";
        $output_file =~ s/(\.\w{3,4})?\z/($1 eq ".mp4" ? "" : $1) . $ext/e;

        push @ffmpeg_args, (
            "-c:v", "libx264",
            "-crf", $crf,
            "-preset", "veryslow",
            "-c:a", "copy",
            $output_file,
        );

        if ($args{-dry_run}) {
            log_info "[DRY-RUN] Running $ffmpeg_path with args %s ...", \@ffmpeg_args;
            next;
        }

        IPC::System::Options::system(
            {log=>1},
            $ffmpeg_path, @ffmpeg_args,
        );
        if ($?) {
            my ($exit_code, $signal, $core_dump) = ($? < 0 ? $? : $? >> 8, $? & 127, $? & 128);
            log_error "ffmpeg for $file failed: exit_code=$exit_code, signal=$signal, core_dump=$core_dump";
        }
    }

    [200];
}

1;
# ABSTRACT: Utilities related to ffmpeg

__END__

=pod

=encoding UTF-8

=head1 NAME

App::FfmpegUtils - Utilities related to ffmpeg

=head1 VERSION

This document describes version 0.003 of App::FfmpegUtils (from Perl distribution App-FfmpegUtils), released on 2020-06-04.

=head1 FUNCTIONS


=head2 reencode_video

Usage:

 reencode_video(%args) -> [status, msg, payload, meta]

Re-encode video (using ffmpeg and H.264 codec).

This utility runs ffmpeg to re-encode your video files. It is a wrapper to
simplify invocation of ffmpeg. It selects the appropriate ffmpeg options for
you, allows you to specify multiple files, and picks appropriate output
filenames. It also sports a C<--dry-run> option to let you see ffmpeg options to
be used without actually running ffmpeg.

This utility is usually used to reduce the file size (and optionally video
width/height) of videos so they are smaller, while minimizing quality loss. The
default setting is roughly similar to how Google Photos encodes videos (max
1080p).

The default settings are:

 -v:c libx264
 -preset veryslow (to get the best compression rate, but with the slowest encoding time)
 -crf 28 (0-51, subjectively sane is 18-28, 18 ~ visually lossless, 28 ~ visually acceptable)

when a downsizing is requested (using the C<--downsize-to> option), this utility
first checks each input video if it is indeed larger than the requested final
size. If it is, then the C<-vf scale> option is added. This utility also
calculates a valid size for ffmpeg, since using C<-vf scale=-1:720> sometimes
results in failure due to odd number.

Audio streams are copied, not re-encoded.

Output filenames are:

 ORIGINAL_NAME.crf28.mp4

or (if downsizing is done):

 ORIGINAL_NAME.480p-crf28.mp4

This function is not exported.

This function supports dry-run operation.


Arguments ('*' denotes required arguments):

=over 4

=item * B<crf> => I<int>

=item * B<downsize_to> => I<str> (default: "1080p")

Downsizing will only be done if the input video is indeed larger then the target
downsize.

To disable downsizing, set C<--downsize-to> to '' (empty string), or specify on
C<--dont-downsize> on the CLI.

=item * B<ffmpeg_path> => I<filename>

=item * B<files>* => I<array[filename]>


=back

Special arguments:

=over 4

=item * B<-dry_run> => I<bool>

Pass -dry_run=E<gt>1 to enable simulation mode.

=back

Returns an enveloped result (an array).

First element (status) is an integer containing HTTP status code
(200 means OK, 4xx caller error, 5xx function error). Second element
(msg) is a string containing error message, or 'OK' if status is
200. Third element (payload) is optional, the actual result. Fourth
element (meta) is called result metadata and is optional, a hash
that contains extra information.

Return value:  (any)

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/App-FfmpegUtils>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-App-FfmpegUtils>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-FfmpegUtils>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2020 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
