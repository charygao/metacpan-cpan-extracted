#!/usr/bin/perl -w -- 
# generated by wxGlade 0.3.5.1 on Mon Mar  7 15:28:34 2005
# To get wxPerl visit http://wxPerl.sourceforge.net/

use Wx 0.15 qw[:allclasses];


package Brain;

use POE;
use POE::Component::Client::UserAgent;
use POE::Loop::Wx;
use Wx qw(wxTheApp);

my $app;
my $counter = 0;
my %states;

sub start {
   print STDERR "in brain::start\n";

   POE::Session->create(inline_states=>\%states);
   POE::Component::Client::UserAgent->new;
   POE::Kernel->loop_run();
   POE::Kernel->run();
}

sub stop {
   POE::Kernel->stop();
   Wx::wxTheApp->ExitMainLoop();
}

$states{subscribe}=sub{
   my ($kernel, $session, $heap)=@_[KERNEL, SESSION, HEAP];
   my %opt=(@_[ARG0..$#_]);
   my $key=$opt{KEY};
   my $poe_id=$opt{OBJECT}->get_poe_id();
   $heap->{subscriptions}{$key} = {} unless 
       defined $heap->{subscriptions}{$key};
   $heap->{subscriptions}{$key}{$poe_id}=$opt{ACTION};
};

$states{unsubscribe}=sub{
   my ($kernel, $session, $heap)=@_[KERNEL, SESSION, HEAP];
   my %opt=(@_[ARG0..$#_]);
   my $object=$opt{OBJECT};
   my $key=$opt{KEY};
   my $poe_id=$object->get_poe_id();
   $heap->{subscriptions}{$key} = {} unless 
       defined $heap->{subscriptions}{$key};
   print STDERR "trying to unsubscribe $object from $key\n";
   print STDERR "current subscription:  $heap->{subscriptions}{$key}{$poe_id}\n";
   delete $heap->{subscriptions}{$key}{$poe_id};
};

$states{invoke_state}=sub{
   my ($kernel, $args ) = 
       @_[KERNEL, ARG1];
   my @args=@$args;
   my $state=shift @args;
   print STDERR "in invoke_state state.  trying to invoke $state\n";
   $kernel->yield($state, @args)
};

$states{request_data} = sub {
   my ($kernel, $session, $heap)=@_[KERNEL, SESSION, HEAP];
   my %opt=(@_[ARG0..$#_]);
   my $object=$opt{OBJECT};
   my $param=$opt{PARAMETER};
   my $key=$opt{KEY};
   my $action=$opt{ACTION};
   print STDERR "got request for $param from object $object\n";
   my $request=HTTP::Request->new(GET=>$param);
   my $response_postback=$session->postback('response',%opt);
   $kernel->post('useragent', 'request',
                 request=> $request, 
                 response=>$response_postback);
};


$states{response}= sub{
   my $heap=@_[HEAP];
   my %opt= @{$_[ARG0]};
   my ($request, $response, $entry) = @{$_[ARG1]};
   my $key=$opt{KEY};
   my $action=$opt{ACTION};
   print STDERR "got a response to call with key $key\n";
   if ($response->is_success) {
      print STDERR "it is a success\n";
      if ($action) {
         print STDERR "I have an action\n";
         &{$action}($response->content);
      }
      if (ref $heap->{subscriptions}{$key} eq 'HASH') {
         print STDERR "Checking subscriptions\n";
         my %subscriptions = %{$heap->{subscriptions}{$key}};
         while (my ($poe_id, $sub_action) = each %subscriptions) {
            print STDERR "Checking subscription $poe_id\n";
            next unless defined ( $heap->{objects}{$poe_id} ) and
                (ref $sub_action eq 'CODE');
            print STDERR "Found valid subscription for $poe_id\n";
            &$sub_action($response->content);
         }
      }
   } else {
      print STDERR "the request failed.";
   }
};

$states{register_object}=sub{
   my ($heap, $object) = 
       @_[HEAP, ARG0];
   $heap->{object_counter}=$heap->{object_counter}+1;
   # the session can keep track of the object by id
   $heap->{objects}{$heap->{object_counter}}=$object;
   $object->set_poe_id($heap->{object_counter});
};

$states{unregister_object}=sub{
   my ($heap, $object) = @_[HEAP, ARG0];
   delete $heap->{objects}{$object->get_poe_id}
};

$states{_start}=sub{
   print STDERR "start state\n";
   my ($kernel, $session, $heap ) = @_[KERNEL, SESSION, HEAP ];
   $kernel->alias_set('brain_session');
   
   $heap->{app}=DemoApp->new();
   $heap->{object_counter}=0;
   $heap->{objects}={};
   $heap->{subscriptions}={};
   
   $kernel->yield('pulse');
};

$states{pulse}=sub{
   my ($kernel, $heap ) = @_[KERNEL, HEAP ];
   print STDERR "\nThis pulse is just a demo of a recurring event,\n";
   print STDERR "to prove that POE is running.  It also gives an\n";
   print STDERR "inventory of Pobjects that brain_session knows about.\n";
   my %objects=%{$heap->{objects}};
   print STDERR "I have ".scalar(keys %objects)." objects\n";
   print STDERR "they include...\n";
   while(my ($key, $val) = each %objects) {
      print STDERR "object $key is $val\n";
   }
   
   $kernel->delay_set('pulse', 10);
   print STDERR $counter++, "\n";
   
};


1;


package Pobject;

use POE::Kernel;

sub subscribe {
   my $object=shift;
   my %opt=@_;
   $poe_kernel->post('brain_session', 'subscribe',OBJECT=>$object,
                     %opt);
}

sub unsubscribe {
   my $object=shift;
   my %opt=@_;
   $poe_kernel->post('brain_session', 'unsubscribe',OBJECT=>$object,
                     %opt);
}

sub request_data {
   my $object=shift;
   my %opt=@_;
   $poe_kernel->post('brain_session', 'request_data', OBJECT=>$object,
                     %opt);
}

sub register_object {
   my $object=shift;
   print STDERR "going to try to register object $object\n";
   $poe_kernel->post('brain_session', 'register_object', $object);
}

sub unregister_object {
   my $object=shift;
   print STDERR "going to try to unregister object $object\n";
   $poe_kernel->call('brain_session', 'unregister_object', $object);
}

sub get_poe_id {
   my $self=shift;
   return $self->{_poe_id};
}

sub set_poe_id {
   # stores poe_id in object, assuming it's a hashref.
   # this could conceiveably be stored elsewhere, e.g.
   # in a global hash which mapped an object's scalar value
   # to a poe_id.
   my $self=shift;
   my ($poe_id)=@_;
   $self->{_poe_id}=$poe_id;
}



1;


package Viewer;

use Wx qw[:everything];
use Wx qw[wxTheApp];
use Wx::Event qw(EVT_BUTTON EVT_CLOSE);
use base qw(Wx::Frame Pobject);

sub new {
	my( $self, $parent, $id, $title, $pos, $size, $style, $name ) = @_;
	$parent = undef              unless defined $parent;
	$id     = -1                 unless defined $id;
	$title  = ""                 unless defined $title;
	$pos    = wxDefaultPosition  unless defined $pos;
	$size   = wxDefaultSize      unless defined $size;
	$name   = ""                 unless defined $name;

# begin wxGlade: Viewer::new

	$style = wxDEFAULT_FRAME_STYLE 
		unless defined $style;

	$self = $self->SUPER::new( $parent, $id, $title, $pos, $size, $style, $name );
	$self->{panel_1} = Wx::Panel->new($self, -1, wxDefaultPosition, wxDefaultSize, );
	$self->{sizer_2_staticbox} = Wx::StaticBox->new($self->{panel_1}, -1, "Neat Stuff" );
	$self->{results} = Wx::TextCtrl->new($self->{panel_1}, -1, "", wxDefaultPosition, wxDefaultSize, wxTE_MULTILINE);
	$self->{label_1} = Wx::StaticText->new($self->{panel_1}, -1, "URL", wxDefaultPosition, wxDefaultSize, );
	$self->{parameter} = Wx::TextCtrl->new($self->{panel_1}, -1, "http://www.google.com/", wxDefaultPosition, wxDefaultSize, );
	$self->{request} = Wx::Button->new($self->{panel_1}, -1, "request data with key");
	$self->{subscription_key} = Wx::TextCtrl->new($self->{panel_1}, -1, "subscription_key", wxDefaultPosition, wxDefaultSize, );
	$self->{spawn} = Wx::Button->new($self->{panel_1}, -1, "spawn frame");

	$self->__set_properties();
	$self->__do_layout();

# end wxGlade

    $self->{parameter}->SetValue("http://www.google.com");

    my $response_sub = sub {
       my $data = shift;
       $self->{results}->SetValue($data);
    };

    my $request = sub {
       my $parameter=$self->{parameter}->GetValue();
       my $key=$self->{subscription_key}->GetValue();
       if ($self->{current_key}) {
          $self->unsubscribe(KEY=>$self->{current_key});
       }
       $self->{current_key}=$key;
       $self->subscribe(KEY=>$key,
                        ACTION=>$response_sub);
       $self->request_data(PARAMETER=>$parameter,
                           KEY=>$key,
                        );
    };

    my $spawn = sub {
       my $viewerframe=Viewer->new();
       Wx::wxTheApp->SetTopWindow($viewerframe);
       $viewerframe->Show(1);
    };


    EVT_BUTTON($self, $self->{spawn}, $spawn);
    EVT_BUTTON($self, $self->{request}, $request);
    $self->register_object();
    EVT_CLOSE($self, sub {$self->unregister_object();
                          $self->Destroy();});
	return $self;
}


sub __set_properties {
	my $self = shift;

# begin wxGlade: Viewer::__set_properties

	$self->SetTitle("frame_1");
	$self->{results}->SetSize(473, 86);

# end wxGlade
}

sub __do_layout {
	my $self = shift;

# begin wxGlade: Viewer::__do_layout

	$self->{sizer_1} = Wx::BoxSizer->new(wxVERTICAL);
	$self->{sizer_2}= Wx::StaticBoxSizer->new($self->{sizer_2_staticbox}, wxVERTICAL);
	$self->{sizer_2}->Add($self->{results}, 0, wxEXPAND|wxFIXED_MINSIZE, 0);
	$self->{sizer_2}->Add($self->{label_1}, 0, wxFIXED_MINSIZE, 0);
	$self->{sizer_2}->Add($self->{parameter}, 0, wxEXPAND|wxFIXED_MINSIZE, 0);
	$self->{sizer_2}->Add($self->{request}, 0, wxEXPAND|wxALIGN_CENTER_HORIZONTAL|wxFIXED_MINSIZE, 0);
	$self->{sizer_2}->Add($self->{subscription_key}, 0, wxEXPAND|wxFIXED_MINSIZE, 0);
	$self->{sizer_2}->Add($self->{spawn}, 0, wxALIGN_CENTER_HORIZONTAL|wxFIXED_MINSIZE, 0);
	$self->{panel_1}->SetAutoLayout(1);
	$self->{panel_1}->SetSizer($self->{sizer_2});
	$self->{sizer_2}->Fit($self->{panel_1});
	$self->{sizer_2}->SetSizeHints($self->{panel_1});
	$self->{sizer_1}->Add($self->{panel_1}, 1, wxEXPAND, 0);
	$self->SetAutoLayout(1);
	$self->SetSizer($self->{sizer_1});
	$self->{sizer_1}->Fit($self);
	$self->{sizer_1}->SetSizeHints($self);
	$self->Layout();

# end wxGlade
}

# end of class Viewer

1;

package DemoApp;

use base qw(Wx::App);
use Wx::Event qw(EVT_CLOSE);

sub OnInit {
   my( $self ) = shift;

   Wx::InitAllImageHandlers();
   
   my $firstframe=Viewer->new();
   $firstframe->SetTitle("Main Frame: Close Me To Quit App");
   my $closeapp = sub {
      print STDERR "in close subroutine.  Trying to stop.\n";
      Brain::stop();
      $firstframe->Destroy();
   };
   EVT_CLOSE($firstframe, $closeapp);
   
   $self->SetTopWindow($firstframe);
   $firstframe->Show(1);

	return 1;
}

1;



Brain::start;
