package WebService::Backlog::Project;

# $Id: Project.pm 560 2007-11-05 07:15:10Z yamamoto $

use strict; 
use warnings;

use base qw(Class::Accessor::Fast);
__PACKAGE__->mk_accessors(qw/id key name url/);

1;
__END__
