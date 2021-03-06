package App::html2wp;

our $DATE = '2020-05-01'; # DATE
our $VERSION = '0.004'; # VERSION

use 5.010001;
use strict;
use warnings;
use Log::ger;

use POSIX qw(strftime);

our %SPEC;

$SPEC{'html2wp'} = {
    v => 1.1,
    summary => 'Publish HTML document to WordPress as blog post',
    description => <<'_',

To use this program, first create `~/html2wp.conf` containing the API
credentials, e.g.:

    proxy=https://YOURBLOGNAME.wordpress.com/xmlrpc.php
    username=YOURUSERNAME
    password=YOURPASSWORD

You can also put multiple credentials in the configuration file using profile
sections, e.g.:

    [profile=blog1]
    proxy=https://YOURBLOG1NAME.wordpress.com/xmlrpc.php
    username=YOURUSERNAME
    password=YOURPASSWORD

    [profile=blog2]
    proxy=https://YOURBLOG2NAME.wordpress.com/xmlrpc.php
    username=YOURUSERNAME
    password=YOURPASSWORD

and specify which profile you want using command-line option e.g.
`--config-profile blog1`.

then:

    % html2wp post1.html

(You should provide blog post title in your HTML in the `<title>` or `<meta
name="title" content="...">`. You can also put categories in `<meta
name="categories" content="cat1,cat2,...">` and tags in `<meta name="tags"
content="tag1,tag2,...">`.)

The above command will create a draft post. To publish directly:

    % html2wp post1.html ... --publish

Note that this will also modify your HTML file and insert this element at the
beginning of the document:

    <meta name="postid" content="1234">

where 1234 is the post ID retrieved from the server when creating the post.

After the post is created, you can update using the same command:

    % html2wp post1.html

You can use `--publish` to publish the post, or `--no-publish` to revert it to
draft.

To set more attributes:

    % html2wp post1.html ... --comment-status open \ --extra-attr
        ping_status=closed --extra-attr sticky=1

Another example, to schedule a post in the future:

    % html2wp post1.html --schedule 20301225T00:00:00

_
    args => {
        proxy => {
            schema => 'str*', # XXX url
            req => 1,
            description => <<'_',

Example: `https://YOURBLOGNAME.wordpress.com/xmlrpc.php`.

_
            tags => ['credential'],
        },
        username => {
            schema => 'str*',
            req => 1,
            tags => ['credential'],
        },
        password => {
            schema => 'str*',
            req => 1,
            tags => ['credential'],
        },

        filename => {
            summary => 'Path to HTML document to publish',
            schema => 'filename*',
            req => 1,
            pos => 0,
            cmdline_aliases => {f=>{}},
        },

        publish => {
            summary => 'Whether to publish post or make it a draft',
            schema => 'bool*',
            description => <<'_',

Equivalent to `--extra-attr post_status=published`, while `--no-publish` is
equivalent to `--extra-attr post_status=draft`.

_
        },
        schedule => {
            summary => 'Schedule post to be published sometime in the future',
            schema => 'date*',
            description => <<'_',

Equivalent to `--publish --extra-attr post_date=DATE`. Note that WordPress
accepts date in the `YYYYMMDD"T"HH:MM:SS` format, but you specify this option in
regular ISO8601 format. Also note that time is in your chosen local timezone
setting.

_
        },
        comment_status => {
            summary => 'Whether to allow comments (open) or not (closed)',
            schema => ['str*', in=>['open','closed']],
            default => 'closed',
        },
        extra_attrs => {
            'x.name.is_plural' => 1,
            'x.name.singular' => 'extra_attr',
            summary => 'Set extra post attributes, e.g. ping_status, post_format, etc',
            schema => ['hash*', of=>'str*'],
        },
    },
    args_rels => {
        choose_one => [qw/publish schedule/],
    },
    features => {
        dry_run => 1,
    },
    links => [
        {url=>'prog:org2wp'},
        {url=>'prog:pod2wp'},
        {url=>'prog:wp-xmlrpc'},
    ],
};
sub html2wp {
    my %args = @_;

    my $dry_run = $args{-dry_run};

    my $filename = $args{filename};
    (-f $filename) or return [404, "No such file '$filename'"];

    require File::Slurper;
    my $html = File::Slurper::read_text($filename);

    my $title;
    if ($html =~ m!<title>(.+?)</title>!i || $html =~ m!<meta\s+name=\"?title\"?\s+content=\"?(.*?)\"?>!is) {
        $title = $1;
        log_trace("Extracted title from HTML document: %s", $title);
    } else {
        $title = "(No title)";
    }

    my $post_tags;
    if ($html =~ m!<meta\s+name=\"?tags?\"?\s+content=\"?(.*?)\"?>!is) {
        $post_tags = [split /\s+|\s*[,;]\s*/, $1];
        log_trace("Extracted tags from HTML document: %s", $post_tags);
    } else {
        $post_tags = [];
    }

    my $post_cats;
    if ($html =~ m!<meta\s+name=\"?(?:categories|category)\"?\s+content=\"?(.*?)\"?>!is) {
        $post_cats = [split /\s+|\s*[,;]\s*/, $1];
        log_trace("Extracted categories from HTML document: %s", $post_cats);
    } else {
        $post_cats = [];
    }

    my $postid;
    if ($html =~ m!<meta\s+name=\"?postid\"?\s+content=\"?(.*?)\"?>!is) {
        $postid = $1;
        log_trace("HTML document already has post ID: %s", $postid);
    }

    require XMLRPC::Lite;
    my $call;

    # create categories if necessary
    my $cat_ids = {};
    {
        log_info("[api] Listing categories ...");
        $call = XMLRPC::Lite->proxy($args{proxy})->call(
            'wp.getTerms',
            1, # blog id, set to 1
            $args{username},
            $args{password},
            'category',
        );
        return [$call->fault->{faultCode}, "Can't list categories: ".$call->fault->{faultString}]
            if $call->fault && $call->fault->{faultCode};
        my $all_cats = $call->result;
        for my $cat (@$post_cats) {
            if (my ($cat_detail) = grep { $_->{name} eq $cat } @$all_cats) {
                $cat_ids->{$cat} = $cat_detail->{term_id};
                log_trace("Category %s already exists", $cat);
                next;
            }
            if ($dry_run) {
                log_info("(DRY_RUN) [api] Creating category %s ...", $cat);
                next;
            }
            log_info("[api] Creating category %s ...", $cat);
            $call = XMLRPC::Lite->proxy($args{proxy})->call(
                'wp.newTerm',
                1, # blog id, set to 1
                $args{username},
                $args{password},
                {taxonomy=>"category", name=>$cat},
             );
            return [$call->fault->{faultCode}, "Can't create category '$cat': ".$call->fault->{faultString}]
                if $call->fault && $call->fault->{faultCode};
            $cat_ids->{$cat} = $call->result;
        }
    }

    # create tags if necessary
    # create categories if necessary
    my $tag_ids = {};
    {
        log_info("[api] Listing tags ...");
        $call = XMLRPC::Lite->proxy($args{proxy})->call(
            'wp.getTerms',
            1, # blog id, set to 1
            $args{username},
            $args{password},
            'post_tag',
        );
        return [$call->fault->{faultCode}, "Can't list tags: ".$call->fault->{faultString}]
            if $call->fault && $call->fault->{faultCode};
        my $all_tags = $call->result;
        for my $tag (@$post_tags) {
            if (my ($tag_detail) = grep { $_->{name} eq $tag } @$all_tags) {
                $tag_ids->{$tag} = $tag_detail->{term_id};
                log_trace("Tag %s already exists", $tag);
                next;
            }
            if ($dry_run) {
                log_info("(DRY_RUN) [api] Creating tag %s ...", $tag);
                next;
            }
            log_info("[api] Creating tag %s ...", $tag);
            $call = XMLRPC::Lite->proxy($args{proxy})->call(
                'wp.newTerm',
                1, # blog id, set to 1
                $args{username},
                $args{password},
                {taxonomy=>"post_tag", name=>$tag},
             );
            return [$call->fault->{faultCode}, "Can't create tag '$tag': ".$call->fault->{faultString}]
                if $call->fault && $call->fault->{faultCode};
            $tag_ids->{$tag} = $call->result;
        }
    }

    # create or edit the post
    {
        my $meth;
        my @xmlrpc_args = (
            1, # blog id, set to 1
            $args{username},
            $args{password},
        );
        my $content;

        my $publish = $args{publish};
        my $schedule = defined($args{schedule}) ?
            strftime("%Y%m%dT%H:%M:%S", localtime($args{schedule})) : undef;
        $publish = 1 if $schedule;

        if ($postid) {
            $meth = 'wp.editPost';
            $content = {
                (post_status => $publish ? 'publish' : 'draft') x !!(defined $publish),
                (post_date => $schedule) x !!(defined $schedule),
                post_title => $title,
                post_content => $html,
                terms => {
                    category => [map {$cat_ids->{$_}} @$post_cats],
                    post_tag => [map {$tag_ids->{$_}} @$post_tags],
                },
                comment_status => $args{comment_status},
                %{ $args{extra_attrs} // {} },
            };
            push @xmlrpc_args, $postid, $content;
        } else {
            $meth = 'wp.newPost';
            $content = {
                post_status => $publish ? 'publish' : 'draft',
                (post_date => $schedule) x !!(defined $schedule),
                post_title => $title,
                post_content => $html,
                terms => {
                    category => [map {$cat_ids->{$_}} @$post_cats],
                    post_tag => [map {$tag_ids->{$_}} @$post_tags],
                },
                comment_status => $args{comment_status},
                %{ $args{extra_attrs} // {} },
            };
            push @xmlrpc_args, $content;
        }
        if ($dry_run) {
            log_info("(DRY_RUN) [api] Create/edit post, content: %s", $content);
            return [304, "Dry-run"];
        }

        log_info("[api] Creating/editing post ...");
        log_trace("[api] xmlrpc method=%s, args=%s", $meth, \@xmlrpc_args);
        $call = XMLRPC::Lite->proxy($args{proxy})->call($meth, @xmlrpc_args);
        return [$call->fault->{faultCode}, "Can't create/edit post: ".$call->fault->{faultString}]
            if $call->fault && $call->fault->{faultCode};
    }

    # insert POSTID to HTML document
    unless ($postid) {
        $postid = $call->result;
        $html =~ s/^/<meta name="postid" content="$postid">/;
        log_info("[api] Inserting POSTID to %s ...", $filename);
        File::Slurper::write_text($filename, $html);
    }

    [200, "OK"];
}

1;
# ABSTRACT: Publish HTML document to WordPress as blog post

__END__

=pod

=encoding UTF-8

=head1 NAME

App::html2wp - Publish HTML document to WordPress as blog post

=head1 VERSION

This document describes version 0.004 of App::html2wp (from Perl distribution App-html2wp), released on 2020-05-01.

=head1 FUNCTIONS


=head2 html2wp

Usage:

 html2wp(%args) -> [status, msg, payload, meta]

Publish HTML document to WordPress as blog post.

To use this program, first create C<~/html2wp.conf> containing the API
credentials, e.g.:

 proxy=https://YOURBLOGNAME.wordpress.com/xmlrpc.php
 username=YOURUSERNAME
 password=YOURPASSWORD

You can also put multiple credentials in the configuration file using profile
sections, e.g.:

 [profile=blog1]
 proxy=https://YOURBLOG1NAME.wordpress.com/xmlrpc.php
 username=YOURUSERNAME
 password=YOURPASSWORD
 
 [profile=blog2]
 proxy=https://YOURBLOG2NAME.wordpress.com/xmlrpc.php
 username=YOURUSERNAME
 password=YOURPASSWORD

and specify which profile you want using command-line option e.g.
C<--config-profile blog1>.

then:

 % html2wp post1.html

(You should provide blog post title in your HTML in the C<< E<lt>titleE<gt> >> or C<< E<lt>meta
name="title" content="..."E<gt> >>. You can also put categories in C<< E<lt>meta
name="categories" content="cat1,cat2,..."E<gt> >> and tags in C<< E<lt>meta name="tags"
content="tag1,tag2,..."E<gt> >>.)

The above command will create a draft post. To publish directly:

 % html2wp post1.html ... --publish

Note that this will also modify your HTML file and insert this element at the
beginning of the document:

 <meta name="postid" content="1234">

where 1234 is the post ID retrieved from the server when creating the post.

After the post is created, you can update using the same command:

 % html2wp post1.html

You can use C<--publish> to publish the post, or C<--no-publish> to revert it to
draft.

To set more attributes:

 % html2wp post1.html ... --comment-status open \ --extra-attr
     ping_status=closed --extra-attr sticky=1

Another example, to schedule a post in the future:

 % html2wp post1.html --schedule 20301225T00:00:00

This function is not exported.

This function supports dry-run operation.


Arguments ('*' denotes required arguments):

=over 4

=item * B<comment_status> => I<str> (default: "closed")

Whether to allow comments (open) or not (closed).

=item * B<extra_attrs> => I<hash>

Set extra post attributes, e.g. ping_status, post_format, etc.

=item * B<filename>* => I<filename>

Path to HTML document to publish.

=item * B<password>* => I<str>

=item * B<proxy>* => I<str>

Example: CL<https://YOURBLOGNAME.wordpress.com/xmlrpc.php>.

=item * B<publish> => I<bool>

Whether to publish post or make it a draft.

Equivalent to C<--extra-attr post_status=published>, while C<--no-publish> is
equivalent to C<--extra-attr post_status=draft>.

=item * B<schedule> => I<date>

Schedule post to be published sometime in the future.

Equivalent to C<--publish --extra-attr post_date=DATE>. Note that WordPress
accepts date in the C<YYYYMMDD"T"HH:MM:SS> format, but you specify this option in
regular ISO8601 format. Also note that time is in your chosen local timezone
setting.

=item * B<username>* => I<str>


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

Please visit the project's homepage at L<https://metacpan.org/release/App-html2wp>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-App-html2wp>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-html2wp>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 SEE ALSO


L<org2wp>.

L<pod2wp>.

L<wp-xmlrpc>.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2020, 2017 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
