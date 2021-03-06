
=head1 NAME

EBI::FGPT::FuzzyRecogniser::OntologyTerm 


=head1 SYNOPSIS

EBI::FGPT::FuzzyRecogniser::OntologyTerm has three fields: 
accession,label and annotations. Annotations is an array containing 
synonyms (type of EBI::FGPT::!FuzzyRecogniser::OntologyTerm::Synonym) 

    use EBI::FGPT::FuzzyRecogniser::OntologyTerm;

    my $term = EBI::FGPT::FuzzyRecogniser::OntologyTerm->new();
    

=head1 AUTHOR

Emma Hastings , <ehastings@cpan.org>

=head1 ACKNOWLEDGEMENTS

Tomasz Adamusiak <tomasz@cpan.org>
 
=head1 COPYRIGHT AND LICENSE

Copyright [2011] EMBL - European Bioinformatics Institute

Licensed under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
either express or implied. See the License for the specific
language governing permissions and limitations under the
License.

=cut

package EBI::FGPT::FuzzyRecogniser::OntologyTerm;

use Moose;


our $VERSION = 0.09;

has 'accession' => ( is => 'rw', isa => 'Str', required => 1 );
has 'label'     => ( is => 'rw', isa => 'Str', required => 1 );
has 'annotations' =>
  ( is => 'rw', isa => 'ArrayRef', required => 1 );
  


1;    # End of FuzzyRecogniser::OntologyTerm
