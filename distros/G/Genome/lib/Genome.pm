package Genome;

use warnings;
use strict;

our $VERSION = '0.06'; # Genome $VERSION

# software infrastructure
use UR;

# local configuration
use Genome::Site;

# environmental configuration
$ENV{GENOME_DB} ||= '/var/lib/genome/db';
$ENV{GENOME_SW} ||= '/var/lib/genome/sw';

# if the search engine is installed, configure its hooks
eval {
    local $SIG{__WARN__};
    local $SIG{__DIE__};
    require Genome::Search;
};

# modules 
use File::Temp;
use IO::String;

# account for a perl bug in pre-5.10 by applying a runtime patch to Carp::Heavy
use Carp;
use Carp::Heavy;

if ($] < 5.01) {
    no warnings;
    *Carp::caller_info = sub {
        package 
            Carp;
        our $MaxArgNums;
        my $i = shift(@_) + 1;
        package DB;
        my %call_info;
        @call_info{
            qw(pack file line sub has_args wantarray evaltext is_require)
        } = caller($i);

        unless (defined $call_info{pack}) {
            return ();
        }

        my $sub_name = Carp::get_subname(\%call_info);
        if ($call_info{has_args}) {
            # SEE IF WE CAN GET AROUND THE BIZARRE ARRAY COPY ERROR...
            my @args = ();
            if ($MaxArgNums and @args > $MaxArgNums) { # More than we want to show?
                $#args = $MaxArgNums;
                push @args, '...';
            }
            # Push the args onto the subroutine
            $sub_name .= '(' . join (', ', @args) . ')';
        }
        $call_info{sub_name} = $sub_name;
        return wantarray() ? %call_info : \%call_info;
    };
    use warnings;
}


# this ensures that the search system is updated when certain classes are updated 
# the search system is optional so it skips this if usage above fails
if ($INC{"Genome/Search.pm"}) {
    Genome::Search->register_callbacks('UR::Object');
}

# DB::single is set to this value in many places, creating a source-embedded break-point
# set it to zero in the debugger to turn off the constant stopping...
$DB::stopper = 1;

# the standard namespace declaration for a UR namespace
UR::Object::Type->define(
    class_name => 'Genome',
    is => ['UR::Namespace'],
    english_name => 'genome',
);

# Genome supports several environment variables, found under Genome/Env
# Any GENOME_* variable which is set but does NOT corresponde to a module found will cause an exit
# (a hedge against typos such as GENOME_NNNNNO_REQUIRE_USER_VERIFY=1 leading to unexpected behavior)
for my $e (keys %ENV) {
    next unless ($e =~ /^GENOME_/);
    eval "use Genome::Env::$e";
    if ($@) {
        my $path = __FILE__;
        $path =~ s/.pm$//;
        my @files = glob($path . '/Env/*');
        my @vars = map { /Genome\/Env\/(.*).pm/; $1 } @files; 
        print STDERR "Environment variable $e set to $ENV{$e} but there were errors using Genome::Env::$e:\n"
        . "Available variables:\n\t" 
        . join("\n\t",@vars)
        . "\n";
        exit 1;
    }
}

1;

=pod

=head1 NAME

Genome - pipelines, tools, and data managment for genomics

=head1 SYNOPSIS

 use Genome;

 # modules in the Genome namespace will now dynamically load

 @i = Genome::InstrumentData::Illumina->get(...);
 $m = Genome::Model::SomaticVariation->create(...);

=head1 DESCRIPTION

This is the base namespace module for the Genome software tree.

That tree has several primary components:

 Genome::Model:         a data modeling pipeline management system for genomics 

 Genome::Model::Tools   a tree of >1000 tools and tool wrappers for genomics

 Genome::*              a variety of sample tracking classes with an RDBMS back-end

Only the tools system is currently released.  

See B<genome> for a complete inventory of all tool packages, and for command-line access to
those tools.

=head1 AUTHORS

 This software is developed by the analysis and engineering teams at 
 The Genome Center at Washington Univiersity in St. Louis, with funding from 
 the National Human Genome Research Institute.  Richard K. Wilson, P.I.

 Scott Abbott
 Travis Abbott
 Edward Belter
 Paul Bender
 Anthony Brummett
 Todd C. Carter
 Matthew Callaway
 C.J. Carey
 Lynn Carmichael
 Ken Chen
 Lei Chen
 Eric Clark
 Kevin Crouse
 Indraniel Das
 Nathan Dees
 Eric deMello
 Brian Derickson
 Alice Diec
 David Dooling
 Feiyu Du
 Adam Dukes
 James Eldred
 Xian Fan
 Ian Ferguson
 Chris Harris
 Amy Hawkins
 Todd Hepler
 Xin Hong
 Shunfang Hou
 Jasreet Hundal
 Erik Hvatum
 Mark Johnson
 Krisha-Latha Kanchi
 Cyriac Kandoth
 Phil Kimmey
 Michael Kiwala
 Daniel Koboldt
 Karthik Kota
 Kim Kyung
 David Larson
 Sai Lek
 Shawn Leonard
 Shin Leong
 Ling Lin
 Justin Lolofie
 Robert Long
 Charles Lu
 John Martin
 Josh McMichael
 Rick Meyer
 Thomas Mooney
 William Nash
 Nathan Nutter
 Ben Oberkfell
 John Osborne
 Josh Peck
 Jerome Peirick
 Craig Pohl
 Ryan Richt
 Noorus Sahar Abubucker
 Gabriel Sanderson
 William Schierding
 Jon Schindler
 William Schroeder
 Christopher Schuster
 Xiaoqi Shi
 Scott Smith
 Sasi Suruliraj
 Kenneth Swanson
 Jason Walker
 John Wallis
 Jim Weible
 Mike Wendl
 Todd Wylie

=head1 LICENSE

Copyright (C) 2007-2011 Washington University in St. Louis.

It is released under the Lesser GNU Public License (LGPL) version 3.  See the 
associated LICENSE file in this distribution.

=head1 BUGS

For defects with any software in the genome namespace,
contact genome-dev ~at~ genome.wustl.edu.

=cut

