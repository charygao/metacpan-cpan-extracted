package Paws::Quicksight::TemplateSourceEntity;
  use Moose;
  has SourceAnalysis => (is => 'ro', isa => 'Paws::Quicksight::TemplateSourceAnalysis');
  has SourceTemplate => (is => 'ro', isa => 'Paws::Quicksight::TemplateSourceTemplate');
1;

### main pod documentation begin ###

=head1 NAME

Paws::Quicksight::TemplateSourceEntity

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::Quicksight::TemplateSourceEntity object:

  $service_obj->Method(Att1 => { SourceAnalysis => $value, ..., SourceTemplate => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::Quicksight::TemplateSourceEntity object:

  $result = $service_obj->Method(...);
  $result->Att1->SourceAnalysis

=head1 DESCRIPTION

The source entity of the template.

=head1 ATTRIBUTES


=head2 SourceAnalysis => L<Paws::Quicksight::TemplateSourceAnalysis>

  The source analysis, if it is based on an analysis.


=head2 SourceTemplate => L<Paws::Quicksight::TemplateSourceTemplate>

  The source template, if it is based on an template.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::Quicksight>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

