#! /usr/bin/perl

use Test::More tests => 3;
use Test::Deep;

use Bio::BioStudio;
use Data::Dumper;

use strict;
use warnings;

my $BS = Bio::BioStudio->new();
$BS->genome_repository();

my $achr = Bio::BioStudio::Chromosome->new(
  -name       => 'Escherichia_coli_chr01_0_00',
  -repo       => 't/test_repo/',
  -gbrowse     => 0
);
my $bchr = $achr->iterate;


#Testing add_feature, no new seq
my $nname = 'test_tag';
my $nfeat = Bio::SeqFeature::Generic->new(
  -start         => 2680,
  -end           => 2700,
  -primary_tag   => $nname,
  -display_name  => $nname,
);
my $rchr = bless(
    {
        'chromosome_id' => '01',
        'sequence' =>
'TATGGGTACCACAAAGCGAGGTCGCTTTTGAAGAGCCCTCGGTAGCATAACATTTTTAATTATTACGACTGTTTTTTTTATTCATTATGTAGAGATAATTAAATGTTATAGATGCTCTATACTCAAACGGTGGAAGAAAAACAGCGAAAAAAAATAACCGATACCCCCTTTTCGAATACAAATGCTTGTATATTCAATTATGAATTATTTTTTTTTTTTTTCATTTCTTATATTATTTTTTGTTCGAGAATCACTTTTTCAAGATGGTAACAACATCTTCGTCTTCCAAAATGTGACTCAACCCCACGTATTGAGGTTGATGTTTGACACTGCTACCGTAAACCAGAGCATTTCTAAAGTCGTCCACTAAAGATTTATGAATTTGGTTACAAAAATCCTTGACACTGCAACGGTCTGATCTTAGCACCACAGGGTCGGTAAAATCTGGTATTTGGCCCTTTGGTTTAGTGTAAATACGGACTAGATTTAGTCTATCCCACATGACTTGCAACAGCTCGTCCAAGTTCCAATCTTGACCAGACGAAATAGGCACGGCATTAGGAATTCGGTAAAGTAATTCCAATTCCTCTATTGACAGAGAATCAATCTTGTTTAACACATAGATGGCAGGCATGTATCTTCTTGACGAAGCTTCCAAAACATCAATCAAATCATCCACAGTGGCATCACACCTGAAGGCAATCTCAGCGCTATTTATTCTGTACTCGCTCATAACGGCTCTGATTTCGTCATTCCCCAGATGGGTCAATGGGACTGTGTTTGTGATGGAAATACCACCTTTCTCTTTTTTTTTGATCAAGATATCTGGCGGAGTTTTATTCAGACGAATCCCCACACCTTCCAGTTCCTTCTCAATGATTTGCTTATGATGCAAGGGTTTGTTCACATCTAGGATGATAAATAACAGGTTACAGGTTCTTGCCACGGCAATAACTTGCTTACCTCTACCTCTACCATCCTTAGCACCATCGATAATACCAGGTAAATCCAACATTTGGATCTTGGCACCTTTATAACGAATGACACCGGGGACGGTAACCAGGGTGGTAAACTCGTACTCAGCTGCTTCAGACTCAGTACCAGTCAACTTGGACAGTAATGTAGATTTCCCCACCGACGGGAACCCGACAAACCCCACACTGGCCACACCAGTTCTAGCCACATCAAAACCAATACCAGCACCACCACCGCTGCCGGATGAAGCACTGGTCAACAATTCTCTTCTCAGTTTGGCCAGCTTGGCCTTCAGTTGACCCAAATGGAAAGATGTGGCCTTGTTCTTTTGGGTACGGGCCATTTCATCTTCGATAGCTTTGATTTTTTCAACTGTAGTAGACATTTTTGCTCAATCAACAACTCTACGCTTGCACCTACTGCATCTAGCTTCAAACACTTCCTATCATTGCGCCCTCATCACACCGTAATATCCCATCTTAAAAGTGGAAAACTCTTATAGCTCATCGATGAAAAAAACGGGCCCTCGTCGCTTGTGATGTGAAAAAATTTTTCAAGCTTTAAGCCCATTGAAAGCAAGAGATCTTGCACTAGAATAAGTGGCAAAGGTGAACTTTGAGGGGATAAGAAGGGCATCTCCTCCGGAGTCATTGCCATCTGCGTTGAGTACCAAAGCTTTGAGCCCGTCAGAATCCTTGGCCACCGGACATGCTTCACAGATATAGAACGTAGCATGGTCTGTGGGAGCTTCATTTCTATGTTTTACCTTCTCTTTTCGCTTTTATGGTTCTCAGTGACCAAATAAAGAAACTTATATATGTTCCGGAATGACGAATCAAAAAGAGAATAGCATCGTTAGCAGCAAACGAAAGTGGAAAGAGAATAATGTTCAAGAGAGCAATGAGCACAGATGGTCCCGTGGCACGTACCATCCTGAAGAGACTGGAATGCGGCTTTCCAGATTACAAGAACTTTGCGTTTGGCCTCTACAACGATTCTCACAAGCATAAGGGCCATGCTGGTGTACAGGGAAATGTCTCTGCTGAGACACATTTCCGGATTGAGATGGTCAGTAAAAAGTTCGAAGGCCTGAAACTTCCACAACGCCATCGTATGGTTTATTCCCTCTTGCAAGACGAGATGGCTCAGGCGAACGGTATCCATGCTTTACAATTGTCACTAAAGACCCCACAGGAGTATGAATCCAAAGCGAAATAGGAATGCATAAGCATAAGTGTACACGTTGAGTTTATTGTTTTATTTCCCCTACATATATATACATATATATGAAATTACTTTACGTACGTATAAGCTTTGTTCAGTCATCATGAACCAGTGTCTTTTCGTACTGTTCTAAGGACATTAGACCCTCGACCTGTTCCACATTAACGCCCTCACCAAGCTTCATTTTGACTAGCCAGCCGTCACCCATAGGATCTTCGTTCACCACACCTGGATTTTCCTCAAGTATTATATATTTTGCTTTATGATCCTCGGCTTGATGCTCGCCAACGTGAGATAGCTGGTCATCACAATAGATCAGCCGGGACGCTTTTCGATCACATCGAATCCCTTCGGGACGTTGCAACAATACGTGAAAAATGCCTCAAAAATAATAAATACAATGGTGAACAACGTTAAAAAAGCATAAAACAGCTGGCTATTTTGATCAGGATAACATCTATAAGTGCCATATTAAGGCAAGATATCAATTGACCATGCAAACACCTTCAGAAAATACCGACGTAAAGATGGATACTCTCGACGAACCCAGTGCACATTTAATCGAAGAGAATGTAGCTCTTCCCGAAGACACATTCAGTTCACATCTGAGTTATGTACTTTATGAAATTGCTCATTGTAAACCGATCATGTTTATGATCATCATAATCGTGAGTTTGATCTCATTGATTGTGCTTTTTCATGATAACGACGGGTGCACTGTGATCTTAGTGATGTCCCTTATAGTAGCCTCCATGGCTTTAATGGTGGTTGCAGCATTCACATTCGGGAAAGCGATCACTGAACAGGAGTTCATGATAAAGCTTTTAGTGGAGGTGATCGCACGCAAGCCTGCGGGGAAGGAATGGGGTACTGTCGCATATAATATGAACCAATATCTATTCATGAAGAGACTATGGTATACCCCGTACTATTTCTATAGCGGCAAGAAGTGCCATGAGTTCTTCACCACTCTTATCAAGGAAGTGAATTCTGGTTCGCACTCGGATTCCTCATCGAATAGTGCCGAGGATACACAATCACCTGTCTCAGCAGGGAAGACTTCAAATGGTCTAAACAACTTTTATAGTATTAGATCAGACCCTATTTTGATGGCATATGTTTTGAAGGCAACACAAATAGAAAAGGAGGCTCAAAGTGAATACTGGAGAAAGCAATATCCTGACGCTGATTTACCTTGAAAGCGGAAGCATTTTATTCACCAAGTATACTTACTTTTCTTTAAAACGAGAACAAGAATCGAATTCAAGAACATCTCGAAGCCAGAATTGAGCATCATATATTCGAGCTGTACAAACATCATGGCCTACAACTATCGTATTTGTAAGTTTTTTTAGAGGTTTTCATATTTGTTTAATAAGGGTTCTGTCAGTTTTTGTCACATTCTATTGTTGCGCTTCGCATAATGCAGCCAAGAAAATCCAAACAATACCTTTCTACATACTACTACATAATATATATATATAGTATAGAAATTGGTATATCACTACTTGTACAAATATCATATTGTACGATAATCGCGAAGAACGACGCACTGGTGGGAAGAAGTGGAAAACAGAAGCTTTAAGGTAGAAACAGAACAAGAATGTGGCTATGGTAGGATAGCAAAAGAGTACCATTGCTGTTATCATTTGTTGCCTAGCCCTATCAAGACCTGTCTGCTAATCCAACCCGAGAGATCATGGCGATCCAAACCCGTTTTGCCTCGGGCACATCTTTATCCGATTTGAAACCAAAACCAAGTGCAACTTCCATCTCCATACCCATGCAAAATGTCATGAACAAGCCTGTCACGGAACAGGACTCACTGTTCCATATATGCGCAAACATCCGGAAAAGACTGGAGGTGTTACCTCAACTCAAACCTTTTTTACAATTGGCCTACCAATCGAGCGAGGTTTTGAGTGAAAGGCAATCTCTTTTGCTATCCCAAAAGCAGCATCAGGAACTGCTCAAGTCCAATGGCGCTAACCGGGACAGTAGCGACTTGGCACCAACTTTAAGGTCTAGCTCTATCTCCACAGCTACCAGTCTCATGTCGATGGAAGGTATATCATACACGAATTCGAATCCCTCGGCCACCCCAAATATGGAGGACACTTTACTGACTTTTAGTATGGGTATTTTGCCCATTACCATGGATTGCGACCCTGTGACACAACTATCACAGCTGTTTCAACAAGGTGCGCCCCTCTGTATACTTTTCAACTCTGTGAAGCCGCAATTTAAATTACCGGTAATAGCATCTGACGATTTGAAAGTCTGTAAAAAATCCATTTATGACTTTATATTGGGCTGCAAGAAACACTTTGCATTTAACGATGAGGAGCTTTTCACTATATCCGACGTTTTTGCCAACTCTACTTCCCAGCTGGTCAAAGTGCTAGAAGTAGTAGAAACGCTAATGAATTCCAGCCCTACTATTTTCCCCTCTAAGAGTAAGACACAGCAAATCATGAACGCAGAAAACCAACACCGACATCAGCCTCAGCAGTCTTCGAAGAAGCATAACGAGTATGTTAAAATTATCAAGGAATTCGTTGCAACGGAAAGAAAATATGTTCACGATTTGGAAATTTTGGATAAATATAGACAGCAGTTATTAGACAGCAATCTAATAACGTCTGAAGAGTTGTACATGTTGTTCCCTAATTTGGGTGATGCTATAGATTTTCAAAGAAGATTTCTAATATCCTTGGAAATAAATGCTTTAGTAGAACCTTCCAAGCAAAGAATCGGGGCTCTTTTCATGCATTCCAAACATTTTTTTAAGTTGTATGAGCCTTGGTCTATTGGCCAAAATGCAGCCATCGAATTTCTCTCTTCAACTTTGCACAAGATGAGGGTTGATGAATCGCAGCGGTTCATAATTAACAATAAACTGGAATTGCAATCCTTCCTTTATAAACCCGTGCAAAGGCTTTGTAGATATCCCCTGTTGGTCAAAGAATTGCTTGCTGAATCGAGTGACGATAATAATACGAAAGAACTTGAAGCTGCTTTAGATATTTCTAAAAATATTGCGAGAAGTATCAACGAAAATCAAAGAAGAACAGAAAATCATCAAGTGGTGAAGAAACTTTATGGTAGAGTGGTCAACTGGAAGGGTTATAGAATTTCCAAGTTCGGTGAGTTATTATATTTCGATAAAGTGTTCATTTCAACAACAAATAGCTCCTCGGAACCTGAAAGAGAATTTGAGGTTTATCTTTTTGAAAAAATCATCATCCTTTTTTCAGAGGTAGTGACTAAGAAATCTGCATCATCACTAATCCTTAAGAAGAAATCCTCAACCTCAGCATCAATCTCCGCCTCGAACATAACGGACAACAATGGCAGCCCTCACCACAGTTACCATAAGAGGCATAGCAATAGTAGTAGCAGTAATAATATCCATTTATCTTCGTCTTCAGCAGCGGCGATAATACATTCCAGTACCAATAGTAGTGACAACAATTCCAACAATTCATCATCATCCTCATTATTCAAGCTGTCCGCTAACGAACCTAAGCTGGATCTAAGAGGTCGAATTATGATAATGAATCTGAATCAAATCATACCGCAAAACAACCGGTCATTAAATATAACATGGGAATCCATAAAAGAGCAAGGTAATTTCCTTTTGAAATTCAAAAATGAGGAAACAAGAGATAATTGGTCATCGTGTTTACAACAGTTGATTCATGATCTGAAAAATGAGCAGTTTAAGGCAAGACATCACTCTTCAACATCGACGACTTCATCGACAGCCAAATCATCTTCAATGATGTCACCCACCACAACTATGAATACACCGAATCATCACAACAGCCGCCAGACACACGATAGTATGGCTTCTTTCTCAAGTTCTCATATGAAAAGGGTTTCGGATGTCCTGCCTAAACGGAGGACCACTTCATCAAGTTTCGAAAGTGAAATTAAATCCATTTCAGAAAATTTCAAGAACTCTATTCCAGAATCTTCCATACTCTTCAGGATATCATATAATAACAACTCTAATAATACCTCTAGTAGCGAGATCTTCACACTTTTGGTAGAAAAAGTTTGGAATTTTGACGACTTGATAATGGCGATCAATTCTAAAATTTCGAATACACATAATAACAACATTTCACCAATCACCAAGATCAAATATCAGGACGAAGATGGGGATTTTGTTGTGTTAGGTAGCGATGAAGATTGGAATGTTGCTAAAGAAATGTTGGCGGAAAACAATGAGAAATTCTTGAACATTCGTCTGTATTGAATAAATAAAACTAGTATACAGCAAATACTAAATAATTCAAGAAAAAAACATTAGATAGAGAGGGGCAGATGTTCAAGCTATACCCATTATATTGATCCACACTTAGTATTAAGATACGTCTGTGAAGGATGAAAAAAAATGTATAATGTGACTAGAGGAAGTAAGGAGAAAAAACGATAGTAATCGTATTTTAGGTTGTGCGTTTTTATAATTTTTTTTTTTTTGTAATTCTATGCAAATGTAATATAAGGGTCAGTAAAAAGTTCGAAGGCCTGAAACTTCCACAACGCCATCGTATGGTTTATTCCCTCTTGCAAGACGAGATGGCTCAGGCGAACGGTATCCATGCTTTACAATTGTCACTAAAGACCCCACAGGAGTATGAATCCAAAGCGAAATAGAATGCATAAGCATAAGTGTACACGTTGAGTTTATTGTTTTATTTCCCCTACATATATATACATATATATGAAATTACTTTACGTACGTATAAGCTTTGTTCAGTCATCATGAACCAGTGTCTTTTCGTACTGTTCTAAGGACATTAGACCCTCGACCTGTTCCACATTAACGCCCTCACCAAGCTTCATTTTGACTAGCCAGCCGTCACCCATAGGATCTTCGTTCACCACACCTGGATTTTCCTCAAGATTAGTGTTAATTTCCTCTACGGTACCATCGGCAGGCTGGTAGATCTCGGAGGCTGACTTGACGGACTCAATGGACCCTAGCGACTCACCTTGGGAAATCTCAGTGCCCACTTCTGGCAACTCAACATAGGTAGCGTCCCCTAAGGAATCAGTGGCGTATTTTGTAATTCCGACAAAGGCAGTCTTGTCCTGATGCACAGCTATCCACTCATGTTGGGAAGTGTACCTCACGGCTTGAGGTCCTTGGGATGAGTACAAAAATGGTAGTTTATTCTTGTTTAGGGCATTGCCGGAGCTGTTTCTCAAAAACAATTTGCTCACAGCGGGCATGCGGGTGGTCCATAGTCTAGTAGTGCGTAACATTTGTCGATGTGGTATGCTTCATGTGGAGATTCCCTTTCCCATTAGATACTTGTTTGTTGGTCTGTATATATAGAAGAAAGAGTTAGCGAAAGTGACTCCGCCGCTGAATGACTCCTTACGGAAGTGTCAAAATTGCGAGGTCCCTATAGCACAGAATGATAGATAAAACATTGATTTGCAAGTTGAAGGAAGACCCTACACATGCGTATATATGATGTATGTAATGGTTGTGATCATTTTAGCCTGTCAA',
        'chromosome_version' => '01',
        'comments'           => [
            'test_tag added
'
        ],
        'provisional' => -1,
        'repo'        => 't/test_repo/',
        'tag'         => undef,
        'GD'          => bless(
            {
                'codon_path' => ignore(),
                'rscutable'  => {
                    'GCC' => '0.18',
                    'AGT' => '0.13',
                    'TGT' => '0.60',
                    'TGA' => '0.00',
                    'CGA' => '0.00',
                    'ATC' => '2.51',
                    'AAC' => '1.98',
                    'AGC' => '0.93',
                    'TAC' => '1.63',
                    'ACA' => '0.10',
                    'TCG' => '0.00',
                    'CCG' => '3.41',
                    'CTG' => '5.54',
                    'GCA' => '1.09',
                    'AAG' => '0.37',
                    'GTG' => '0.40',
                    'CAC' => '1.55',
                    'GTT' => '2.41',
                    'AGA' => '0.00',
                    'ACC' => '1.91',
                    'CCA' => '0.42',
                    'TGG' => '1.00',
                    'CGC' => '1.53',
                    'CTC' => '0.17',
                    'TTG' => '0.07',
                    'TAA' => '1.00',
                    'CAG' => '1.88',
                    'ACG' => '0.12',
                    'AAA' => '1.63',
                    'ATG' => '1.00',
                    'GTA' => '1.12',
                    'CTT' => '0.13',
                    'TAG' => '0.00',
                    'GGA' => '0.00',
                    'GTC' => '0.08',
                    'TGC' => '1.40',
                    'TCA' => '0.06',
                    'ATT' => '0.48',
                    'TAT' => '0.38',
                    'AAT' => '0.02',
                    'ACT' => '1.87',
                    'CAA' => '0.12',
                    'GAC' => '1.49',
                    'GGT' => '2.27',
                    'TCC' => '2.07',
                    'TTT' => '0.34',
                    'AGG' => '0.00',
                    'CGT' => '4.47',
                    'ATA' => '0.01',
                    'CAT' => '0.45',
                    'CGG' => '0.00',
                    'CCC' => '0.02',
                    'GGG' => '0.04',
                    'TTA' => '0.06',
                    'GAG' => '0.36',
                    'CTA' => '0.04',
                    'GAT' => '0.51',
                    'TCT' => '2.81',
                    'TTC' => '1.66',
                    'GCG' => '0.71',
                    'GGC' => '1.68',
                    'GCT' => '2.02',
                    'GAA' => '1.64',
                    'CCT' => '0.15'
                },
                'amb_trans_memo' => {},
                'BLAST'          => undef,
                'version'        => ignore(),
                'enzyme_set'     => undef,
                'conf'           => ignore(),
                'script_path'    => ignore(),
                'codontable'     => {
                    'GCC' => 'A',
                    'AGT' => 'S',
                    'TGA' => '*',
                    'TGT' => 'C',
                    'CGA' => 'R',
                    'ATC' => 'I',
                    'AAC' => 'N',
                    'AGC' => 'S',
                    'TAC' => 'Y',
                    'ACA' => 'T',
                    'TCG' => 'S',
                    'CCG' => 'P',
                    'CTG' => 'L',
                    'GCA' => 'A',
                    'AAG' => 'K',
                    'GTG' => 'V',
                    'CAC' => 'H',
                    'GTT' => 'V',
                    'AGA' => 'R',
                    'ACC' => 'T',
                    'CCA' => 'P',
                    'TGG' => 'W',
                    'CGC' => 'R',
                    'CTC' => 'L',
                    'TTG' => 'L',
                    'TAA' => '*',
                    'CAG' => 'Q',
                    'ACG' => 'T',
                    'AAA' => 'K',
                    'ATG' => 'M',
                    'GTA' => 'V',
                    'CTT' => 'L',
                    'TAG' => '*',
                    'GGA' => 'G',
                    'GTC' => 'V',
                    'TGC' => 'C',
                    'TCA' => 'S',
                    'ATT' => 'I',
                    'TAT' => 'Y',
                    'AAT' => 'N',
                    'ACT' => 'T',
                    'CAA' => 'Q',
                    'GAC' => 'D',
                    'GGT' => 'G',
                    'TCC' => 'S',
                    'TTT' => 'F',
                    'AGG' => 'R',
                    'CGT' => 'R',
                    'ATA' => 'I',
                    'CAT' => 'H',
                    'CGG' => 'R',
                    'CCC' => 'P',
                    'GGG' => 'G',
                    'TTA' => 'L',
                    'GAG' => 'E',
                    'CTA' => 'L',
                    'GAT' => 'D',
                    'TCT' => 'S',
                    'TTC' => 'F',
                    'GCG' => 'A',
                    'GGC' => 'G',
                    'GCT' => 'A',
                    'GAA' => 'E',
                    'CCT' => 'P'
                },
                'reversecodontable' => {
                  'F' => [ 'TTC', 'TTT' ],
                  'S' => [ 'AGC', 'AGT', 'TCA', 'TCC', 'TCG', 'TCT' ],
                  'T' => [ 'ACA', 'ACC', 'ACG', 'ACT' ],
                  'N' => [ 'AAC', 'AAT' ],
                  'K' => [ 'AAA', 'AAG' ],
                  '*' => [ 'TAA', 'TAG', 'TGA' ],
                  'E' => [ 'GAA', 'GAG' ],
                  'Y' => [ 'TAC', 'TAT' ],
                  'V' => [ 'GTA', 'GTC', 'GTG', 'GTT' ],
                  'Q' => [ 'CAA', 'CAG' ],
                  'M' => [ 'ATG' ],
                  'C' => [ 'TGC', 'TGT' ],
                  'L' => [ 'CTA', 'CTC', 'CTG', 'CTT', 'TTA', 'TTG' ],
                  'A' => [ 'GCA', 'GCC', 'GCG', 'GCT' ],
                  'W' => [ 'TGG' ],
                  'P' => [ 'CCA', 'CCC', 'CCG', 'CCT' ],
                  'H' => [ 'CAC', 'CAT' ],
                  'D' => [ 'GAC', 'GAT' ],
                  'I' => [ 'ATA', 'ATC', 'ATT' ],
                  'R' => [ 'AGA', 'AGG', 'CGA', 'CGC', 'CGG', 'CGT' ],
                  'G' => [ 'GGA', 'GGC', 'GGG', 'GGT' ]
                },
                'tmp_path' => ignore(),
                'EMBOSS'   => ignore(),
                'graph'    => ignore(),
                'organism' => 'Escherichia_coli',
                'vmatch'   => undef
            },
            'Bio::GeneDesign'
        ),
        'mask' => ignore(),
        'seq_id'         => 'chr01',
        'gbrowse'        => 0,
        'species'        => 'Escherichia_coli',
        'genome_version' => '0',        'database' => bless( {
                               'dbh_file' => ignore(),
                               'namespace' => undef,
                               'settings_cache' => {
                                                     'autoindex' => 1,
                                                     'index_subfeatures' => 1,
                                                     'serializer' => 'Storable',
                                                     'compress' => ignore(),
                                                   },
                               'dumpdir' => ignore(),
                               'dbh' => ignore(),
                               'writeable' => 1,
                               'seqfeatureclass' => 'Bio::DB::SeqFeature',
                               '_has_spatial_index' => 0,
                               'is_temp' => undef,
                               'fts' => undef,
                             }, 
                             'Bio::DB::SeqFeature::Store::DBI::SQLite' ),
        '_root_verbose' => 0
    },
    'Bio::BioStudio::Chromosome'
);
$bchr->add_feature(
    -feature => $nfeat
);
$bchr->write_chromosome();
cmp_deeply( $bchr, $rchr, "add without sequence change" );

my $cchr = $bchr->iterate;

#Testing add_feature, same name, new seq
my $yname = 'test_tag';
my $yfeat = Bio::SeqFeature::Generic->new(
  -start         => 2680,
  -end           => 2700,
  -primary_tag   => $yname,
  -display_name  => $yname,
  -tag           => {
    newseq => 'GATATCAATTGACCATGCATA'
  },
);
$rchr = bless(
    {
        'chromosome_id' => '01',
        'sequence' =>
'TATGGGTACCACAAAGCGAGGTCGCTTTTGAAGAGCCCTCGGTAGCATAACATTTTTAATTATTACGACTGTTTTTTTTATTCATTATGTAGAGATAATTAAATGTTATAGATGCTCTATACTCAAACGGTGGAAGAAAAACAGCGAAAAAAAATAACCGATACCCCCTTTTCGAATACAAATGCTTGTATATTCAATTATGAATTATTTTTTTTTTTTTTCATTTCTTATATTATTTTTTGTTCGAGAATCACTTTTTCAAGATGGTAACAACATCTTCGTCTTCCAAAATGTGACTCAACCCCACGTATTGAGGTTGATGTTTGACACTGCTACCGTAAACCAGAGCATTTCTAAAGTCGTCCACTAAAGATTTATGAATTTGGTTACAAAAATCCTTGACACTGCAACGGTCTGATCTTAGCACCACAGGGTCGGTAAAATCTGGTATTTGGCCCTTTGGTTTAGTGTAAATACGGACTAGATTTAGTCTATCCCACATGACTTGCAACAGCTCGTCCAAGTTCCAATCTTGACCAGACGAAATAGGCACGGCATTAGGAATTCGGTAAAGTAATTCCAATTCCTCTATTGACAGAGAATCAATCTTGTTTAACACATAGATGGCAGGCATGTATCTTCTTGACGAAGCTTCCAAAACATCAATCAAATCATCCACAGTGGCATCACACCTGAAGGCAATCTCAGCGCTATTTATTCTGTACTCGCTCATAACGGCTCTGATTTCGTCATTCCCCAGATGGGTCAATGGGACTGTGTTTGTGATGGAAATACCACCTTTCTCTTTTTTTTTGATCAAGATATCTGGCGGAGTTTTATTCAGACGAATCCCCACACCTTCCAGTTCCTTCTCAATGATTTGCTTATGATGCAAGGGTTTGTTCACATCTAGGATGATAAATAACAGGTTACAGGTTCTTGCCACGGCAATAACTTGCTTACCTCTACCTCTACCATCCTTAGCACCATCGATAATACCAGGTAAATCCAACATTTGGATCTTGGCACCTTTATAACGAATGACACCGGGGACGGTAACCAGGGTGGTAAACTCGTACTCAGCTGCTTCAGACTCAGTACCAGTCAACTTGGACAGTAATGTAGATTTCCCCACCGACGGGAACCCGACAAACCCCACACTGGCCACACCAGTTCTAGCCACATCAAAACCAATACCAGCACCACCACCGCTGCCGGATGAAGCACTGGTCAACAATTCTCTTCTCAGTTTGGCCAGCTTGGCCTTCAGTTGACCCAAATGGAAAGATGTGGCCTTGTTCTTTTGGGTACGGGCCATTTCATCTTCGATAGCTTTGATTTTTTCAACTGTAGTAGACATTTTTGCTCAATCAACAACTCTACGCTTGCACCTACTGCATCTAGCTTCAAACACTTCCTATCATTGCGCCCTCATCACACCGTAATATCCCATCTTAAAAGTGGAAAACTCTTATAGCTCATCGATGAAAAAAACGGGCCCTCGTCGCTTGTGATGTGAAAAAATTTTTCAAGCTTTAAGCCCATTGAAAGCAAGAGATCTTGCACTAGAATAAGTGGCAAAGGTGAACTTTGAGGGGATAAGAAGGGCATCTCCTCCGGAGTCATTGCCATCTGCGTTGAGTACCAAAGCTTTGAGCCCGTCAGAATCCTTGGCCACCGGACATGCTTCACAGATATAGAACGTAGCATGGTCTGTGGGAGCTTCATTTCTATGTTTTACCTTCTCTTTTCGCTTTTATGGTTCTCAGTGACCAAATAAAGAAACTTATATATGTTCCGGAATGACGAATCAAAAAGAGAATAGCATCGTTAGCAGCAAACGAAAGTGGAAAGAGAATAATGTTCAAGAGAGCAATGAGCACAGATGGTCCCGTGGCACGTACCATCCTGAAGAGACTGGAATGCGGCTTTCCAGATTACAAGAACTTTGCGTTTGGCCTCTACAACGATTCTCACAAGCATAAGGGCCATGCTGGTGTACAGGGAAATGTCTCTGCTGAGACACATTTCCGGATTGAGATGGTCAGTAAAAAGTTCGAAGGCCTGAAACTTCCACAACGCCATCGTATGGTTTATTCCCTCTTGCAAGACGAGATGGCTCAGGCGAACGGTATCCATGCTTTACAATTGTCACTAAAGACCCCACAGGAGTATGAATCCAAAGCGAAATAGGAATGCATAAGCATAAGTGTACACGTTGAGTTTATTGTTTTATTTCCCCTACATATATATACATATATATGAAATTACTTTACGTACGTATAAGCTTTGTTCAGTCATCATGAACCAGTGTCTTTTCGTACTGTTCTAAGGACATTAGACCCTCGACCTGTTCCACATTAACGCCCTCACCAAGCTTCATTTTGACTAGCCAGCCGTCACCCATAGGATCTTCGTTCACCACACCTGGATTTTCCTCAAGTATTATATATTTTGCTTTATGATCCTCGGCTTGATGCTCGCCAACGTGAGATAGCTGGTCATCACAATAGATCAGCCGGGACGCTTTTCGATCACATCGAATCCCTTCGGGACGTTGCAACAATACGTGAAAAATGCCTCAAAAATAATAAATACAATGGTGAACAACGTTAAAAAAGCATAAAACAGCTGGCTATTTTGATCAGGATAACATCTATAAGTGCCATATTAAGGCAAGATATCAATTGACCATGCATACACCTTCAGAAAATACCGACGTAAAGATGGATACTCTCGACGAACCCAGTGCACATTTAATCGAAGAGAATGTAGCTCTTCCCGAAGACACATTCAGTTCACATCTGAGTTATGTACTTTATGAAATTGCTCATTGTAAACCGATCATGTTTATGATCATCATAATCGTGAGTTTGATCTCATTGATTGTGCTTTTTCATGATAACGACGGGTGCACTGTGATCTTAGTGATGTCCCTTATAGTAGCCTCCATGGCTTTAATGGTGGTTGCAGCATTCACATTCGGGAAAGCGATCACTGAACAGGAGTTCATGATAAAGCTTTTAGTGGAGGTGATCGCACGCAAGCCTGCGGGGAAGGAATGGGGTACTGTCGCATATAATATGAACCAATATCTATTCATGAAGAGACTATGGTATACCCCGTACTATTTCTATAGCGGCAAGAAGTGCCATGAGTTCTTCACCACTCTTATCAAGGAAGTGAATTCTGGTTCGCACTCGGATTCCTCATCGAATAGTGCCGAGGATACACAATCACCTGTCTCAGCAGGGAAGACTTCAAATGGTCTAAACAACTTTTATAGTATTAGATCAGACCCTATTTTGATGGCATATGTTTTGAAGGCAACACAAATAGAAAAGGAGGCTCAAAGTGAATACTGGAGAAAGCAATATCCTGACGCTGATTTACCTTGAAAGCGGAAGCATTTTATTCACCAAGTATACTTACTTTTCTTTAAAACGAGAACAAGAATCGAATTCAAGAACATCTCGAAGCCAGAATTGAGCATCATATATTCGAGCTGTACAAACATCATGGCCTACAACTATCGTATTTGTAAGTTTTTTTAGAGGTTTTCATATTTGTTTAATAAGGGTTCTGTCAGTTTTTGTCACATTCTATTGTTGCGCTTCGCATAATGCAGCCAAGAAAATCCAAACAATACCTTTCTACATACTACTACATAATATATATATATAGTATAGAAATTGGTATATCACTACTTGTACAAATATCATATTGTACGATAATCGCGAAGAACGACGCACTGGTGGGAAGAAGTGGAAAACAGAAGCTTTAAGGTAGAAACAGAACAAGAATGTGGCTATGGTAGGATAGCAAAAGAGTACCATTGCTGTTATCATTTGTTGCCTAGCCCTATCAAGACCTGTCTGCTAATCCAACCCGAGAGATCATGGCGATCCAAACCCGTTTTGCCTCGGGCACATCTTTATCCGATTTGAAACCAAAACCAAGTGCAACTTCCATCTCCATACCCATGCAAAATGTCATGAACAAGCCTGTCACGGAACAGGACTCACTGTTCCATATATGCGCAAACATCCGGAAAAGACTGGAGGTGTTACCTCAACTCAAACCTTTTTTACAATTGGCCTACCAATCGAGCGAGGTTTTGAGTGAAAGGCAATCTCTTTTGCTATCCCAAAAGCAGCATCAGGAACTGCTCAAGTCCAATGGCGCTAACCGGGACAGTAGCGACTTGGCACCAACTTTAAGGTCTAGCTCTATCTCCACAGCTACCAGTCTCATGTCGATGGAAGGTATATCATACACGAATTCGAATCCCTCGGCCACCCCAAATATGGAGGACACTTTACTGACTTTTAGTATGGGTATTTTGCCCATTACCATGGATTGCGACCCTGTGACACAACTATCACAGCTGTTTCAACAAGGTGCGCCCCTCTGTATACTTTTCAACTCTGTGAAGCCGCAATTTAAATTACCGGTAATAGCATCTGACGATTTGAAAGTCTGTAAAAAATCCATTTATGACTTTATATTGGGCTGCAAGAAACACTTTGCATTTAACGATGAGGAGCTTTTCACTATATCCGACGTTTTTGCCAACTCTACTTCCCAGCTGGTCAAAGTGCTAGAAGTAGTAGAAACGCTAATGAATTCCAGCCCTACTATTTTCCCCTCTAAGAGTAAGACACAGCAAATCATGAACGCAGAAAACCAACACCGACATCAGCCTCAGCAGTCTTCGAAGAAGCATAACGAGTATGTTAAAATTATCAAGGAATTCGTTGCAACGGAAAGAAAATATGTTCACGATTTGGAAATTTTGGATAAATATAGACAGCAGTTATTAGACAGCAATCTAATAACGTCTGAAGAGTTGTACATGTTGTTCCCTAATTTGGGTGATGCTATAGATTTTCAAAGAAGATTTCTAATATCCTTGGAAATAAATGCTTTAGTAGAACCTTCCAAGCAAAGAATCGGGGCTCTTTTCATGCATTCCAAACATTTTTTTAAGTTGTATGAGCCTTGGTCTATTGGCCAAAATGCAGCCATCGAATTTCTCTCTTCAACTTTGCACAAGATGAGGGTTGATGAATCGCAGCGGTTCATAATTAACAATAAACTGGAATTGCAATCCTTCCTTTATAAACCCGTGCAAAGGCTTTGTAGATATCCCCTGTTGGTCAAAGAATTGCTTGCTGAATCGAGTGACGATAATAATACGAAAGAACTTGAAGCTGCTTTAGATATTTCTAAAAATATTGCGAGAAGTATCAACGAAAATCAAAGAAGAACAGAAAATCATCAAGTGGTGAAGAAACTTTATGGTAGAGTGGTCAACTGGAAGGGTTATAGAATTTCCAAGTTCGGTGAGTTATTATATTTCGATAAAGTGTTCATTTCAACAACAAATAGCTCCTCGGAACCTGAAAGAGAATTTGAGGTTTATCTTTTTGAAAAAATCATCATCCTTTTTTCAGAGGTAGTGACTAAGAAATCTGCATCATCACTAATCCTTAAGAAGAAATCCTCAACCTCAGCATCAATCTCCGCCTCGAACATAACGGACAACAATGGCAGCCCTCACCACAGTTACCATAAGAGGCATAGCAATAGTAGTAGCAGTAATAATATCCATTTATCTTCGTCTTCAGCAGCGGCGATAATACATTCCAGTACCAATAGTAGTGACAACAATTCCAACAATTCATCATCATCCTCATTATTCAAGCTGTCCGCTAACGAACCTAAGCTGGATCTAAGAGGTCGAATTATGATAATGAATCTGAATCAAATCATACCGCAAAACAACCGGTCATTAAATATAACATGGGAATCCATAAAAGAGCAAGGTAATTTCCTTTTGAAATTCAAAAATGAGGAAACAAGAGATAATTGGTCATCGTGTTTACAACAGTTGATTCATGATCTGAAAAATGAGCAGTTTAAGGCAAGACATCACTCTTCAACATCGACGACTTCATCGACAGCCAAATCATCTTCAATGATGTCACCCACCACAACTATGAATACACCGAATCATCACAACAGCCGCCAGACACACGATAGTATGGCTTCTTTCTCAAGTTCTCATATGAAAAGGGTTTCGGATGTCCTGCCTAAACGGAGGACCACTTCATCAAGTTTCGAAAGTGAAATTAAATCCATTTCAGAAAATTTCAAGAACTCTATTCCAGAATCTTCCATACTCTTCAGGATATCATATAATAACAACTCTAATAATACCTCTAGTAGCGAGATCTTCACACTTTTGGTAGAAAAAGTTTGGAATTTTGACGACTTGATAATGGCGATCAATTCTAAAATTTCGAATACACATAATAACAACATTTCACCAATCACCAAGATCAAATATCAGGACGAAGATGGGGATTTTGTTGTGTTAGGTAGCGATGAAGATTGGAATGTTGCTAAAGAAATGTTGGCGGAAAACAATGAGAAATTCTTGAACATTCGTCTGTATTGAATAAATAAAACTAGTATACAGCAAATACTAAATAATTCAAGAAAAAAACATTAGATAGAGAGGGGCAGATGTTCAAGCTATACCCATTATATTGATCCACACTTAGTATTAAGATACGTCTGTGAAGGATGAAAAAAAATGTATAATGTGACTAGAGGAAGTAAGGAGAAAAAACGATAGTAATCGTATTTTAGGTTGTGCGTTTTTATAATTTTTTTTTTTTTGTAATTCTATGCAAATGTAATATAAGGGTCAGTAAAAAGTTCGAAGGCCTGAAACTTCCACAACGCCATCGTATGGTTTATTCCCTCTTGCAAGACGAGATGGCTCAGGCGAACGGTATCCATGCTTTACAATTGTCACTAAAGACCCCACAGGAGTATGAATCCAAAGCGAAATAGAATGCATAAGCATAAGTGTACACGTTGAGTTTATTGTTTTATTTCCCCTACATATATATACATATATATGAAATTACTTTACGTACGTATAAGCTTTGTTCAGTCATCATGAACCAGTGTCTTTTCGTACTGTTCTAAGGACATTAGACCCTCGACCTGTTCCACATTAACGCCCTCACCAAGCTTCATTTTGACTAGCCAGCCGTCACCCATAGGATCTTCGTTCACCACACCTGGATTTTCCTCAAGATTAGTGTTAATTTCCTCTACGGTACCATCGGCAGGCTGGTAGATCTCGGAGGCTGACTTGACGGACTCAATGGACCCTAGCGACTCACCTTGGGAAATCTCAGTGCCCACTTCTGGCAACTCAACATAGGTAGCGTCCCCTAAGGAATCAGTGGCGTATTTTGTAATTCCGACAAAGGCAGTCTTGTCCTGATGCACAGCTATCCACTCATGTTGGGAAGTGTACCTCACGGCTTGAGGTCCTTGGGATGAGTACAAAAATGGTAGTTTATTCTTGTTTAGGGCATTGCCGGAGCTGTTTCTCAAAAACAATTTGCTCACAGCGGGCATGCGGGTGGTCCATAGTCTAGTAGTGCGTAACATTTGTCGATGTGGTATGCTTCATGTGGAGATTCCCTTTCCCATTAGATACTTGTTTGTTGGTCTGTATATATAGAAGAAAGAGTTAGCGAAAGTGACTCCGCCGCTGAATGACTCCTTACGGAAGTGTCAAAATTGCGAGGTCCCTATAGCACAGAATGATAGATAAAACATTGATTTGCAAGTTGAAGGAAGACCCTACACATGCGTATATATGATGTATGTAATGGTTGTGATCATTTTAGCCTGTCAA',
        'chromosome_version' => '02',
        'comments'           => [
            'test_tag2 added
',
            '# test_tag added
'
        ],
        'provisional' => -1,
        'repo'        => 't/test_repo/',
        'tag'         => undef,
        'GD'          => bless(
            {
                'codon_path' => ignore(),
                'rscutable'  => {
                    'GCC' => '0.18',
                    'AGT' => '0.13',
                    'TGT' => '0.60',
                    'TGA' => '0.00',
                    'CGA' => '0.00',
                    'ATC' => '2.51',
                    'AAC' => '1.98',
                    'AGC' => '0.93',
                    'TAC' => '1.63',
                    'ACA' => '0.10',
                    'TCG' => '0.00',
                    'CCG' => '3.41',
                    'CTG' => '5.54',
                    'GCA' => '1.09',
                    'AAG' => '0.37',
                    'GTG' => '0.40',
                    'CAC' => '1.55',
                    'GTT' => '2.41',
                    'AGA' => '0.00',
                    'ACC' => '1.91',
                    'CCA' => '0.42',
                    'TGG' => '1.00',
                    'CGC' => '1.53',
                    'CTC' => '0.17',
                    'TTG' => '0.07',
                    'TAA' => '1.00',
                    'CAG' => '1.88',
                    'ACG' => '0.12',
                    'AAA' => '1.63',
                    'ATG' => '1.00',
                    'GTA' => '1.12',
                    'CTT' => '0.13',
                    'TAG' => '0.00',
                    'GGA' => '0.00',
                    'GTC' => '0.08',
                    'TGC' => '1.40',
                    'TCA' => '0.06',
                    'ATT' => '0.48',
                    'TAT' => '0.38',
                    'AAT' => '0.02',
                    'ACT' => '1.87',
                    'CAA' => '0.12',
                    'GAC' => '1.49',
                    'GGT' => '2.27',
                    'TCC' => '2.07',
                    'TTT' => '0.34',
                    'AGG' => '0.00',
                    'CGT' => '4.47',
                    'ATA' => '0.01',
                    'CAT' => '0.45',
                    'CGG' => '0.00',
                    'CCC' => '0.02',
                    'GGG' => '0.04',
                    'TTA' => '0.06',
                    'GAG' => '0.36',
                    'CTA' => '0.04',
                    'GAT' => '0.51',
                    'TCT' => '2.81',
                    'TTC' => '1.66',
                    'GCG' => '0.71',
                    'GGC' => '1.68',
                    'GCT' => '2.02',
                    'GAA' => '1.64',
                    'CCT' => '0.15'
                },
                'amb_trans_memo' => {},
                'BLAST'          => undef,
                'version'        => ignore(),
                'enzyme_set'     => undef,
                'conf'           => ignore(),
                'script_path'    => ignore(),
                'codontable'     => {
                    'GCC' => 'A',
                    'AGT' => 'S',
                    'TGA' => '*',
                    'TGT' => 'C',
                    'CGA' => 'R',
                    'ATC' => 'I',
                    'AAC' => 'N',
                    'AGC' => 'S',
                    'TAC' => 'Y',
                    'ACA' => 'T',
                    'TCG' => 'S',
                    'CCG' => 'P',
                    'CTG' => 'L',
                    'GCA' => 'A',
                    'AAG' => 'K',
                    'GTG' => 'V',
                    'CAC' => 'H',
                    'GTT' => 'V',
                    'AGA' => 'R',
                    'ACC' => 'T',
                    'CCA' => 'P',
                    'TGG' => 'W',
                    'CGC' => 'R',
                    'CTC' => 'L',
                    'TTG' => 'L',
                    'TAA' => '*',
                    'CAG' => 'Q',
                    'ACG' => 'T',
                    'AAA' => 'K',
                    'ATG' => 'M',
                    'GTA' => 'V',
                    'CTT' => 'L',
                    'TAG' => '*',
                    'GGA' => 'G',
                    'GTC' => 'V',
                    'TGC' => 'C',
                    'TCA' => 'S',
                    'ATT' => 'I',
                    'TAT' => 'Y',
                    'AAT' => 'N',
                    'ACT' => 'T',
                    'CAA' => 'Q',
                    'GAC' => 'D',
                    'GGT' => 'G',
                    'TCC' => 'S',
                    'TTT' => 'F',
                    'AGG' => 'R',
                    'CGT' => 'R',
                    'ATA' => 'I',
                    'CAT' => 'H',
                    'CGG' => 'R',
                    'CCC' => 'P',
                    'GGG' => 'G',
                    'TTA' => 'L',
                    'GAG' => 'E',
                    'CTA' => 'L',
                    'GAT' => 'D',
                    'TCT' => 'S',
                    'TTC' => 'F',
                    'GCG' => 'A',
                    'GGC' => 'G',
                    'GCT' => 'A',
                    'GAA' => 'E',
                    'CCT' => 'P'
                },
                'reversecodontable' => {
                  'F' => [ 'TTC', 'TTT' ],
                  'S' => [ 'AGC', 'AGT', 'TCA', 'TCC', 'TCG', 'TCT' ],
                  'T' => [ 'ACA', 'ACC', 'ACG', 'ACT' ],
                  'N' => [ 'AAC', 'AAT' ],
                  'K' => [ 'AAA', 'AAG' ],
                  '*' => [ 'TAA', 'TAG', 'TGA' ],
                  'E' => [ 'GAA', 'GAG' ],
                  'Y' => [ 'TAC', 'TAT' ],
                  'V' => [ 'GTA', 'GTC', 'GTG', 'GTT' ],
                  'Q' => [ 'CAA', 'CAG' ],
                  'M' => [ 'ATG' ],
                  'C' => [ 'TGC', 'TGT' ],
                  'L' => [ 'CTA', 'CTC', 'CTG', 'CTT', 'TTA', 'TTG' ],
                  'A' => [ 'GCA', 'GCC', 'GCG', 'GCT' ],
                  'W' => [ 'TGG' ],
                  'P' => [ 'CCA', 'CCC', 'CCG', 'CCT' ],
                  'H' => [ 'CAC', 'CAT' ],
                  'D' => [ 'GAC', 'GAT' ],
                  'I' => [ 'ATA', 'ATC', 'ATT' ],
                  'R' => [ 'AGA', 'AGG', 'CGA', 'CGC', 'CGG', 'CGT' ],
                  'G' => [ 'GGA', 'GGC', 'GGG', 'GGT' ]
                },
                'tmp_path' => ignore(),
                'EMBOSS'   => ignore(),
                'graph'    => ignore(),
                'organism' => 'Escherichia_coli',
                'vmatch'   => undef
            },
            'Bio::GeneDesign'
        ),
        'mask' => ignore(),
        'seq_id'         => 'chr01',
        'gbrowse'        => 0,
        'species'        => 'Escherichia_coli',
        'genome_version' => '0',        'database' => bless( {
                               'dbh_file' => ignore(),
                               'namespace' => undef,
                               'settings_cache' => {
                                                     'autoindex' => 1,
                                                     'index_subfeatures' => 1,
                                                     'serializer' => 'Storable',
                                                     'compress' => ignore(),
                                                   },
                               'dumpdir' => ignore(),
                               'dbh' => ignore(),
                               'writeable' => 1,
                               'seqfeatureclass' => 'Bio::DB::SeqFeature',
                               '_has_spatial_index' => 0,
                               'is_temp' => undef,
                               'fts' => undef,
                             }, 
                             'Bio::DB::SeqFeature::Store::DBI::SQLite' ),
        '_root_verbose' => 0
    },
    'Bio::BioStudio::Chromosome'
);

my $adddfeat = eval
{
  $cchr->add_feature(
      -feature => $yfeat
  );
};
my $ep1 = Bio::BioStudio::Exception::PreserveUniqueNames->caught();
isa_ok($ep1, 'Bio::BioStudio::Exception::PreserveUniqueNames', 'duplicate name');

$yname = 'test_tag2';
$yfeat->display_name($yname);

$cchr->add_feature(
    -feature => $yfeat
);
$cchr->write_chromosome();
cmp_deeply( $cchr, $rchr, "add with sequence change" );


unlink 't/Escherichia_coli_chr01_0_01' if (-e 't/Escherichia_coli_chr01_0_01');
unlink 't/Escherichia_coli_chr01_0_02' if (-e 't/Escherichia_coli_chr01_0_02');
unlink 't/Escherichia_coli_chr01_0_03' if (-e 't/Escherichia_coli_chr01_0_03');
unlink 't/Escherichia_coli_chr01_0_04' if (-e 't/Escherichia_coli_chr01_0_04');

