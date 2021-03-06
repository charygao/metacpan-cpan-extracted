package DNS::Zone::PowerDNS::To::BIND;

our $DATE = '2019-09-17'; # DATE
our $VERSION = '0.008'; # VERSION

use 5.010001;
use strict;
use warnings;
use Log::ger;

use DNS::Zone::Struct::Common;
use DNS::Zone::Struct::Common::BIND;

use Exporter 'import';
our @EXPORT_OK = qw(
                       gen_bind_zone_from_powerdns_db
               );

our %SPEC;

# XXX
sub _encode_txt {
    my $text = shift;
    qq("$text");
}

$SPEC{gen_bind_zone_from_powerdns_db} = {
    v => 1.1,
    summary => 'Generate BIND zone configuration from '.
        'information in PowerDNS database',
    args => {
        dbh => {
            schema => 'obj*',
        },
        db_dsn => {
            schema => 'str*',
            tags => ['category:database'],
            default => 'DBI:mysql:database=pdns',
        },
        db_user => {
            schema => 'str*',
            tags => ['category:database'],
        },
        db_password => {
            schema => 'str*',
            tags => ['category:database'],
        },
        domain => {
            schema => ['net::hostname*'], # XXX domainname
            pos => 0,
        },
        domain_id => {
            schema => ['uint*'], # XXX domainname
        },
        %DNS::Zone::Struct::Common::arg_workaround_convert_underscore_in_host,
        %DNS::Zone::Struct::Common::BIND::arg_workaround_root_cname,
        %DNS::Zone::Struct::Common::BIND::arg_workaround_cname_and_other_data,
        %DNS::Zone::Struct::Common::BIND::arg_workaround_cname_and_other_data,
        default_ns => {
            schema => ['array*', of=>'net::hostname*'],
        },
    },
    args_rels => {
        req_one => ['domain', 'domain_id'],
    },
    result_naked => 1,
};
sub gen_bind_zone_from_powerdns_db {
    my %args = @_;
    my $domain = $args{domain};

    my $dbh;
    if ($args{dbh}) {
        $dbh = $args{dbh};
    } else {
        require DBIx::Connect::Any;
        $dbh = DBIx::Connect::Any->connect(
            $args{db_dsn}, $args{db_user}, $args{db_password}, {RaiseError=>1});
    }

    my $sth_sel_domain;
    if (defined $args{domain_id}) {
        $sth_sel_domain = $dbh->prepare("SELECT * FROM domains WHERE id=?");
        $sth_sel_domain->execute($args{domain_id});
    } else {
        $sth_sel_domain = $dbh->prepare("SELECT * FROM domains WHERE name=?");
        $sth_sel_domain->execute($domain);
    }
    my $domain_rec = $sth_sel_domain->fetchrow_hashref
        or die "No such domain in the database: '$domain'";
    $domain //= $domain_rec->{name};

    my @res;
    push @res, '; generated from PowerDNS database on '.scalar(gmtime)." UTC\n";

    my $soa_rec;
  GET_SOA_RECORD: {
        my $sth_sel_soa_record = $dbh->prepare("SELECT * FROM records WHERE domain_id=? AND disabled=0 AND type='SOA'");
        $sth_sel_soa_record->execute($domain_rec->{id});
        $soa_rec = $sth_sel_soa_record->fetchrow_hashref
            or die "Domain '$domain' does not have SOA record";
        push @res, '$TTL ', $soa_rec->{ttl}, "\n";
        $soa_rec->{content} =~ s/(\S+)(\s+)(\S+)(\s+)(.+)/$1.$2$3.$4($5)/;
        push @res, "\@ IN $soa_rec->{ttl} SOA $soa_rec->{content};\n";
    }

    my @recs;
  GET_RECORDS:
    {
        my $sth_sel_record = $dbh->prepare("SELECT * FROM records WHERE domain_id=? AND disabled=0 ORDER BY id");
        $sth_sel_record->execute($domain_rec->{id});
        while (my $rec = $sth_sel_record->fetchrow_hashref) {
            $rec->{name} =~ s/\.?\Q$domain\E\z//;
            push @recs, $rec;
        }
    }

  WORKAROUND_CONVERT_UNDERSCORE_IN_HOST:
    {
        last unless $args{workaround_convert_underscore_in_host} // 1;
        DNS::Zone::Struct::Common::_workaround_convert_underscore_in_host(\@recs);
    }

  WORKAROUND_NO_NS:
    {
        last unless $args{workaround_no_ns} // 1;
        DNS::Zone::Struct::Common::BIND::_workaround_no_ns(\@recs, $args{default_ns});
    }

  WORKAROUND_ROOT_CNAME:
    {
        last unless $args{workaround_root_cname} // 1;
        DNS::Zone::Struct::Common::BIND::_workaround_root_cname(\@recs);
    }

  WORKAROUND_CNAME_AND_OTHER_DATA:
    {
        last unless $args{workaround_cname_and_other_data} // 1;
        DNS::Zone::Struct::Common::BIND::_workaround_cname_and_other_data(\@recs);
    }

  SORT_RECORDS:
    {
        DNS::Zone::Struct::Common::BIND::_sort_records(\@recs);
    }

    for my $rec (@recs) {
        my $type = $rec->{type};
        next if $type eq 'SOA';
        my $name = $rec->{name};
        push @res, "$name ", ($rec->{ttl} ? "$rec->{ttl} ":""), "IN ";
        if ($type eq 'A') {
            push @res, "A $rec->{content}\n";
        } elsif ($type eq 'CNAME') {
            push @res, "CNAME $rec->{content}.\n";
        } elsif ($type eq 'MX') {
            push @res, "MX $rec->{prio} $rec->{content}.\n";
        } elsif ($type eq 'NS') {
            push @res, "NS $rec->{content}.\n";
        } elsif ($type eq 'SSHFP') {
            push @res, "SSHFP $rec->{content}\n";
        } elsif ($type eq 'SRV') {
            push @res, "SRV $rec->{prio} $rec->{content}\n";
        } elsif ($type eq 'TXT') {
            push @res, "TXT ", _encode_txt($rec->{content}), "\n";
        } else {
            die "Can't dump record with type $type";
        }
    }

    join "", @res;
}

1;
# ABSTRACT: Generate BIND zone configuration from information in PowerDNS database

__END__

=pod

=encoding UTF-8

=head1 NAME

DNS::Zone::PowerDNS::To::BIND - Generate BIND zone configuration from information in PowerDNS database

=head1 VERSION

This document describes version 0.008 of DNS::Zone::PowerDNS::To::BIND (from Perl distribution DNS-Zone-PowerDNS-To-BIND), released on 2019-09-17.

=head1 SYNOPSIS

 use DNS::Zone::PowerDNS::To::BIND qw(gen_bind_zone_from_powerdns_db);

 say gen_bind_zone_from_powerdns_db(
     db_dsn => 'dbi:mysql:database=pdns',
     domain => 'example.com',
 );

will output something like:

 $TTL 300
 @ IN 300 SOA ns1.example.com. hostmaster.example.org. (
   2019072401 ;serial
   7200 ;refresh
   1800 ;retry
   12009600 ;expire
   300 ;ttl
   )
  IN NS ns1.example.com.
  IN NS ns2.example.com.
  IN A 1.2.3.4
 www IN CNAME @

=head1 FUNCTIONS


=head2 gen_bind_zone_from_powerdns_db

Usage:

 gen_bind_zone_from_powerdns_db(%args) -> any

Generate BIND zone configuration from information in PowerDNS database.

This function is not exported by default, but exportable.

Arguments ('*' denotes required arguments):

=over 4

=item * B<db_dsn> => I<str> (default: "DBI:mysql:database=pdns")

=item * B<db_password> => I<str>

=item * B<db_user> => I<str>

=item * B<dbh> => I<obj>

=item * B<default_ns> => I<array[net::hostname]>

=item * B<domain> => I<net::hostname>

=item * B<domain_id> => I<uint>

=item * B<workaround_cname_and_other_data> => I<bool> (default: 1)

Whether to avoid having CNAME record for a name as well as other record types.

This is a workaround for a common misconfiguration. Bind will reject the whole
zone if there is CNAME record for a name (e.g. 'www') as well as other record
types (e.g. 'A' or 'TXT'). The workaround is to skip those A/TXT records and
only keep the CNAME record.

=item * B<workaround_root_cname> => I<bool> (default: 1)

Whether to avoid having CNAME record for a name as well as other record types.

CNAME on a root node (host='') does not make sense, so the workaround is to
ignore the root CNAME.

=item * B<workaround_underscore_in_host> => I<bool> (default: 1)

Whether to convert underscores in hostname to dashes.

Underscore is not a valid character in hostname. This workaround can help a bit
by automatically converting underscores to dashes. Note that it does not ensure
hostnames like C<foo_.example.com> to become valid as C<foo-.example.com> is also
not a valid hostname.

=back

Return value:  (any)

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/DNS-Zone-PowerDNS-To-BIND>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-DNS-Zone-PowerDNS-To-BIND>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=DNS-Zone-PowerDNS-To-BIND>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 SEE ALSO

L<Sah::Schemas::DNS>

L<DNS::Zone::Struct::To::BIND>

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2019 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
