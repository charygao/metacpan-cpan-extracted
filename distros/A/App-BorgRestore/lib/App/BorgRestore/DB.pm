package App::BorgRestore::DB;
use v5.14;
use strictures 2;

use App::BorgRestore::Helper qw(untaint);

use autodie;
use DBI;
use Function::Parameters;
use Log::Any qw($log);
use Number::Bytes::Human qw(format_bytes);
use Path::Tiny;

=encoding utf-8

=head1 NAME

App::BorgRestore::DB - Database layer

=head1 DESCRIPTION

App::BorgRestore::DB abstracts the database storage used internally by L<App::BorgRestore>.

=cut

method new($class: $db_path, $cache_size) {
	my $self = {};
	bless $self, $class;

	if ($db_path =~ /^:/) {
		$self->_open_db($db_path);
	} elsif (! -f $db_path) {
		# ensure the cache directory exists
		path($db_path)->parent->mkpath({mode => oct(700)});

		$self->_open_db($db_path);
	} else {
		$self->_open_db($db_path);
	}
	$self->{cache_size} = $cache_size;

	return $self;
}

method _open_db($dbfile) {
	$log->debugf("Opening database at %s", $dbfile);
	$self->{dbh} = DBI->connect("dbi:SQLite:dbname=$dbfile","","", {RaiseError => 1, Taint => 1});
	$self->{dbh}->do("PRAGMA strict=ON");

	$self->_migrate();
}

method set_cache_size() {
	$self->{dbh}->do("PRAGMA cache_size=-".$self->{cache_size});
}

method _migrate() {
	my $version = $self->_get_db_version();
	$log->debugf("Current database schema version: %s", $version);

	my $schema = {
		1 => sub {
			$self->{dbh}->do('create table if not exists `files` (`path` text, primary key (`path`)) without rowid;');
			$self->{dbh}->do('create table if not exists `archives` (`archive_name` text unique);');
		},
		2 => sub {
			$self->{dbh}->do('alter table `archives` rename to `archives_old`');
			$self->{dbh}->do('create table `archives` (`id` integer primary key autoincrement, `archive_name` text unique);');
			$self->{dbh}->do('insert into `archives` select null, * from `archives_old`');
			$self->{dbh}->do('drop table `archives_old`');

			my $st = $self->{dbh}->prepare("select `archive_name` from `archives`;");
			$st->execute();
			while (my $result = $st->fetchrow_hashref) {
				my $archive = $result->{archive_name};
				# We trust all values here since they have already been
				# sucessfully put into the DB previously. Thus they must be
				# safe to deal with.
				$archive = untaint($archive, qr(.*));
				my $archive_id = $self->get_archive_id($archive);
				$self->{dbh}->do("alter table `files` rename column `timestamp-$archive` to `$archive_id`");
			}
},
	};

	for my $target_version (sort { $a <=> $b } keys %$schema) {
		if ($version < $target_version) {
			$log->debugf("Migrating to schema version %s", $target_version);
			$self->{dbh}->begin_work();
			$schema->{$target_version}->();
			$self->_set_db_version($target_version);
			$self->{dbh}->commit();
			$log->debugf("Schema upgrade to version %s complete", $target_version);
		}
	}
}

method _get_db_version() {
	my $st = $self->{dbh}->prepare("pragma user_version");
	$st->execute();
	return ($st->fetchrow_array)[0];
}

method _set_db_version($version) {
	die 'Invalid version number' unless $version =~ m/^\d+$/;
	my $st = $self->{dbh}->do("pragma user_version=$version");
}

method get_archive_names() {
	my @ret;

	my $st = $self->{dbh}->prepare("select `archive_name` from `archives`;");
	$st->execute();
	while (my $result = $st->fetchrow_hashref) {
		push @ret, $result->{archive_name};
	}
	return \@ret;
}

method get_archive_row_count() {
	my $st = $self->{dbh}->prepare("select count(*) count from `files`;");
	$st->execute();
	my $result = $st->fetchrow_hashref;
	return $result->{count};
}

method add_archive_name($archive) {
	my $st = $self->{dbh}->prepare('insert into `archives` (`archive_name`) values (?);');
	$st->execute(untaint($archive, qr(.*)));

	$self->_add_column_to_table("files", $archive);
}

method _add_column_to_table($table, $column) {
	my $st = $self->{dbh}->prepare('alter table `'.$table.'` add column `'.$self->get_archive_id($column).'` integer;');
	$st->execute();
}

method remove_archive($archive) {
	my $archive_id = $self->get_archive_id($archive);

	my @keep_archives = grep {$_ ne $archive;} @{$self->get_archive_names()};

	$self->{dbh}->do('create table `files_new` (`path` text, primary key (`path`)) without rowid;');
	for my $archive (@keep_archives) {
		$self->_add_column_to_table("files_new", $archive);
	}

	my @columns_to_copy = map {'`'.$self->get_archive_id($_).'`'} @keep_archives;
	my @timestamp_columns_to_copy = @columns_to_copy;
	@columns_to_copy = ('`path`', @columns_to_copy);

	if (@timestamp_columns_to_copy > 0) {
		$self->{dbh}->do('insert into `files_new` select '.join(',', @columns_to_copy).' from files');
	}

	$self->{dbh}->do('drop table `files`');

	$self->{dbh}->do('alter table `files_new` rename to `files`');

	if (@timestamp_columns_to_copy > 0) {
		my $sql = 'delete from `files` where ';
		$sql .= join(' is null and ', @timestamp_columns_to_copy);
		$sql .= " is null";

		my $st = $self->{dbh}->prepare($sql);
		$st->execute();
	}

	my $st = $self->{dbh}->prepare('delete from `archives` where `archive_name` = ?;');
	$st->execute(untaint($archive, qr(.*)));
}

method get_archive_id($archive) {
	my $st = $self->{dbh}->prepare("select `id` from `archives` where `archive_name` = ?;");
	$archive = untaint($archive, qr(.*));
	$st->execute($archive);
	my $result = $st->fetchrow_hashref;
	return untaint($result->{id}, qr(.*));
}

method get_archives_for_path($path) {
	my $st = $self->{dbh}->prepare('select * from `files` where `path` = ?;');
	$st->execute(untaint($path, qr(.*)));

	my @ret;

	my $result = $st->fetchrow_hashref;
	my $archives = $self->get_archive_names();

	for my $archive (@$archives) {
		my $archive_id = $self->get_archive_id($archive);
		my $timestamp = $result->{$archive_id};

		push @ret, {
			modification_time => $timestamp,
			archive => $archive,
		};
	}

	return \@ret;
}

method _insert_path($archive_id, $path, $time) {
	my $st = $self->{dbh}->prepare_cached('insert or ignore into `files` (`path`, `'.$archive_id.'`)
		values(?, ?)');
	$st->execute($path, $time);
}

method add_path($archive_id, $path, $time) {
	$self->_insert_path($archive_id, $path, $time);

	my $st = $self->{dbh}->prepare_cached('update files set `'.$archive_id.'` = ? where `path` = ?');
	$st->execute($time, $path);
}

method update_path_if_greater($archive_id, $path, $time) {
	$self->_insert_path($archive_id, $path, $time);

	my $st = $self->{dbh}->prepare_cached('update files set `'.$archive_id.'` = ? where `path` = ? and (`'.$archive_id.'` < ? or `'.$archive_id.'` is null)');
	$st->execute($time, $path, $time);
}

method begin_work() {
	$self->{dbh}->begin_work();
}

method commit() {
	$self->{dbh}->commit();
}

method verify_cache_fill_rate_ok() {
	my $used = $self->{dbh}->sqlite_db_status()->{cache_used}->{current};
	$log->debugf("sqlite page cache usage: %s", format_bytes($used, si=>1));
	if ($used > $self->{cache_size} * 1024 * 0.95) {
		$log->debugf("sqlite cache usage is %s of %s", format_bytes($used, si=>1), format_bytes($self->{cache_size} * 1024, si => 1));
		$log->debug("Consider increasing the sqlite cache if you notice performance issues (see documentation of App::BorgRestore::Settings)");
	}
}

method search_path($pattern) {
	$log->debugf("Preparing path search for pattern '%s'", $pattern);
	my $st = $self->{dbh}->prepare('select path from files where path like ?');
	$log->debug("Executing search");
	$st->execute($pattern);
	$log->debug("Fetching search result");

	my @ret;
	while (my $row = $st->fetchrow_hashref()) {
		push @ret, $row->{path};
	}

	$log->debugf("Found %d matching paths", 0+@ret);
	return \@ret;
}

method vacuum() {
	$self->{dbh}->do("vacuum");
}


1;

__END__
