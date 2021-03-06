
use strict;
use warnings;

use Test::More tests => 7;
use Test::Deep v0.111; # 0.111 => obj_isa
use Test::Warnings qw[ :no_end_test had_no_warnings ];

use Shared::Examples::Net::Amazon::S3::API (
    qw[ fixture ],
    qw[ with_response_fixture ],
    qw[ expect_api_bucket_create ],
);

expect_api_bucket_create 'simple create bucket (default region us-east-1)' => (
    with_bucket             => 'some-bucket',
    expect_request          => { PUT => 'https://some-bucket.s3.amazonaws.com/' },
    expect_request_content  => '',
    expect_data             => all (
        obj_isa ('Net::Amazon::S3::Bucket'),
        methods (bucket => 'some-bucket'),
    ),
);

expect_api_bucket_create 'create bucket in different region' => (
    with_bucket             => 'some-bucket',
    with_region             => 'ca-central-1',
    expect_request          => { PUT => 'https://some-bucket.s3.amazonaws.com/' },
    expect_request_content  => fixture ('request::bucket_create_ca_central_1')->{content},
    expect_data             => all (
        obj_isa ('Net::Amazon::S3::Bucket'),
        methods (bucket => 'some-bucket'),
    ),
);

expect_api_bucket_create 'create bucket with acl' => (
    with_bucket             => 'some-bucket',
    with_acl                => 'private',
    expect_request          => { PUT => 'https://some-bucket.s3.amazonaws.com/' },
    expect_request_content  => '',
    expect_request_headers  => { x_amz_acl => 'private' },
    expect_data             => all (
        obj_isa ('Net::Amazon::S3::Bucket'),
        methods (bucket => 'some-bucket'),
    ),
);

expect_api_bucket_create 'error access denied' => (
    with_bucket             => 'some-bucket',
    with_response_fixture ('error::access_denied'),
    expect_request          => { PUT => 'https://some-bucket.s3.amazonaws.com/' },
    expect_request_content  => '',
    expect_data             => bool (0),
    expect_s3_err           => 'AccessDenied',
    expect_s3_errstr        => 'Access denied error message',
);

expect_api_bucket_create 'error bucket already exists' => (
    with_bucket             => 'some-bucket',
    with_response_fixture ('error::bucket_already_exists'),
    expect_request          => { PUT => 'https://some-bucket.s3.amazonaws.com/' },
    expect_request_content  => '',
    expect_data             => bool (0),
    expect_s3_err           => 'BucketAlreadyExists',
    expect_s3_errstr        => 'Bucket already exists error message',
);

expect_api_bucket_create 'error invalid bucket name' => (
    with_bucket             => 'some-bucket',
    with_response_fixture ('error::invalid_bucket_name'),
    expect_request          => { PUT => 'https://some-bucket.s3.amazonaws.com/' },
    expect_request_content  => '',
    expect_data             => bool (0),
    expect_s3_err           => 'InvalidBucketName',
    expect_s3_errstr        => 'Invalid bucket name error message',
);

had_no_warnings;
