package Padre::Plugin::Plack::Panel;
BEGIN {
  $Padre::Plugin::Plack::Panel::VERSION = '1.200';
}

# ABSTRACT: Plack control panel

use strict;
use warnings;

use Padre::Wx   ();
use Padre::Util ('_T');
use Wx          ();
use base 'Wx::Panel';
use Padre::Current;
use Padre::Logger;


sub new {
    my $class = shift;
    my $doc   = shift;
    my $self  = $class->SUPER::new( Padre::Current->main->bottom );

    $doc->plugin->build_panel( $doc, $self );

    return $self;
}


sub set_as_started {
    my $self = shift;
    $self->{start_stop}->SetLabel( _T('Stop') );
    $self->{led}->SetBitmap( $self->led('green') );
}


sub set_as_stopped {
    my $self = shift;
    $self->{start_stop}->SetLabel( _T('Start') );
    $self->{led}->SetBitmap( $self->led('red') );
}


sub output { return shift->{output} }


sub gettext_label {
    my $self = shift;

    require File::Basename;
    my $doc = $self->{doc};
    if ( my $filename = $doc && $doc->filename ) {
        return File::Basename::basename($filename);
    }
    else {
        return 'Plackup';
    }
}


sub led {
    my ( $self, $color ) = (@_);

    my @red = (
        '20 20 192 2',
        '  	c None',
        '. 	c #DE9898',
        '+ 	c #EC9D9D',
        '@ 	c #FA9C9C',
        '# 	c #FD9898',
        '$ 	c #FC8B8B',
        '% 	c #F67979',
        '& 	c #E46A6A',
        '* 	c #CD5757',
        '= 	c #C88989',
        '- 	c #F9ACAC',
        '; 	c #FFB8B8',
        '> 	c #FFBEBE',
        ', 	c #FEBDBD',
        '\' 	c #FFB5B5',
        ') 	c #FFA6A6',
        '! 	c #FE9393',
        '~ 	c #FF7D7D',
        '{ 	c #FF6868',
        '] 	c #E85151',
        '^ 	c #BB3D3D',
        '/ 	c #DE9797',
        '( 	c #FAACAC',
        '_ 	c #FFC2C2',
        ': 	c #FFD1D1',
        '< 	c #FED9D9',
        '[ 	c #FFD8D8',
        '} 	c #FFCECE',
        '| 	c #FFBDBD',
        '1 	c #FFA8A8',
        '2 	c #FF8E8E',
        '3 	c #FF7575',
        '4 	c #FF5D5D',
        '5 	c #FF4646',
        '6 	c #BD7B7B',
        '7 	c #FFA2A2',
        '8 	c #FFBCBC',
        '9 	c #FFD4D4',
        '0 	c #FFE5E5',
        'a 	c #FFEDED',
        'b 	c #FFE2E2',
        'c 	c #FFD0D0',
        'd 	c #FFB7B7',
        'e 	c #FF9C9C',
        'f 	c #FF8080',
        'g 	c #FF6666',
        'h 	c #FF4F4F',
        'i 	c #F33A3A',
        'j 	c #F28F8F',
        'k 	c #FFA9A9',
        'l 	c #FEC6C6',
        'm 	c #FFDFDF',
        'n 	c #FFF0F0',
        'o 	c #FFFAFA',
        'p 	c #FFF8F8',
        'q 	c #FFDADA',
        'r 	c #FFC0C0',
        's 	c #FFA3A3',
        't 	c #FF8787',
        'u 	c #FF6B6B',
        'v 	c #FF5252',
        'w 	c #FF3D3D',
        'x 	c #D77C7C',
        'y 	c #FD8C8C',
        'z 	c #FFAAAA',
        'A 	c #FFC7C7',
        'B 	c #FFE0E0',
        'C 	c #FFF2F2',
        'D 	c #FFFCFC',
        'E 	c #FFEFEF',
        'F 	c #FFDCDC',
        'G 	c #FFA5A5',
        'H 	c #FF8888',
        'I 	c #FF6C6C',
        'J 	c #FF5454',
        'K 	c #FF3E3E',
        'L 	c #FF2B2B',
        'M 	c #C26A6A',
        'N 	c #FFC1C1',
        'O 	c #FFD9D9',
        'P 	c #FFEAEA',
        'Q 	c #FFF3F3',
        'R 	c #FFE8E8',
        'S 	c #FFD5D5',
        'T 	c #FFA1A1',
        'U 	c #FF8585',
        'V 	c #FF6969',
        'W 	c #FF5151',
        'X 	c #A83838',
        'Y 	c #F25F5F',
        'Z 	c #FF7E7E',
        '` 	c #FF9999',
        ' .	c #FFB4B4',
        '..	c #FFCACA',
        '+.	c #FFB0B0',
        '@.	c #FF9797',
        '#.	c #FF7C7C',
        '$.	c #FF6363',
        '%.	c #FF4D4D',
        '&.	c #FF3A3A',
        '*.	c #FE2B2B',
        '=.	c #E52525',
        '-.	c #FB5A5A',
        ';.	c #FF7272',
        '>.	c #FF8A8A',
        ',.	c #FFC3C3',
        '\'.	c #FFB3B3',
        ').	c #FF9F9F',
        '!.	c #FF7070',
        '~.	c #FF5A5A',
        '{.	c #FF4747',
        '].	c #FF3535',
        '^.	c #FF2727',
        '/.	c #E32727',
        '(.	c #F14C4C',
        '_.	c #FF7777',
        ':.	c #FF8B8B',
        '<.	c #FFAFAF',
        '[.	c #FFAEAE',
        '}.	c #FFA7A7',
        '|.	c #FF9A9A',
        '1.	c #FF7676',
        '2.	c #FF6262',
        '3.	c #FF2E2E',
        '4.	c #FF2323',
        '5.	c #E22222',
        '6.	c #D24343',
        '7.	c #FF7474',
        '8.	c #FF8181',
        '9.	c #FF8C8C',
        '0.	c #FF9191',
        'a.	c #FF7373',
        'b.	c #FF5353',
        'c.	c #FF4343',
        'd.	c #FF2828',
        'e.	c #FE1E1E',
        'f.	c #E71A1A',
        'g.	c #FE5151',
        'h.	c #FF7171',
        'i.	c #FF5E5E',
        'j.	c #FF4444',
        'k.	c #FF3737',
        'l.	c #FE2222',
        'm.	c #FF1414',
        'n.	c #EF3939',
        'o.	c #FE3F3F',
        'p.	c #FF4949',
        'q.	c #FF5858',
        'r.	c #FF5B5B',
        's.	c #FF4040',
        't.	c #FF3636',
        'u.	c #FF2C2C',
        'v.	c #FF1A1A',
        'w.	c #CB2727',
        'x.	c #C73636',
        'y.	c #FF2F2F',
        'z.	c #FE3838',
        'A.	c #FF4242',
        'B.	c #FF4545',
        'C.	c #FF3F3F',
        'D.	c #FF3939',
        'E.	c #FF3232',
        'F.	c #FF2929',
        'G.	c #FF1C1C',
        'H.	c #FF1010',
        'I.	c #C53535',
        'J.	c #FF2D2D',
        'K.	c #FF3131',
        'L.	c #FF3333',
        'M.	c #FF2A2A',
        'N.	c #FF2525',
        'O.	c #FE1F1F',
        'P.	c #FE1A1A',
        'Q.	c #FF1111',
        'R.	c #B03737',
        'S.	c #FF1E1E',
        'T.	c #FE2424',
        'U.	c #FF2424',
        'V.	c #FF2121',
        'W.	c #FF1717',
        'X.	c #FF0808',
        'Y.	c #DE2424',
        'Z.	c #F21F1F',
        '`.	c #FF1818',
        ' +	c #FF1616',
        '.+	c #FF1313',
        '++	c #EE1A1A',
        '@+	c #D22222',
        '#+	c #983C3C',
        '$+	c #963E3E',
        '%+	c #963D3D',
        '&+	c #983A3A',
        '                                        ',
        '                                        ',
        '            . + @ # $ % & *             ',
        '        = - ; > , \' ) ! ~ { ] ^         ',
        '      / ( _ : < [ } | 1 2 3 4 5 ^       ',
        '    6 7 8 9 0 a a b c d e f g h i ^     ',
        '    j k l m n o p a q r s t u v w ^     ',
        '  x y z A B C D o E F _ G H I J K L ^   ',
        '  M H G N O P Q C R S | T U V W w L X   ',
        '  Y Z `  ...q b b [ A +.@.#.$.%.&.*.=.  ',
        '  -.;.>.T \' ,.....N \'.).H !.~.{.].^./.  ',
        '  (.$._.:.e 1 <.[.}.|.>.1.2.h K 3.4.5.  ',
        '  6.v $.7.8.9.0.0.9.8.a.$.b.c.].d.e.f.  ',
        '  ^ c.g.4 { h.3 3 h.V i.W j.k.L l.m.^   ',
        '    n.o.p.W q.r.r.q.v p.s.t.u.4.v.w.^   ',
        '    x.y.z.K A.B.B.c.C.D.E.F.4.G.H.^     ',
        '      I.^.J.K.L.L.E.3.M.N.O.P.Q.^       ',
        '        R.S.4.T.N.U.V.S.P.W.X.^         ',
        '          ^ Y.Z.`.`. +.+++@+^           ',
        '              ^ #+$+%+&+^               ',
    );

    # I'm too lazy to create a green XPM
    my @green = ();
    foreach (@red) {
        my $color = $_;
        $color =~ s/#(\w\w)(\w\w)/#$2$1/;
        push @green, $color;
    }

    my $led = {
        red   => \@red,
        green => \@green,
    };

    return Wx::Bitmap->newFromXPM( $led->{$color} )
      if exists $led->{$color};

    return;
}


1;

__END__
=pod

=head1 NAME

Padre::Plugin::Plack::Panel - Plack control panel

=head1 VERSION

version 1.200

=head1 METHODS

=head2 new

=head2 set_as_started

=head2 set_as_stopped

=head2 output

=head2 gettext_label

=head2 led

Taken from Padre::Plugin::Catalyst

=head2 TRACE

=head1 AUTHOR

Patrick Donelan <pdonelan@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Patrick Donelan.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

