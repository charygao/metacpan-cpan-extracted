# NAME

Digest::xxHash - xxHash Implementation For Perl

# SYNOPSIS

    use Digest::xxHash qw[xxhash32 xxhash32_hex xxhash64 xxhash64_hex];

    my $hash = xxhash32( $data, $seed );
    my $hex  = xxhash32_hex( $data, $seed );

    my $hash_64 = xxhash64( $data, $seed );
    my $hex_64  = xxhash64_hex( $data, $seed );

# DESCRIPTION

xxHash is an extremely fast algorithm that claims to work at speeds close to RAM
limits. This is a wrapper of both the 32- and 64-bit hash functions.

# FUNCTIONAL INTERFACE

These functions are easy to use but aren't very flexible.

## $h = xxhash32( $data, $seed )

Calculates a 32 bit hash.

## $h = xxhash32\_hex( $data, $seed )

Calculates a 32 bit hash and returns it as a hex string.

## $h = xxhash64( $data, $seed )

Calculates a 64 bit hash.

## $h = xxhash64\_hex( $data, $seed )

Calculates a 64 bit hash and returns it as a hex string.

# SPEED

According to the xxhash project's website, when run in a single thread on a
32bit Windows 7 box with a 3GHz Core 2 Duo processor, xxhash looks a little
like:

    Name            Speed       Q.Score   Author
    xxHash          5.4 GB/s     10
        CrapWow         3.2 GB/s      2       Andrew
        MumurHash 3a    2.7 GB/s     10       Austin Appleby
        SpookyHash      2.0 GB/s     10       Bob Jenkins
        SBox            1.4 GB/s      9       Bret Mulvey
        Lookup3         1.2 GB/s      9       Bob Jenkins
        SuperFastHash   1.2 GB/s      1       Paul Hsieh
        CityHash64      1.05 GB/s    10       Pike & Alakuijala
        FNV             0.55 GB/s     5       Fowler, Noll, Vo
        CRC32           0.43 GB/s     9
        MD5-32          0.33 GB/s    10       Ronald L. Rivest
        SHA1-32         0.28 GB/s    10

Q.Score is a measure of "quality" of the hash function. It depends on
successfully passing
[SMHasher test set](http://code.google.com/p/smhasher/wiki/SMHasher). 10 is a
perfect score. Hash functions with a Q.score < 5 are not listed in this
table.

A 64-bits version, named XXH64, is available since (upstream) r35.
It offers much better speed, but for 64-bits applications only.

        Name     Speed on 64 bits    Speed on 32 bits
        XXH64       13.8 GB/s            1.9 GB/s
        XXH32        6.8 GB/s            6.0 GB/s

# LICENSE

xxHash is covered by the BSD license.

License-wise, I don't actually care about the wrapper I've written.

# AUTHOR

Sanko Robinson <sanko@cpan.org>

xxHash by Yann Collet.
