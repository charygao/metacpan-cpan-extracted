# NAME

kritika - integrate with kritika.io

# SYNOPSIS

    # Full file analysis
    kritika lib/MyFile.pm

    # Report only *new* violations
    kritika --diff master lib/OtherFile.pm
    kritika --diff #31 lib/OtherFile.pm
    kritika --diff 451e77f3 lib/OtherFile.pm

# DESCRIPTION

This command allows you to quickly analyze file using [https://kritika.io](https://kritika.io) service. Normally `kritika.io` analyzes
your repository after the push, but of course sometimes you would like to know if something's wrong before doing
a commit.

## Git Hook Example

This is based on the shipped with `git` pre-push hook example.

    #!/bin/sh

    remote="$1"
    url="$2"

    z40=0000000000000000000000000000000000000000

    while read local_ref local_sha remote_ref remote_sha
    do
        if [ "$local_sha" = $z40 ]
        then
            :
        else
            if [ "$remote_sha" = $z40 ]
            then
                range="$local_sha"
            else
                range="$remote_sha..$local_sha"
            fi

            branch="$(git rev-parse --abbrev-ref HEAD)"

            git diff --name-only $range | kritika --diff-branch master \
                --branch "$branch" --revision "$local_sha" || exit 1
        fi
    done

    exit 0

This command easily integrates with text editors.

# CONFIGURATION

A special file `.kritikarc` (or `_kritikarc` on Windows) has to be placed in the root directory of the project with
the following configuration:

    # This is the default, if you're using public Kritika service this option is not needed
    base_url=https://kritika.io

    # This is your repository token that you can obtain from the repository integrations page on kritika.io
    token=deba194179c1bdd7fca70724d57d85a7ed8d6dbe

If you want to force project root, use `root` option:

    root=/path/to/my/project

# TEXT EDITORS

`kritika` produces text output by default. This can be parsed by editors that support error reporting.

## Vim

You can either manually call kritika from `vim`:

    :!kritika %

Or use a `compiler` plugin [https://github.com/kritikaio/vim-kritika](https://github.com/kritikaio/vim-kritika).

    :compiler kritika
    :Kritika

## SublimeText3

See [https://github.com/kritikaio/SublimeLinter-kritika](https://github.com/kritikaio/SublimeLinter-kritika) plugin.

# DEVELOPMENT

## Repository

    http://github.com/kritikaio/app-kritika

# CREDITS

# AUTHOR

Viacheslav Tykhanovskyi, `vti@cpan.org`.

# COPYRIGHT AND LICENSE

Copyright (C) 2017, Viacheslav Tykhanovskyi

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.
