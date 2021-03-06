package TSQL::FlatFile;

use 5.010;
use strict;
use warnings;

use Text::CSV;


=head1 NAME

TSQL::FlatFile - secret module by Ded MedVed

=head1 VERSION

Version 1.04

=cut

our $VERSION = '1.04';


use Data::Dumper ;
use Carp ;

sub new {

    local $_ = undef ;
    
#warn Dumper @_;

    my $invocant         = shift ;
    my $class            = ref($invocant) || $invocant ;

    my @elems            = @_ ;
    my $self             = bless {crlf => "\r\n" }, $class ;
   
#    $self->_init(@elems) ;
    return $self ;
}

sub crlf {
    my $self = shift;
    return $self->{crlf};
    
}
sub processLine {

    my $self                    = shift or croak 'no self';
                
    my $asciifile               = shift || croak 'no ascii file name';
    my $cfile                   = shift || croak 'no csv file'; 
    my $cfile_fh                = shift || croak 'no csv file handle'; 
            
    my $filepos                 = shift || croak 'no file position given' ;
    my $incrementalsearch       = shift ;
    if (!defined $incrementalsearch) {
        croak 'no incrementalsearch flag given' ;
    }    my $debug                   = shift ;

    if (!defined $debug) {
        croak 'no debug flag given' ;
    }
    
    my $li=0;
    
    my %csv_row;
    my $ascii_row;
    
    $cfile->header($cfile_fh);
    while ((my $row = $cfile->getline_hr  ($cfile_fh)) && ($li++ < $filepos)) {
    #    warn Dumper $row;
        %csv_row = %$row;
    }
warn Dumper %csv_row;
    #warn Dumper keys %csv_row;
    my @vals = @{sort_values(\%csv_row) };                     
warn Dumper @vals;   
    $li=0;
    open(my $afile, "<", $asciifile)  or die "Could not open file $!";

    while (defined(my $row = <$afile> ) && ($li++ < $filepos)) {
        chomp $row;
        $ascii_row = $row;
    }
#warn Dumper $ascii_row;
#exit;
    my %positions ;
    foreach my $v (@vals){
        # only try a match if something exists to match
        if ((length($v) > 0 ) ) {
            my $val = quotemeta($csv_row{$v})." *";
            $ascii_row  =~ m/(?>$val)/;
            $positions{$v} = [@-,@+];
            if ((defined $&) ) {
warn "matched ",$& , "                       at ",  @-, " - ", @+ ,"                            ";
                $ascii_row = $`. "^"x length($&) . $';
            }
            else {
                warn "${v}: hasn't matched data ";  
            }
        }
    }
#warn  map { substr($_,1) } (keys %positions,1);    
    my @sortedkeys = sort {  $positions{$a}[0] <=> $positions{$b}[0]        ## sort on data length
                          || substr($a,1)      <=> substr($b,1)             ## then prefern matching L->R to match presumed csv ordering.
                          } keys %positions;
    #warn of any mismatches
    my $blanklines = "";
    foreach my $k (@sortedkeys) {
        if ($positions{$k}[0] == $positions{$k}[1] ) {
            warn "${k}: hasn't matched data - values ",$positions{$k}[0],":",$positions{$k}[1];
            $blanklines = $self->crlf;
        };
    };
    #warn of any gaps in matching;
    if ( $ascii_row !~ /\A[\^]*\z/igms ) {
        warn $ascii_row;
        $blanklines = $self->crlf unless $blanklines eq "";
    }
    
    warn $blanklines if $blanklines;
    
    my $result = "";   
    if ($debug) {
        my $i=1;
        foreach my $k (@sortedkeys) {
            if ($debug) { $result .= ($k . ("\t"x((55-length($k))/8)) . $positions{$k}[0] . "\t" . $positions{$k}[1]). $self->crlf };
            $i++;
        }
    }
    else {
        $result .= "12.0" . $self->crlf;
        $result .= (scalar(@sortedkeys)) .$self->crlf;
        my $i=1;
        my $first_offset = $positions{$sortedkeys[0]}[0];
#warn Dumper $first_offset;        
        foreach my $k (@sortedkeys) {
            $result .= ($i . "\t" . "SQLCHAR" . "\t" . "0" . "\t" .  ( ( $i==1?$first_offset:0 ) + $positions{$k}[1] - $positions{$k}[0]) . "\t" . (($i == scalar(@sortedkeys)) ? '"\r\n"':'""') . "\t" .  substr($k,1) . "\t" .  $k . "\t"x((55-length($k))/8) . "SQL_Latin1_General_CP1_CI_AS") . $self->crlf;
            $i++;
        }
    }
    return $result;
}


sub getLinePositions {
 
    my $self        = shift or croak 'no self';
    
    my $asciifile   = shift || croak 'no ascii file name';
    my $cfile       = shift || croak 'no csv file'; 
    my $cfile_fh    = shift || croak 'no csv file handle'; 

    my $filepos     = shift || croak 'no file position given' ;
    my $incrementalsearch       = shift ;
    if (!defined $incrementalsearch) {
        croak 'no incrementalsearch flag given' ;
    }
    my $debug                   = shift ;

    my $li=0;
    
    my %csv_row;
    my $ascii_row;
    
    $cfile->header($cfile_fh);
    while ((my $row = $cfile->getline_hr  ($cfile_fh)) && ($li++ < $filepos)) {
        %csv_row = %$row;
    }
    my @vals = @{sort_values(\%csv_row) };
    
    $li=0;
    open(my $afile, "<", $asciifile)  or die "Could not open file $!";
    #skip header
    #my $row = <$afile>;
    while (defined(my $row = <$afile> ) && ($li++ < $filepos)) {
        chomp $row;
        $ascii_row = $row;
    }
    #say $ascii_row;
    my %positions ;
    foreach my $v (@vals){
        my $val = quotemeta($csv_row{$v})." *";
        $ascii_row  =~ m/(?>$val)/;
        $positions{$v} = [@-,@+];
 

        if ((defined $&) ) {
            $ascii_row = $`. "^"x length($&) . $';
        }
        else {
            warn "${v}: hasn't matched data ";  
        }
    
    
    
    }
    
    my @sortedkeys = sort {  $positions{$a}[0] <=> $positions{$b}[0]        ## sort on data length
                          || substr($a,1)      <=> substr($b,1)             ## then prefern matching L->R to match presumed csv ordering.
                          } keys %positions;
    
    my @result = ();
    {
      my $i=0;
      foreach my $k (@sortedkeys) {
        $result[$i] = {key=>$k,start=>$positions{$k}[0],end=>$positions{$k}[1]};
        $i++;
      }
    }

    my $unmatchedcount = 0;
    foreach my $k (@sortedkeys) {
        if ($positions{$k}[0] == $positions{$k}[1] ) {
            $unmatchedcount++;
        };
    };

    my $unmatchedamount = length($ascii_row) - $ascii_row =~ tr/^//;

    my @best_result          = @result;
    my $best_line            = $filepos; 
    my $best_unmatchedcount  = $unmatchedcount; 
    my $best_unmatchedamount = $unmatchedamount;
    
    if  ($incrementalsearch && ( $best_unmatchedcount > 0 || $best_unmatchedamount > 0 ) ) {
    
        while ((my $crow = $cfile->getline_hr  ($cfile_fh)) && (defined(my $row = <$afile> )) && ($li++ < $filepos+100 ) && ( $best_unmatchedcount > 0 || $best_unmatchedamount > 0 ) ) {
    
            %csv_row = %$crow;
            
    #warn Dumper %csv_row;
    #warn Dumper keys %csv_row;
            my @vals = sort { length($csv_row{$b}) <=> length($csv_row{$a}) } keys %csv_row;
            
            
            chomp $row;
            $ascii_row = $row;
        
    #        say $li," ", $ascii_row;
    #say Dumper %csv_row;
            my %positions ;
            foreach my $v (@vals){
                my $val = quotemeta($csv_row{$v})." *";
                $ascii_row  =~ m/(?>$val)/;
                $positions{$v} = [@-,@+];
    #warn Dumper $val  unless defined $` ;        
    #warn  $ascii_row unless defined $` ;
        
                $ascii_row = $`. "^"x length($&) . $';
            }
            
            my @sortedkeys = sort {  $positions{$a}[0] <=> $positions{$b}[0]        ## sort on data length
                          || substr($a,1)      <=> substr($b,1)             ## then prefern matching L->R to match presumed csv ordering.
                          } keys %positions;

            my @result = ();
            {
                my $i=0;
                foreach my $k (@sortedkeys) {
                    $result[$i] = {key=>$k,start=>$positions{$k}[0],end=>$positions{$k}[1]};
                    $i++;
                }
            }
            
            
            my $unmatchedcount = 0;
            foreach my $k (@sortedkeys) {
                if ($positions{$k}[0] == $positions{$k}[1] ) {
                    $unmatchedcount++;
                };
            };
        
            my $unmatchedamount = length($ascii_row) - $ascii_row =~ tr/^//;
        
            @best_result          = @result           if $unmatchedcount  < $best_unmatchedcount || $unmatchedamount < $best_unmatchedamount; 
        
            $best_line            = $li               if $unmatchedcount  < $best_unmatchedcount || $unmatchedamount < $best_unmatchedamount; 
            $best_unmatchedcount  = $unmatchedcount   if $unmatchedcount  < $best_unmatchedcount; 
            $best_unmatchedamount = $unmatchedamount  if $unmatchedamount < $best_unmatchedamount; 
            
            @result     = @best_result;
            }
        }
    
    return \{ positions => \@best_result, best_line => $best_line, best_unmatchedcount => $best_unmatchedcount, best_unmatchedamount => $best_unmatchedamount }  ;
}

sub printDebugData {
#warn Dumper @_ ;    
    my $self                = shift or croak 'no self';
    my $asciifile           = shift || croak 'no ascii file name';
    my $datalinenumber      = shift || croak 'no data line start position give';
    my $columns             = shift || croak 'no columns given' ;

#warn Dumper $columns ;
    
    my $li=0;
    open(my $afile, "<", $asciifile)  or die "Could not open file $!";
    my $row = <$afile>;
    my $ascii_row = "";
    while (defined(my $row = <$afile> ) && ($li++ < $datalinenumber)) { }    
    while (defined(my $row = <$afile> ) && ($li++ < $datalinenumber + 20)) {
        chomp $row;
        $ascii_row = $row;
        my $output_row = "";
        my $first=1;
        foreach my $col (@$columns) {
            my $start = $col->{start};
            my $length = $col->{end} - $start;
            if (($length > 0 )) {
                $output_row .= ($first? "":"|") . substr($ascii_row,$start,$length);
                $first =0;
            }
        }
        say $output_row;
    }
}

sub sort_values {
    
    my $values = shift || die "no values passed.";
    
    my @sorted = sort {  length($$values{$b})    <=> length($$values{$a})      ## sort descending on data length
                          || substr($a,1)       <=> substr($b,1)             ## then prefer matching L->R to match presumed csv ordering.
                          } keys %$values;
    return \@sorted;
}
sub flatten { return map { @$_} @_ } ;

sub DESTROY {}

1 ;

__DATA__


