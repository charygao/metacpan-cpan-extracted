package Test::Class::Simple;
use strict;
use warnings;

use parent qw(Test::Class);

use Carp;
use Test::MockObject::Extends;
use Test::MockModule;
use Test::Deep qw(cmp_deeply);

our $VERSION = '0.06';

sub setup : Test(setup) {
    my $self = shift;

    $self->pre_setup();
    my $module = $self->get_module_name();
    if ( defined $module && $self->create_instance() ) {
        my $instance = Test::MockObject::Extends->new($module);
        $self->{instance} = $instance;
    }
    $self->post_setup();
    return;
}

sub run_test_cases {
    my ( $self, $cases ) = @_;

    foreach my $case ( @{$cases} ) {
        my $hook = $case->{pre_test_hook};
        if ( defined $hook && ref $hook eq 'CODE' ) {
            &$hook();
        }
        my $method = $case->{method};
        my $res;
        my $instance = $self->get_instance();
        my $module   = $self->get_module_name();
        if (   defined $instance
            && $instance->can($method)
            && !$self->run_on_module() )
        {
            $res = $instance->$method( @{ $case->{params} } );
        }
        elsif ( defined $module ) {
            my $call = $module->can($method);
            if ( defined $call ) {
                $res = &$call( @{ $case->{params} } );
            }
        }

        my $exp = $case->{exp};
        if ( defined $exp && ref $exp eq 'CODE' ) {
            $res = &$exp($res);
            $exp = 1;
        }
        cmp_deeply( $res, $exp, $case->{name} );

        $hook = $case->{post_test_hook};
        if ( defined $hook && ref $hook eq 'CODE' ) {
            &$hook();
        }
    }
    return;
}

sub get_instance {
    my $self = shift;

    return $self->{instance};
}

sub get_module_name {
    croak('Module name should be set');
}

sub create_instance {
    return 0;
}

sub pre_setup {
    return;
}

sub post_setup {
    return;
}

sub run_on_module {
    my ( $self, $set_value ) = @_;

    if ( defined $set_value ) {
        $self->{_run_on_module} = $set_value;
    }

    return $self->{_run_on_module} // 0;
}

1;

=head1 NAME

Test::Class::Simple - Simplify your unit tests writing based on Test::Class

=head1 VERSION

version 0.06

=head1 SYNOPSIS

  package My::Example;

  sub new {
    my $class = shift;

    $class = ref($class) || $class;
    my $self = { _counter => 0 };
    bless $self, $class;
    return $self;
  }

  sub increase_counter {
    my $self = shift;

    $self->{_counter}++;
    return $self->{_counter};
  }


  package My::Example::Test;
  use parent qw(Test::Class::Simple);

  # setup methods are run before every test method.
  sub _setup {
    my $self = shift;

    # get mocked object of the class that is Test::MockObject::Extends
    my $instance = $self->get_instance();
    $instance->{_counter} = 100;
    return;
  }

  # Set which class should be mocked
  sub get_module_name {
    return 'My::Example';
  }

  # Indicate that instance should be created
  sub create_instance {
    return 1;
  }

  # a test method that runs 2 test cases
  sub test_counter : Test(2) {
    my $self = shift;

    my $test_cases = [
      {
        method => 'increase_counter',
        params => [],
        exp    => 101,
        name   => 'Increase counter once',
      },
      {
        method => 'increase_counter',
        params => [],
        exp    => 102,
        name   => 'Increase counter twice',
      },
    ];
    $self->run_test_cases($test_cases);
    return;
  }

later in a nearby .t file

  #!/usr/bin/perl
  use My::Example::Test;

  # run all the test methods in My::Example::Test
  My::Example::Test->new()->runtests();
  exit 0;

=head1 DESCRIPTION

This is an extension of L<Test::Class|https://metacpan.org/pod/Test::Class> module to implement unit tests in more simple and declarative way.

=head2 Methods

=head3 pre_setup()

Can be overridden. Method that is executed before every test method and is useful for some initializations required for the tests.
Is executed before creating mocked object;

=head3 post_setup()

Can be overridden. Method that is executed before every test method and is useful for some initializations required for the tests.
Is executed after creating mocked object;

=head3 get_instance()

Returns mocked object of the class specified in L<get_module_name()|/get_module_name()>. If L<create_instance()|/create_instance()>
is set to false, returns C<undef> value.

=head3 create_instance()

Can be overridden and must return boolean value. Indicates whether mocked instance should be created.

=head3 get_module_name()

Must be overridden and should return name of the module for which tests should be run.

=head3 run_on_module($set_value)

Sets boolean value that indicates that tests should run against the module rather then the instance of the class.

=head3 run_test_cases($cases)

Accepts arrayref of the test cases described with L<options|/Options> inside hash references and executes them one by one.

=head2 Options

=head3 method

Name of the method that should be executed.

=head3 params

Array reference of the parameters that should be passed to the L<method|/method>

=head3 exp

Can be either data structure or a code reference. For data structure L<cmp_deeply|https://metacpan.org/pod/Test::Deep#cmp_deeply>
will be executed. If code reference is set then result will be passed as a single parameter and will be expected to return
true value if test case was considered as successful.

=head3 name

Name of the test case. Usually shown in the output of test run.

=head3 pre_test_hook

Code reference that will be executed before current test case. E.g. for mocking data for next test case.

=head3 post_test_hook

Code reference that will be executed after current test case. E.g. for unmocking data.

=head1 AUTHOR

Oleksii Kysil

=head1 COPYRIGHT & LICENSE

Copyright 2020 Oleksii Kysil, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
