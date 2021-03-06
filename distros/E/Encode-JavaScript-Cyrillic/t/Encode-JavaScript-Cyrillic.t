# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Encode-JavaScript-Cyrillic.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 3;
use FindBin qw($Bin);
use lib $Bin.'/../lib';
BEGIN { use_ok('Encode::JavaScript::Cyrillic') };
use Encode;

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.
my $decString = '%u0401%u0410%u0411%u0412%u0413%u0414%u0415%u0416%u0417%u0418%u0419%u041A%u041B%u041C%u041D%u041E%u041F%u0420%u0421%u0422%u0423%u0424%u0425%u0426%u0427%u0428%u0429%u042A%u042B%u042C%u042D%u042E%u042F%u0430%u0431%u0432%u0433%u0434%u0435%u0436%u0437%u0438%u0439%u043A%u043B%u043C%u043D%u043E%u043F%u0440%u0441%u0442%u0443%u0444%u0445%u0446%u0447%u0448%u0449%u044A%u044B%u044C%u044D%u044E%u044F%u0451';
my $encString = 'ЁАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюяё';

my $res = decode('JavaScript-Cyrillic',$decString);
is($res,$encString);
$res = encode('JavaScript-Cyrillic',$encString);
is($res,$decString);

1;