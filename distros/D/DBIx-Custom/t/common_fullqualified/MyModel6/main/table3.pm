package MyModel6::main::table3;

use base 'MyModel6';

__PACKAGE__->attr(filter => sub {
  [
    key1 => {in => sub { uc $_[0] }}
  ]
});

1;
