package Paws::MediaConvert::FileSourceSettings;
  use Moose;
  has Convert608To708 => (is => 'ro', isa => 'Str', request_name => 'convert608To708', traits => ['NameInRequest']);
  has SourceFile => (is => 'ro', isa => 'Str', request_name => 'sourceFile', traits => ['NameInRequest']);
  has TimeDelta => (is => 'ro', isa => 'Int', request_name => 'timeDelta', traits => ['NameInRequest']);
1;

### main pod documentation begin ###

=head1 NAME

Paws::MediaConvert::FileSourceSettings

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::MediaConvert::FileSourceSettings object:

  $service_obj->Method(Att1 => { Convert608To708 => $value, ..., TimeDelta => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::MediaConvert::FileSourceSettings object:

  $result = $service_obj->Method(...);
  $result->Att1->Convert608To708

=head1 DESCRIPTION

If your input captions are SCC, SMI, SRT, STL, TTML, or IMSC 1.1 in an
xml file, specify the URI of the input caption source file. If your
caption source is IMSC in an IMF package, use TrackSourceSettings
instead of FileSoureSettings.

=head1 ATTRIBUTES


=head2 Convert608To708 => Str

  Specify whether this set of input captions appears in your outputs in
both 608 and 708 format. If you choose Upconvert (UPCONVERT),
MediaConvert includes the captions data in two ways: it passes the 608
data through using the 608 compatibility bytes fields of the 708
wrapper, and it also translates the 608 data into 708.


=head2 SourceFile => Str

  External caption file used for loading captions. Accepted file
extensions are 'scc', 'ttml', 'dfxp', 'stl', 'srt', 'xml', and 'smi'.


=head2 TimeDelta => Int

  Specifies a time delta in seconds to offset the captions from the
source file.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::MediaConvert>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut

