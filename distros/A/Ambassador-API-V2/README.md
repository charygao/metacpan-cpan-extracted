# NAME

Ambassador::API::V2 - Speak with the getambassador.com API v2

# SYNOPSIS

    use Ambassador::API::V2;

    my $api = Ambassador::API::V2->new(
        username => $app_username,
        key      => $app_key
    );

    my $result = $api->post(
        '/event/record/' => {
            email        => 'fake@fakeity.fake',
            campaign_uid => 1234
        }
    );

    my $result = $api->get(
        '/shortcode/get/' => {
            short_code => $mbsy,
        }
    );

# DESCRIPTION

Speak with the [getambassador.com](https://metacpan.org/pod/getambassador.com) API version 2. See
[https://docs.getambassador.com](https://docs.getambassador.com).

# CONSTRUCTOR

    my $api = Ambassador::API::V2->new(
        username => $app_username,
        key      => $app_key
    );

- key

    The key for your app. `YOUR_APP_KEY` in the API docs.

- username

    The username for your app. `YOUR_APP_USERNAME` in the API docs.

- url

    The URL to call.

    Defaults to [https://getambassador.com/api/v2/](https://getambassador.com/api/v2/)

# METHODS

- $api->post($method, \\%args);
- $api->get($method, \\%args);

        my $response = $api->post($method, \%args);
        my $response = $api->get($method, \%args);

    Call an Ambassador API `$method` with the given `%args`.

    If successful, it returns an [Ambassdor::API::V2::Response](https://metacpan.org/pod/Ambassdor::API::V2::Response).
    If it fails, it will throw an [Ambassador::API::V2::Error](https://metacpan.org/pod/Ambassador::API::V2::Error).

    See the [Ambassador API docs](https://docs.getambassador.com/docs/)
    for what $methods are available, what `%args` they take, and which
    should be called with `get` or `post`.

# SOURCE

The source code repository for Ambassador-API-V2 can be found at
`https://github.com/dreamhost/Ambassador-API-V2`.

# COPYRIGHT

Copyright 2016 Dreamhost <dev-notify@hq.newdream.net>.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

See `http://dev.perl.org/licenses/`
