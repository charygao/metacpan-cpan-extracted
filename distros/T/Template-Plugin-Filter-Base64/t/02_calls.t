use strict;
use Test::More;

my $m;

BEGIN {
    use_ok( $m = 'Template::Plugin::Filter::Base64' );
}

can_ok('Template::Plugin::Filter::Base64', 'init');
can_ok('Template::Plugin::Filter::Base64', 'filter');

my $out = '';
my $input = 'Hello!';
my $parser;
eval {
    use Template;
    $parser = Template->new({
        OUTPUT => \$out,
        TRIM => 1,
    });
};
ok($parser, 'new Template object is ok');
ok($parser->process(\$input), 'Template process method is ok');
ok($input eq $out, 'Simple output correct');

$out = '';
$input = q~[% USE Filter.Base64 trim => 1 %]
    [% FILTER b64 %]
        Hello, world!
    [% END %]
~;

ok($parser->process(\$input), 'Template process method with filter 1 is ok');
ok($out eq 'SGVsbG8sIHdvcmxkIQ==', 'Test-filter 1 output correct');

$out = '';
$input = q~[% USE Filter.Base64 trim => 1, use_html_entity => 'cp1251' %]
    [% FILTER b64 %]
        ��������� cp1251
    [% END %]
~;

ok($parser->process(\$input), 'Template process method with filter 2 is ok');
ok($out eq "JiN4NDFBOyYjeDQzODsmI3g0NDA7JiN4NDM4OyYjeDQzQjsmI3g0M0I7JiN4NDM4OyYjeDQ0Njsm\nI3g0MzA7IGNwMTI1MQ==", 'Test-filter 2 output correct');

$out = '';
$input = q~[% USE Filter.Base64 dont_broken_into_lines_each_76_char => 1 %]
    [% FILTER b64 %]
        Beatae plane aures, quae non vocem foris sonantem, sed intus auscultant veritatem docentem
    [% END %]
~;

ok($parser->process(\$input), 'Template process method with filter 3 is ok');
ok($out eq 'CiAgICAgICAgQmVhdGFlIHBsYW5lIGF1cmVzLCBxdWFlIG5vbiB2b2NlbSBmb3JpcyBzb25hbnRlbSwgc2VkIGludHVzIGF1c2N1bHRhbnQgdmVyaXRhdGVtIGRvY2VudGVtCiAgICA=', 'Test-filter 3 output correct');



$out = '';
$input = q~[% USE Filter.Base64 dont_broken_into_lines_each_76_char => 1, trim => 1 %]
    [% FILTER b64 safeurl => 1  %]
        abcdn?
    [% END %]
~;

ok($parser->process(\$input), 'Template process method with filter 4 is ok');
is($out, 'YWJjZG4_', 'Test-filter 4 safeurl output correct');


$out = '';
$input = q~[% USE Filter.Base64 dont_broken_into_lines_each_76_char => 1, trim => 1 %]
    [% FILTER b64 safeurl => 0  %]
        abcdn?
    [% END %]
~;

ok($parser->process(\$input), 'Template process method with filter 5 is ok');
is($out, 'YWJjZG4/', 'Test-filter 5 safeurl output correct');

$out = '';
my $string = "\x{43F}\x{435}\x{440}\x{43B}";
$input = qq~[% USE Filter.Base64 dont_broken_into_lines_each_76_char => 1, trim => 1 %]
    [% FILTER b64 %]
        $string
    [% END %]
~;

ok($parser->process(\$input), 'Template process method with filter 6 is ok') or diag ($@);
is($out, '0L/QtdGA0Ls=', 'Test-filter 6 UTF-8 output correct');


$out = '';
$input = q~[% USE Filter.Base64 trim => 1, dont_broken_into_lines_each_76_char => 1 %]
    [% FILTER b64 %]
        ��������� cp1251
    [% END %]
~;

ok($parser->process(\$input), 'Template process method with filter 7 is ok') or diag($@);
is($out, "yujw6Ovr6PbgIGNwMTI1MQ==", 'Test-filter 7 cyrillic output correct');

done_testing();
