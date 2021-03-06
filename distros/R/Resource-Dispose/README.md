# NAME

Resource::Dispose - Syntax sugar for dispose pattern

# SYNOPSIS

    use Resource::Dispose;
    {
        resource my $obj = Some::Class->new;
    }
    # $obj->DISPOSE is called even if $obj can not be freed and destroyed

# DESCRIPTION

The dispose pattern is a design pattern which is used to handle resource
cleanup in runtime environment that use automatic garbage collection.  In Perl
there is possibility that the object will be destructed during global
destruction and it leads to memory leaking and other drawbacks like unclosed
file handles, etc.

This module provides new keyword `resource` as a syntax sugar for dispose
pattern. The `DISPOSE` method of the resource object is called if the
resource is going out of scope.

# SEE ALSO

This `resource` keyword is inspired by `using` keyword from C\# language and
extended `try` keyword from Java 7 language.

[Guard](http://search.cpan.org/perldoc?Guard), [Scope::Guard](http://search.cpan.org/perldoc?Scope::Guard), [Devel::Declare](http://search.cpan.org/perldoc?Devel::Declare).

# BUGS

If you find the bug or want to implement new features, please report it at
[https://github.com/dex4er/perl-Resource-Dispose/issues](https://github.com/dex4er/perl-Resource-Dispose/issues)

The code repository is available at
[http://github.com/dex4er/perl-Resource-Dispose](http://github.com/dex4er/perl-Resource-Dispose)

# AUTHOR

Piotr Roszatycki <dexter@cpan.org>

# LICENSE

Copyright (c) 2012 Piotr Roszatycki <dexter@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

See [http://dev.perl.org/licenses/artistic.html](http://dev.perl.org/licenses/artistic.html)
