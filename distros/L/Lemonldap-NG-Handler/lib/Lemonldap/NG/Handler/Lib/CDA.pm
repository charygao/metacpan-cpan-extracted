package Lemonldap::NG::Handler::Lib::CDA;

use strict;

our $VERSION = '2.0.6';

sub run {
    my ( $class, $req, $rule, $protection ) = @_;
    my $uri = $req->{env}->{REQUEST_URI};
    my $cn  = $class->tsv->{cookieName};
    my ( $id, $session );
    if ( $uri =~ s/[\?&;]${cn}cda=(\w+)$//oi ) {
        if (    $id = $class->fetchId($req)
            and $session = $class->retrieveSession( $req, $id ) )
        {
            $class->logger->info(
                'CDA asked for an already available session, skipping');
        }
        else {
            my $cdaid = $1;
            $class->logger->debug("CDA request with id $cdaid");

            my $cdaInfos = $class->getCDAInfos( $req, $cdaid );
            unless ( $cdaInfos->{cookie_value} and $cdaInfos->{cookie_name} ) {
                $class->logger->error("CDA request for id $cdaid is not valid");
                return $class->FORBIDDEN;
            }

            my $redirectUrl   = $class->_buildUrl( $req, $uri );
            my $redirectHttps = ( $redirectUrl =~ m/^https/ );
            $class->set_header_out(
                $req,
                'Location'   => $redirectUrl,
                'Set-Cookie' => $cdaInfos->{cookie_name} . "=" . 'c:'
                  . $class->tsv->{cipher}->encrypt(
                    $cdaInfos->{cookie_value} . ' ' . $class->resolveAlias($req)
                  )
                  . "; path=/"
                  . ( $redirectHttps          ? "; secure"   : "" )
                  . ( $class->tsv->{httpOnly} ? "; HttpOnly" : "" )
                  . (
                    $class->tsv->{cookieExpiration}
                    ? "; max-age=" . $class->tsv->{cookieExpiration}
                    : ""
                  )
            );
            $req->data->{'noTry'} = 1;
            return $class->REDIRECT;
        }
    }
    return $class->Lemonldap::NG::Handler::Main::run( $req, $rule,
        $protection );
}

## @rmethod protected hash getCDAInfos(id)
# Tries to retrieve the CDA session, get infos and delete session
# @return CDA session infos
sub getCDAInfos {
    my ( $class, $req, $id ) = @_;
    my $infos = {};

    # Get the session
    my $cdaSession = Lemonldap::NG::Common::Session->new( {
            storageModule        => $class->tsv->{sessionStorageModule},
            storageModuleOptions => $class->tsv->{sessionStorageOptions},
            cacheModule          => $class->tsv->{sessionCacheModule},
            cacheModuleOptions   => $class->tsv->{sessionCacheOptions},
            id                   => $id,
            kind                 => "CDA",
        }
    );

    unless ( $cdaSession->error ) {
        $class->logger->debug("Get CDA session $id");

        $infos->{cookie_value} = $cdaSession->data->{cookie_value};
        $infos->{cookie_name}  = $cdaSession->data->{cookie_name};

        $cdaSession->remove;
    }
    else {
        $class->logger->info("CDA Session $id can't be retrieved");
        $class->logger->info( $cdaSession->error );
    }

    return $infos;
}

1;
