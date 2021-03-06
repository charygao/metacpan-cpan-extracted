use strict;
use warnings;

my @types = qw(byte short int long float double);
sub prefix {
  my ($type) = @_;
  my $prefix = substr($type, 0, 1);
  return $prefix;
}

for my $type (@types) {
  my $prefix = prefix($type);
  
  my $package_name = "SPVM::Quat_4$prefix";
  
  my $spvm_module_content = <<"EOS";
# $package_name is created by regen/regen_quat.pl
package $package_name : mulnum_t {
  has t : $type;
  has x : $type;
  has y : $type;
  has z : $type;
EOS

  $spvm_module_content .= "}\n";
  
  my $spvm_module_file = "lib/SPVM/Quat_4$prefix.spvm";
  open my $spvm_module_fh, '>', $spvm_module_file
    or die "Can't open $spvm_module_file: $!";
  print $spvm_module_fh $spvm_module_content;

  my $perl_module_content = <<EOS;
=head1 NAME

$package_name - Quaternion $type multi numeric type

=head1 SYNOPSYS

  my \$z : $package_name;
  \$z->{t} = 1;
  \$z->{x} = 2;
  \$z->{y} = 3;
  \$z->{z} = 4;
  
=head1 DESCRIPTION

$package_name is Quaternion $type multi numeric type.
EOS

  my $perl_module_file = "lib/SPVM/Quat_4$prefix.pm";
  open my $perl_module_fh, '>', $perl_module_file
    or die "Can't open $perl_module_file: $!";
  print $perl_module_fh $perl_module_content;
}
