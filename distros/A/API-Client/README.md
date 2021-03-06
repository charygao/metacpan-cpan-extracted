# NAME

API::Client

# ABSTRACT

HTTP API Thin-Client Abstraction

# SYNOPSIS

    package main;

    use API::Client;

    my $client = API::Client->new(url => 'https://httpbin.org');

    # $client->resource('post');

    # $client->update(json => {...});

# DESCRIPTION

This package provides an abstraction and method for rapidly developing HTTP API
clients. While this module can be used to interact with APIs directly,
API::Client was designed to be consumed (subclassed) by higher-level
purpose-specific API clients.

# THIN CLIENT

The thin API client library is advantageous as it has complete API coverage and
can easily adapt to changes in the API with minimal effort. As a thin-client
superclass, this module does not map specific HTTP requests to specific
routines, nor does it provide parameter validation, pagination, or other
conventions found in typical API client implementations; Instead, it simply
provides a simple and consistent mechanism for dynamically generating HTTP
requests.  Additionally, this module has support for debugging and retrying API
calls as well as throwing exceptions when 4xx and 5xx server response codes are
returned.

# INTEGRATES

This package integrates behaviors from:

[Data::Object::Role::Buildable](https://metacpan.org/pod/Data::Object::Role::Buildable)

[Data::Object::Role::Stashable](https://metacpan.org/pod/Data::Object::Role::Stashable)

[Data::Object::Role::Throwable](https://metacpan.org/pod/Data::Object::Role::Throwable)

# LIBRARIES

This package uses type constraints from:

[Types::Standard](https://metacpan.org/pod/Types::Standard)

# SCENARIOS

This package supports the following scenarios:

## building

    # given: synopsis

    my $resource = $client->resource('get');

    # GET /get
    my $get = $client->resource('get')->dispatch;

    # HEAD /head
    my $head = $client->resource('head')->dispatch(
      method => 'head'
    );

    # PATCH /patch
    my $patch = $client->resource('patch')->dispatch(
      method => 'patch'
    );

    [$get, $head, $patch]

Building up an HTTP request is extremely easy, simply call the ["resource"](#resource) to
create a new object instance representing the API endpoint you wish to issue a
request against.

## chaining

    # given: synopsis

    # https://httpbin.org/users
    my $users = $client->resource('users');

    # https://httpbin.org/users/c09e91a
    my $user = $client->resource('users', 'c09e91a');

    # https://httpbin.org/users/c09e91a
    my $new_user = $users->resource('c09e91a');

    [$users, $user, $new_user]

Because each call to ["resource"](#resource) returns a new object instance configured with
a path (resource locator) based on the supplied parameters, reuse and request
isolation are made simple, i.e., you will only need to configure the client
once in your application.

## creating

    # given: synopsis

    my $tx1 = $client->resource('post')->create(
      json => {active => 1}
    );

    # is equivalent to

    my $tx2 = $client->resource('post')->dispatch(
      method => 'post',
      json => {active => 1}
    );

    [$tx1, $tx2]

This example illustrates how you might create a new API resource.

## deleting

    # given: synopsis

    my $tx1 = $client->resource('delete')->delete(
      json => {active => 1}
    );

    # is equivalent to

    my $tx2 = $client->resource('delete')->dispatch(
      method => 'delete',
      json => {active => 1}
    );

    [$tx1, $tx2]

This example illustrates how you might delete a new API resource.

## fetching

    # given: synopsis

    my $tx1 = $client->resource('get')->fetch(
      query => {active => 1}
    );

    # is equivalent to

    my $tx2 = $client->resource('get')->dispatch(
      method => 'get',
      query => {active => 1}
    );

    [$tx1, $tx2]

This example illustrates how you might fetch an API resource.

## subclassing

    package Hookbin;

    use Data::Object::Class;

    extends 'API::Client';

    sub auth {
      ['admin', 'secret']
    }

    sub headers {
      [['Accept', '*/*']]
    }

    sub base {
      ['https://httpbin.org/get']
    }

    package main;

    my $hookbin = Hookbin->new;

This package was designed to be subclassed and provides hooks into the client
building and request dispatching processes. Specifically, there are three
useful hooks (i.e. methods, which if present are used to build up the client
object and requests), which are, the `auth` hook, which should return a
`Tuple[Str, Str]` which is used to configure the basic auth header, the
`base` hook which should return a `Tuple[Str]` which is used to configure the
base URL, and the `headers` hook, which should return a
`ArrayRef[Tuple[Str, Str]]` which are used to configure the HTTP request
headers.

## transacting

    # given: synopsis

    my $tx1 = $client->resource('patch')->patch(
      json => {active => 1}
    );

    # is equivalent to

    my $tx2 = $client->resource('patch')->dispatch(
      method => 'patch',
      json => {active => 1}
    );

    [$tx1, $tx2]

An HTTP request is only issued when the ["dispatch"](#dispatch) method is called, directly
or indirectly. Those calls return a [Mojo::Transaction](https://metacpan.org/pod/Mojo::Transaction) object which provides
access to the `request` and `response` objects.

## updating

    # given: synopsis

    my $tx1 = $client->resource('put')->update(
      json => {active => 1}
    );

    # is equivalent to

    my $tx2 = $client->resource('put')->dispatch(
      method => 'put',
      json => {active => 1}
    );

    [$tx1, $tx2]

This example illustrates how you might update a new API resource.

# ATTRIBUTES

This package has the following attributes:

## debug

    debug(Bool)

This attribute is read-only, accepts `(Bool)` values, and is optional.

## fatal

    fatal(Bool)

This attribute is read-only, accepts `(Bool)` values, and is optional.

## logger

    logger(InstanceOf["FlightRecorder"])

This attribute is read-only, accepts `(InstanceOf["FlightRecorder"])` values, and is optional.

## name

    name(Str)

This attribute is read-only, accepts `(Str)` values, and is optional.

## retries

    retries(Int)

This attribute is read-only, accepts `(Int)` values, and is optional.

## timeout

    timeout(Int)

This attribute is read-only, accepts `(Int)` values, and is optional.

## url

    url(InstanceOf["Mojo::URL"])

This attribute is read-only, accepts `(InstanceOf["Mojo::URL"])` values, and is optional.

## user\_agent

    user_agent(InstanceOf["Mojo::UserAgent"])

This attribute is read-only, accepts `(InstanceOf["Mojo::UserAgent"])` values, and is optional.

## version

    version(Str)

This attribute is read-only, accepts `(Str)` values, and is optional.

# METHODS

This package implements the following methods:

## create

    create(Any %args) : InstanceOf["Mojo::Transaction"]

The create method issues a `POST` request to the API resource represented by
the object.

- create example #1

        # given: synopsis

        $client->resource('post')->create(
          json => {active => 1}
        );

## delete

    delete(Any %args) : InstanceOf["Mojo::Transaction"]

The delete method issues a `DELETE` request to the API resource represented by
the object.

- delete example #1

        # given: synopsis

        $client->resource('delete')->delete;

## dispatch

    dispatch(Str :$method = 'get', Any %args) : InstanceOf["Mojo::Transaction"]

The dispatch method issues a request to the API resource represented by the
object.

- dispatch example #1

        # given: synopsis

        $client->resource('get')->dispatch;

- dispatch example #2

        # given: synopsis

        $client->resource('post')->dispatch(
          method => 'post', body => 'active=1'
        );

- dispatch example #3

        # given: synopsis

        $client->resource('get')->dispatch(
          method => 'get', query => {active => 1}
        );

- dispatch example #4

        # given: synopsis

        $client->resource('post')->dispatch(
          method => 'post', json => {active => 1}
        );

- dispatch example #5

        # given: synopsis

        $client->resource('post')->dispatch(
          method => 'post', form => {active => 1}
        );

- dispatch example #6

        # given: synopsis

        $client->resource('put')->dispatch(
          method => 'put', json => {active => 1}
        );

- dispatch example #7

        # given: synopsis

        $client->resource('patch')->dispatch(
          method => 'patch', json => {active => 1}
        );

- dispatch example #8

        # given: synopsis

        $client->resource('delete')->dispatch(
          method => 'delete', json => {active => 1}
        );

## fetch

    fetch(Any %args) : InstanceOf["Mojo::Transaction"]

The fetch method issues a `GET` request to the API resource represented by the
object.

- fetch example #1

        # given: synopsis

        $client->resource('get')->fetch;

## patch

    patch(Any %args) : InstanceOf["Mojo::Transaction"]

The patch method issues a `PATCH` request to the API resource represented by
the object.

- patch example #1

        # given: synopsis

        $client->resource('patch')->patch(
          json => {active => 1}
        );

## prepare

    prepare(Object $ua, Object $tx, Any %args) : Object

The prepare method acts as a `before` hook triggered before each request where
you can modify the transactor objects.

- prepare example #1

        # given: synopsis

        require Mojo::UserAgent;
        require Mojo::Transaction::HTTP;

        $client->prepare(
          Mojo::UserAgent->new,
          Mojo::Transaction::HTTP->new
        );

## process

    process(Object $ua, Object $tx, Any %args) : Object

The process method acts as an `after` hook triggered after each response where
you can modify the transactor objects.

- process example #1

        # given: synopsis

        require Mojo::UserAgent;
        require Mojo::Transaction::HTTP;

        $client->process(
          Mojo::UserAgent->new,
          Mojo::Transaction::HTTP->new
        );

## resource

    resource(Str @segments) : Object

The resource method returns a new instance of the object for the API resource
endpoint specified.

- resource example #1

        # given: synopsis

        $client->resource('status', 200);

## serialize

    serialize() : HashRef

The serialize method serializes and returns the object as a `hashref`.

- serialize example #1

        # given: synopsis

        $client->serialize;

## update

    update(Any %args) : InstanceOf["Mojo::Transaction"]

The update method issues a `PUT` request to the API resource represented by
the object.

- update example #1

        # given: synopsis

        $client->resource('put')->update(
          json => {active => 1}
        );

# AUTHOR

Al Newkirk, `awncorp@cpan.org`

# LICENSE

Copyright (C) 2011-2019, Al Newkirk, et al.

This is free software; you can redistribute it and/or modify it under the terms
of the The Apache License, Version 2.0, as elucidated in the ["license
file"](https://github.com/iamalnewkirk/api-client/blob/master/LICENSE).

# PROJECT

[Wiki](https://github.com/iamalnewkirk/api-client/wiki)

[Project](https://github.com/iamalnewkirk/api-client)

[Initiatives](https://github.com/iamalnewkirk/api-client/projects)

[Milestones](https://github.com/iamalnewkirk/api-client/milestones)

[Contributing](https://github.com/iamalnewkirk/api-client/blob/master/CONTRIBUTE.md)

[Issues](https://github.com/iamalnewkirk/api-client/issues)
