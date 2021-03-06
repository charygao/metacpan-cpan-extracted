
package Importer::Zim::Unit;
$Importer::Zim::Unit::VERSION = '0.6.0';
# ABSTRACT: Import functions with compilation unit scope

use 5.010001;

use Devel::Hook ();
use Sub::Replace 0.2.0 ();

use Importer::Zim::Utils 0.8.0 qw(DEBUG );

sub import {
    require Importer::Zim::Base;
    Importer::Zim::Base->VERSION('0.12.0');
    goto &Importer::Zim::Base::import_into;
}

sub export_to {
    my $t = shift;
    @_ = %{ $_[0] } if @_ == 1 && ref $_[0] eq 'HASH';
    @_ = map { $_ & 1 ? $_[$_] : "${t}::$_[$_]" } 0 .. $#_;
    goto &_export_to;
}

sub _export_to {
    my $old = Sub::Replace::sub_replace(@_);

    # Clean it up after compilation
    Devel::Hook->unshift_UNITCHECK_hook(
        sub {
            warn qq{  Restoring @{[map qq{"$_"}, sort keys %$old]}\n}
              if DEBUG;
            Sub::Replace::sub_replace($old);
        }
    ) if %$old;
}

no Importer::Zim::Utils qw(DEBUG );

1;

#pod =encoding utf8
#pod
#pod =head1 SYNOPSIS
#pod
#pod     use Importer::Zim::Unit 'Scalar::Util' => 'blessed';
#pod     use Importer::Zim::Unit 'Scalar::Util' =>
#pod       ( 'blessed' => { -as => 'typeof' } );
#pod
#pod     use Importer::Zim::Unit 'Mango::BSON' => ':bson';
#pod
#pod     use Importer::Zim::Unit 'Foo' => { -version => '3.0' } => 'foo';
#pod
#pod     use Importer::Zim::Unit 'SpaceTime::Machine' => [qw(robot rubber_pig)];
#pod
#pod =head1 DESCRIPTION
#pod
#pod     "I'm gonna roll around on the floor for a while. KAY?"
#pod       – GIR
#pod
#pod This is a backend for L<Importer::Zim> which makes imported
#pod symbols available during compilation.
#pod
#pod Unlike L<Importer::Zim::Lexical>, it works for perls before 5.18.
#pod Unlike L<Importer::Zim::Lexical> which plays with lexical subs,
#pod this meddles with the symbol tables for a (hopefully short)
#pod time interval.
#pod
#pod =head1 HOW IT WORKS
#pod
#pod The statement
#pod
#pod     use Importer::Zim::Unit 'Foo' => 'foo';
#pod
#pod works sort of
#pod
#pod     use Sub::Replace;
#pod
#pod     my $_OLD_SUBS;
#pod     BEGIN {
#pod         require Foo;
#pod         $_OLD_SUBS = Sub::Replace::sub_replace('foo' => \&Foo::foo);
#pod     }
#pod
#pod     UNITCHECK {
#pod         Sub::Replace::sub_replace($_OLD_SUBS);
#pod     }
#pod
#pod That means:
#pod
#pod =over 4
#pod
#pod =item *
#pod
#pod Imported subroutines are installed into the caller namespace at compile time.
#pod
#pod =item *
#pod
#pod Imported subroutines are cleaned up just after the unit which defined
#pod them has been compiled.
#pod
#pod =back
#pod
#pod See L<< perlsub /BEGIN, UNITCHECK, CHECK, INIT and END >> for
#pod the concept of "compilation unit" which is relevant here.
#pod
#pod See L<Sub::Replace> for a few gotchas about why this is not simply done
#pod with Perl statements such as
#pod
#pod     *foo = \&Foo::foo;
#pod
#pod =head1 DEBUGGING
#pod
#pod You can set the C<IMPORTER_ZIM_DEBUG> environment variable
#pod for get some diagnostics information printed to C<STDERR>.
#pod
#pod     IMPORTER_ZIM_DEBUG=1
#pod
#pod =head1 SEE ALSO
#pod
#pod L<Importer::Zim>
#pod
#pod L<< perlsub /BEGIN, UNITCHECK, CHECK, INIT and END >>
#pod
#pod L<Importer::Zim::Lexical>
#pod
#pod L<Importer::Zim::EndOfScope>
#pod
#pod =cut

__END__

=pod

=encoding UTF-8

=head1 NAME

Importer::Zim::Unit - Import functions with compilation unit scope

=head1 VERSION

version 0.6.0

=head1 SYNOPSIS

    use Importer::Zim::Unit 'Scalar::Util' => 'blessed';
    use Importer::Zim::Unit 'Scalar::Util' =>
      ( 'blessed' => { -as => 'typeof' } );

    use Importer::Zim::Unit 'Mango::BSON' => ':bson';

    use Importer::Zim::Unit 'Foo' => { -version => '3.0' } => 'foo';

    use Importer::Zim::Unit 'SpaceTime::Machine' => [qw(robot rubber_pig)];

=head1 DESCRIPTION

    "I'm gonna roll around on the floor for a while. KAY?"
      – GIR

This is a backend for L<Importer::Zim> which makes imported
symbols available during compilation.

Unlike L<Importer::Zim::Lexical>, it works for perls before 5.18.
Unlike L<Importer::Zim::Lexical> which plays with lexical subs,
this meddles with the symbol tables for a (hopefully short)
time interval.

=head1 HOW IT WORKS

The statement

    use Importer::Zim::Unit 'Foo' => 'foo';

works sort of

    use Sub::Replace;

    my $_OLD_SUBS;
    BEGIN {
        require Foo;
        $_OLD_SUBS = Sub::Replace::sub_replace('foo' => \&Foo::foo);
    }

    UNITCHECK {
        Sub::Replace::sub_replace($_OLD_SUBS);
    }

That means:

=over 4

=item *

Imported subroutines are installed into the caller namespace at compile time.

=item *

Imported subroutines are cleaned up just after the unit which defined
them has been compiled.

=back

See L<< perlsub /BEGIN, UNITCHECK, CHECK, INIT and END >> for
the concept of "compilation unit" which is relevant here.

See L<Sub::Replace> for a few gotchas about why this is not simply done
with Perl statements such as

    *foo = \&Foo::foo;

=head1 DEBUGGING

You can set the C<IMPORTER_ZIM_DEBUG> environment variable
for get some diagnostics information printed to C<STDERR>.

    IMPORTER_ZIM_DEBUG=1

=head1 SEE ALSO

L<Importer::Zim>

L<< perlsub /BEGIN, UNITCHECK, CHECK, INIT and END >>

L<Importer::Zim::Lexical>

L<Importer::Zim::EndOfScope>

=head1 AUTHOR

Adriano Ferreira <ferreira@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2017-2018 by Adriano Ferreira.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
