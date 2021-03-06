# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl PBS.t'

#########################

# change 'tests => 2' to 'tests => last_test_to_print';

use Test::More tests => 3;
BEGIN { use_ok('PBS::Attr'); };


my $fail = 0;
foreach my $constname (qw(
	 MAXNAMLEN MAXPATHLEN MAX_ENCODE_BFR MGR_CMD_ACTIVE MGR_CMD_CREATE
	MGR_CMD_DELETE MGR_CMD_LIST MGR_CMD_PRINT MGR_CMD_SET MGR_CMD_UNSET
	MGR_OBJ_JOB MGR_OBJ_NODE MGR_OBJ_NONE MGR_OBJ_QUEUE MGR_OBJ_SERVER
	MSG_ERR MSG_OUT PBS_BATCH_SERVICE_PORT PBS_BATCH_SERVICE_PORT_DIS
	PBS_INTERACTIVE PBS_MANAGER_SERVICE_PORT PBS_MAXCLTJOBID PBS_MAXDEST
	PBS_MAXGRPN PBS_MAXHOSTNAME PBS_MAXPORTNUM PBS_MAXQUEUENAME
	PBS_MAXROUTEDEST PBS_MAXSEQNUM PBS_MAXSERVERNAME PBS_MAXSVRJOBID
	PBS_MAXUSER PBS_MOM_SERVICE_PORT PBS_SCHEDULER_SERVICE_PORT
	PBS_TERM_BUF_SZ PBS_TERM_CCA PBS_USE_IFF RESOURCE_T_ALL RESOURCE_T_NULL
	SHUT_DELAY SHUT_IMMEDIATE SHUT_QUICK SHUT_SIG)) {
  next if (eval "my \$a = $constname; 1");
  if ($@ =~ /^Your vendor has not defined PBS macro $constname/) {
    print "# pass: $@";
  } else {
    print "# fail: $@";
    $fail = 1;
  }

}

ok( $fail == 0 , 'Constants' );
#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $attr1 = PBS::Attr->new();
ok($attr1, 'PBS::Attr new');
