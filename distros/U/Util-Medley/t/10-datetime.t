use Test::More;
use Modern::Perl;
use Util::Medley::DateTime;
use Util::Medley::String;
use Data::Printer alias => 'pdump';

use constant SECS_PER_MIN => 60;
use constant SECS_PER_HOUR => SECS_PER_MIN() * 60;
use constant SECS_PER_DAY => SECS_PER_HOUR() * 24;

#####################################
# constructor
#####################################

use vars qw ($DateTime);

$DateTime = Util::Medley::DateTime->new;
ok($DateTime);

#####################################
# localdatetime
#####################################

checkLocalDateTime();
checkLocalDateTimeIsValid();
checkLocalDateTimeToEpoch();
checkLocalDateTimeAdd();
checkTimeMs();
checkIso8601DateTime();
checkIso8601DateTimeToEpoch();

done_testing;

#######

sub checkIso8601DateTime {
	
	ok(my $epoch = $DateTime->iso8601DateTime(time));
}

sub checkIso8601DateTimeToEpoch {

	my $now = time;
	my $iso8601_str = $DateTime->iso8601DateTime($now);
	
	ok(my $epoch = $DateTime->iso8601DateTimeToEpoch($iso8601_str));
	ok($epoch == $now);
}

sub checkLocalDateTimeAdd {

	my $dt = $DateTime->localDateTime;

	#
	# add 1 hour
	#	
	ok(my $newDt = $DateTime->localDateTimeAdd($dt, 0, 1));

	my $dtEpoch = $DateTime->localDateTimeToEpoch(dateTime => $dt);	
	my $newDtEpoch = $DateTime->localDateTimeToEpoch(dateTime => $newDt);	
	ok($newDtEpoch == $dtEpoch + SECS_PER_HOUR);
	
	#
	# add 1 day, 1 hour, 1 min, 1 sec
	#
	ok($newDt = $DateTime->localDateTimeAdd($dt, 1, 1, 1, 1));
	$newDtEpoch = $DateTime->localDateTimeToEpoch(dateTime => $newDt);	
	ok($newDtEpoch == $dtEpoch + SECS_PER_DAY + SECS_PER_HOUR + SECS_PER_MIN + 1);
}

sub checkLocalDateTimeToEpoch {

	my $str = $DateTime->localDateTime;

	my $epoch = $DateTime->localDateTimeToEpoch($str);
	ok($epoch);

	my $utilMedleyStr = Util::Medley::String->new;
	ok( $utilMedleyStr->isInt($epoch) );
}

sub checkLocalDateTime {

	ok( $DateTime->localDateTime );
	ok( $DateTime->localDateTime(time) );
}

sub checkLocalDateTimeIsValid {

	my $str = $DateTime->localDateTime;
	ok( $DateTime->localDateTimeIsValid($str) );
	
	ok($DateTime->localDateTimeIsValid('2019-11-20 10:26:31'));
		
	ok( !$DateTime->localDateTimeIsValid('foobar') );
	ok( !$DateTime->localDateTimeIsValid('0000-88-00 88:00:00') );
}

sub checkTimeMs {
	
	ok($DateTime->timeMs > time);	
}
