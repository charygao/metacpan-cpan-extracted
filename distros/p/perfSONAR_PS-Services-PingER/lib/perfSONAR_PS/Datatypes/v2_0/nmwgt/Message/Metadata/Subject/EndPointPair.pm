package  perfSONAR_PS::Datatypes::v2_0::nmwgt::Message::Metadata::Subject::EndPointPair;
use strict;
use warnings;
use English qw( -no_match_vars);
use version; our $VERSION = qv('v2.0');
=head1 NAME

 perfSONAR_PS::Datatypes::v2_0::nmwgt::Message::Metadata::Subject::EndPointPair  - A base class, implements  'endPointPair'  element from the perfSONAR_PS RelaxNG schema
  
=head1 DESCRIPTION

   Object representation of the endPointPair element.
   Object fields are:
    Object reference:   src => type HASH,
    Object reference:   dst => type HASH,
   
   The constructor accepts only single parameter, it could be a hashref to parameters hash  or DOM with  'endPointPair' element 
    
    
=head1 SYNOPSIS

              use perfSONAR_PS::Datatypes::v2_0::nmwgt::Message::Metadata::Subject::EndPointPair;
          
          my $el =  perfSONAR_PS::Datatypes::v2_0::nmwgt::Message::Metadata::Subject::EndPointPair->new($DOM_Obj);
 
=head1   METHODS

=cut
 

use XML::LibXML;
use Scalar::Util qw(blessed);
use Log::Log4perl qw(get_logger); 
use perfSONAR_PS::Datatypes::Element qw(getElement);
use perfSONAR_PS::Datatypes::Namespace;
use perfSONAR_PS::Datatypes::NSMap;
use Readonly;
use perfSONAR_PS::Datatypes::v2_0::nmwgt::Message::Metadata::Subject::EndPointPair::Src;
use perfSONAR_PS::Datatypes::v2_0::nmwgt::Message::Metadata::Subject::EndPointPair::Dst;
use Class::Accessor::Fast;
use Class::Fields;
use base qw(Class::Accessor::Fast Class::Fields);
use fields qw(nsmap idmap refidmap  src dst  );

perfSONAR_PS::Datatypes::v2_0::nmwgt::Message::Metadata::Subject::EndPointPair->mk_accessors(perfSONAR_PS::Datatypes::v2_0::nmwgt::Message::Metadata::Subject::EndPointPair->show_fields('Public'));
  
=head2 new( )
   
      creates   object, accepts DOM with  element tree or hashref to the list of
      keyd parameters
         src => HASH,
         dst => HASH,

=cut
Readonly::Scalar our $COLUMN_SEPARATOR => ':';
Readonly::Scalar our $CLASSPATH =>  'perfSONAR_PS::Datatypes::v2_0::nmwgt::Message::Metadata::Subject::EndPointPair';
Readonly::Scalar our $LOCALNAME => 'endPointPair';
            
sub new { 
    my $that = shift;
    my $param = shift;
 
    my $logger  = get_logger( $CLASSPATH ); 
    my $class = ref($that) || $that;
    my $self =  fields::new($class );
    $self->nsmap(perfSONAR_PS::Datatypes::NSMap->new()); 
    $self->nsmap->mapname( $LOCALNAME, 'nmwgt');
    
    if($param) {
        if(blessed $param && $param->can('getName')  && ($param->getName =~ m/$LOCALNAME$/xm) ) {
            return  $self->fromDOM($param);  
          
        } elsif(ref($param) ne 'HASH')   {
            $logger->error("ONLY hash ref accepted as param " . $param ); 
            return;
        }
    if($param->{xml}) {
         my $parser = XML::LibXML->new();
             my $dom;
             eval {
                  my $doc = $parser->parse_string( $param->{xml});
          $dom = $doc->getDocumentElement;
             };
             if($EVAL_ERROR) {
                 $logger->error(" Failed to parse XML :" . $param->{xml} . " \n ERROR: \n" . $EVAL_ERROR);
                return;
             }
             return  $self->fromDOM( $dom );  
    } 
        $logger->debug("Parsing parameters: " . (join " : ", keys %{$param}));
     
        no strict 'refs';
        foreach my $param_key (keys %{$param}) {
            $self->$param_key( $param->{$param_key} ) if $self->can($param_key);
        }  
        use strict;     
   
       $logger->debug("Done ");     
    }  
    return $self;
}

 
sub DESTROY {
    my $self = shift;
    $self->SUPER::DESTROY  if $self->can("SUPER::DESTROY");
    return;
}
 
=head2   getDOM ($) 
      
       accept parent DOM
       return endPointPair object DOM, generated from object contents 
  
=cut 
 
sub getDOM {
    my $self = shift;
    my $parent = shift; 
    my $logger  = get_logger( $CLASSPATH ); 
    my $endPointPair = getElement({name =>   $LOCALNAME, parent => $parent , ns => [$self->nsmap->mapname( $LOCALNAME )],
                             attributes => [

                                           ],
                         }); 
   if($self->src  && blessed $self->src  && $self->src->can("getDOM")) {
        my  $srcDOM = $self->src->getDOM($endPointPair);
       $srcDOM?$endPointPair->appendChild($srcDOM):$logger->error("Failed to append  src  with value: " .  $srcDOM->toString ); 
   }
   if($self->dst  && blessed $self->dst  && $self->dst->can("getDOM")) {
        my  $dstDOM = $self->dst->getDOM($endPointPair);
       $dstDOM?$endPointPair->appendChild($dstDOM):$logger->error("Failed to append  dst  with value: " .  $dstDOM->toString ); 
   }
    return $endPointPair;
}

=head2  querySQL ()

      depending on config  it will return some hash ref  to the initialized fields
    for example querySQL ()
    accepts one optional prameter - query hashref
    will return:
    { ip_name_src =>  'hepnrc1.hep.net' },}
    
=cut

sub  querySQL {
    my $self = shift;
    my $query = shift; ### undef at first and then will be hash ref
    my $logger  = get_logger( $CLASSPATH );
     
    my %defined_table = (  'metaData' => [  'ip_name_src',   'ip_name_dst',  ],   'host' => [  'ip_name',   'ip_number',  ],  );
    $query->{metaData}{ip_name_src}= [    'perfSONAR_PS::Datatypes::v2_0::nmwgt::Message::Metadata::Subject::EndPointPair::Src',    ];
    $query->{host}{ip_name}= [    'perfSONAR_PS::Datatypes::v2_0::nmwgt::Message::Metadata::Subject::EndPointPair::Src',    ];
    $query->{host}{ip_number}= [    'perfSONAR_PS::Datatypes::v2_0::nmwgt::Message::Metadata::Subject::EndPointPair::Src',    ];
    $query->{metaData}{ip_name_dst}= [    'perfSONAR_PS::Datatypes::v2_0::nmwgt::Message::Metadata::Subject::EndPointPair::Dst',    ];
    $query->{host}{ip_name}= [    'perfSONAR_PS::Datatypes::v2_0::nmwgt::Message::Metadata::Subject::EndPointPair::Dst',    ];
    $query->{host}{ip_number}= [    'perfSONAR_PS::Datatypes::v2_0::nmwgt::Message::Metadata::Subject::EndPointPair::Dst',    ];
    foreach my $subname (qw/src dst/) {
        if($self->{$subname} && (ref($self->{$subname}) eq 'ARRAY' ||  blessed $self->{$subname}))   {
            my @array = ref($self->{$subname}) eq 'ARRAY'?@{$self->{$subname}}:($self->{$subname});
        foreach my $el  (@array) {
            if(blessed  $el  &&  $el->can("querySQL"))  {
                    $el->querySQL($query);         
                    $logger->debug("Quering endPointPair  for subclass $subname");
            } else {
                $logger->error(" Failed for endPointPair Unblessed member or querySQL is not implemented by subclass $subname");
            }
        }  
        }
    }    
    return $query;
}

=head2 merge

      merge with another endPointPair ( append + overwrite if exists )
      we can do it differently
      method #1:
         convert to dom both objects and then get resulted object from combined dom 
      method #2 default:
         through the introspection of the object

=cut


sub merge {
    my $self = shift;
    my $new_endPointPair = shift;
    my $logger  = get_logger( $CLASSPATH );  
    unless($new_endPointPair && blessed $new_endPointPair && $new_endPointPair->can("getDOM")) {
        $logger->error(" Please supply defined object of endPointPair  ");
        return;
    } 
    ### for each field ( element or attribute )
    ### merge elements, add if its arrayref and overwrite attribtues for the same elements
    ### merge only if namespace is the same  
    foreach my $member_name ($new_endPointPair->show_fields) {
        ### double check if   objects are the same
    if($self->can($member_name)) {
        my $current_member  = $self->{$member_name};
        my $new_member      =  $new_endPointPair->{$member_name};
        ###  check if both objects are defined
        if($current_member && $new_member) {
            ### if  one of them array then just add another one
            if(blessed $current_member && blessed $new_member  && $current_member->can("merge") 
               && ( $current_member->nsmap->mapname($member_name) 
                eq  $new_member->nsmap->mapname($member_name) ) ) {
               $current_member->merge($new_member);
            $self->{$member_name} =  $current_member;
            $logger->debug("  Merged $member_name , got" . $current_member->asString);
            ### if its array then just push
            } elsif(ref($current_member) eq 'ARRAY'){
                 
           $self->{$member_name}=[$current_member, $new_member];
              
            $logger->debug("  Pushed extra to $member_name ");
            }  
        ## thats it, dont merge if new member is just a scalar
        } elsif( $new_member) {
           $self->{$member_name} = $new_member;
        }   
    } else {
        $logger->error(" This field $member_name,  found in supplied  endPointPair  is not supported by endPointPair class");
        return;
        }
    }
    return $self;
} 
 
=head2  buildIdMap()

    if any of subelements has id then get a map of it in form of
    hashref to { element}{id} = index in array and store in the idmap field

=cut

sub  buildIdMap {
    my $self = shift;
    my $map = (); 
    my $logger  = get_logger( $CLASSPATH );
    foreach my $field (qw/src dst/) {
        my @array = ref($self->{$field}) eq 'ARRAY'?@{$self->{$field}}:($self->{$field});
        my $i = 0;
        foreach my $el ( @array)  {
            if($el && blessed $el && $el->can("id") &&  $el->id)  { 
                $map->{$field}{$el->id} = $i;   
            }
            $i++;
        }
    }
    return $self->idmap($map);
}
=head2 buildrefIdMap ()

    if any of subelements has  metadataIdRef  then get a map of it in form of
    hashref to { element}{ metadataIdRef } = index in array and store in the idmap field

=cut

sub  buildRefIdMap {
    my $self = shift;
    my %map = (); 
    my $logger  = get_logger( $CLASSPATH );
    foreach my $field (qw/src dst/) {
        my @array = ref($self->{$field}) eq 'ARRAY'?@{$self->{$field}}:($self->{$field});
        my $i = 0;
        foreach my $el ( @array)  {
            if($el && blessed $el  && $el->can("metadataIdRef") &&  $el->metadataIdRef )  { 
                $map{$field}{$el->metadataIdRef} = $i;   
            }
            $i++;
        }
    }
    return $self->refidmap(\%map);
}
=head2  asString()

   shortcut to get DOM and convert into the XML string
   returns XML string  representation of the  endPointPair object

=cut

sub asString {
    my $self = shift;
    my $dom = $self->getDOM();
    return $dom->toString('1');
}

=head2 registerNamespaces ()

   will parse all subelements and register all namepspaces within the endPointPair namespace

=cut

sub registerNamespaces {
    my $self = shift;
    my $logger  = get_logger( $CLASSPATH );
    my $nsids = shift;
    my $local_nss = {reverse %{$self->nsmap->mapname}};
    unless($nsids) {
        $nsids =  $local_nss;
    }  else {
        %{$nsids} = ( %{$local_nss},  %{$nsids});
    }
    foreach my $field (qw/src dst/) {
        my @array = ref($self->{$field}) eq 'ARRAY'?@{$self->{$field}}:($self->{$field});
        foreach my $el ( @array)  {
            if(blessed $el &&   $el->can("registerNamespaces") )  { 
                my $fromNSmap =  $el->registerNamespaces($nsids); 
                my %ns_idmap =   %{$fromNSmap};  
                foreach my $ns ( keys %ns_idmap)  {
                      $nsids->{$ns}++
                }
            }
        }
    }
    return     $nsids;
}
=head2  fromDOM ($)
   
   accepts parent XML DOM   element   tree as parameter 
   returns endPointPair  object

=cut

sub fromDOM {
    my $self = shift;
    my $logger  = get_logger( $CLASSPATH ); 
    my $dom = shift;
     
    foreach my $childnode ($dom->childNodes) { 
        my  $getname  = $childnode->getName;
        my ($nsid, $tagname) = split $COLUMN_SEPARATOR,  $getname; 
        unless($nsid && $tagname) {   
            next;
        }
        if ($tagname eq  'src' && $nsid eq 'nmwgt' && $self->can($tagname)) { 
           my $element = undef;
           eval {
               $element = perfSONAR_PS::Datatypes::v2_0::nmwgt::Message::Metadata::Subject::EndPointPair::Src->new($childnode) 
           };
           if($EVAL_ERROR || !($element  && blessed $element)) {
               $logger->error(" Failed to load and add  Src : " . $dom->toString . " error: " . $EVAL_ERROR);
               return;
           }
           $self->src($element); ### add another src  
        }  elsif ($tagname eq  'dst' && $nsid eq 'nmwgt' && $self->can($tagname)) { 
           my $element = undef;
           eval {
               $element = perfSONAR_PS::Datatypes::v2_0::nmwgt::Message::Metadata::Subject::EndPointPair::Dst->new($childnode) 
           };
           if($EVAL_ERROR || !($element  && blessed $element)) {
               $logger->error(" Failed to load and add  Dst : " . $dom->toString . " error: " . $EVAL_ERROR);
               return;
           }
           $self->dst($element); ### add another dst  
        }      ###  $dom->removeChild($childnode); ##remove processed element from the current DOM so subclass can deal with remaining elements
    }
  $self->buildIdMap;
 $self->buildRefIdMap;
 $self->registerNamespaces;
  
 return $self;
}

 
 
=head1 AUTHORS

   Maxim Grigoriev (FNAL)  2007-2008, maxim@fnal.gov

=cut 

1;
 
