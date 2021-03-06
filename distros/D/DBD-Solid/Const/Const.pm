# $Id: Const.pm,v 1.1 2001/10/13 21:08:47 joe Exp $
# Copyright (c) 1997  Thomas K. Wenrich
# portions Copyright (c) 1994,1995,1996  Tim Bunce
#
# You may distribute under the terms of either the GNU General Public
# License or the Artistic License, as specified in the Perl README file.
#
package DBD::Solid::Const;
use vars qw($VERSION @ISA %EXPORT_TAGS @EXPORT @EXPORT_OK $AUTOLOAD);

# use strict;
use Carp;
require Exporter;
require DynaLoader;
require AutoLoader;

$VERSION = '0.20a';

@ISA = qw(Exporter DynaLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@DBD::Solid::Const::EXPORT = ();

# I added the three unicode types. --mms
%DBD::Solid::Const::EXPORT_TAGS = 
    ( 
    sql_types => [ qw(SQL_CHAR
		       SQL_NUMERIC
		       SQL_DECIMAL
		       SQL_INTEGER
		       SQL_SMALLINT
		       SQL_FLOAT
		       SQL_REAL
		       SQL_DOUBLE
		       SQL_VARCHAR
		       SQL_DATE
		       SQL_TIME
		       SQL_TIMESTAMP
		       SQL_LONGVARCHAR
		       SQL_BINARY
		       SQL_LONGVARBINARY
		       SQL_BIGINT
		       SQL_TINYINT
		       SQL_BIT
             SQL_WCHAR
             SQL_WVARCHAR
             SQL_WLONGVARCHAR) ], # sql_types
    );

Exporter::export_tags();

# Removed this from the following list. --mms
#	CLI0DEFS_H
@EXPORT_OK = qw(
	ODBCVER
	SQL_ACCESSIBLE_PROCEDURES
	SQL_ACCESSIBLE_TABLES
	SQL_ACCESS_MODE
	SqL_ACTIVE_CONNECTIONS
	SQL_ACTIVE_STATEMENTS
	SQL_ADD
	SQL_ALL_EXCEPT_LIKE
	SQL_ALL_TYPES
	SQL_ALTER_TABLE

	SQL_API_ALL_FUNCTIONS
	SQL_API_LOADBYORDINAL
	SQL_API_SQLALLOCCONNECT
	SQL_API_SQLALLOCENV
	SQL_API_SQLALLOCSTMT
	SQL_API_SQLBINDCOL
	SQL_API_SQLBINDPARAMETER
	SQL_API_SQLBROWSECONNECT
	SQL_API_SQLCANCEL
	SQL_API_SQLCOLATTRIBUTES
	SQL_API_SQLCOLUMNPRIVILEGES
	SQL_API_SQLCOLUMNS
	SQL_API_SQLCONNECT
	SQL_API_SQLDATASOURCES
	SQL_API_SQLDESCRIBECOL
	SQL_API_SQLDESCRIBEPARAM
	SQL_API_SQLDISCONNECT
	SQL_API_SQLDRIVERCONNECT
	SQL_API_SQLDRIVERS
	SQL_API_SQLERROR
	SQL_API_SQLEXECDIRECT
	SQL_API_SQLEXECUTE
	SQL_API_SQLEXTENDEDFETCH
	SQL_API_SQLFETCH
	SQL_API_SQLFOREIGNKEYS
	SQL_API_SQLFREECONNECT
	SQL_API_SQLFREEENV
	SQL_API_SQLFREESTMT
	SQL_API_SQLGETCONNECTOPTION
	SQL_API_SQLGETCURSORNAME
	SQL_API_SQLGETDATA
	SQL_API_SQLGETFUNCTIONS
	SQL_API_SQLGETINFO
	SQL_API_SQLGETSTMTOPTION
	SQL_API_SQLGETTYPEINFO
	SQL_API_SQLMORERESULTS
	SQL_API_SQLNATIVESQL
	SQL_API_SQLNUMPARAMS
	SQL_API_SQLNUMRESULTCOLS
	SQL_API_SQLPARAMDATA
	SQL_API_SQLPARAMOPTIONS
	SQL_API_SQLPREPARE
	SQL_API_SQLPRIMARYKEYS
	SQL_API_SQLPROCEDURECOLUMNS
	SQL_API_SQLPROCEDURES
	SQL_API_SQLPUTDATA
	SQL_API_SQLROWCOUNT
	SQL_API_SQLSETCONNECTOPTION
	SQL_API_SQLSETCURSORNAME
	SQL_API_SQLSETPARAM
	SQL_API_SQLSETPOS
	SQL_API_SQLSETSCROLLOPTIONS
	SQL_API_SQLSETSTMTOPTION
	SQL_API_SQLSPECIALCOLUMNS
	SQL_API_SQLSTATISTICS
	SQL_API_SQLTABLEPRIVILEGES
	SQL_API_SQLTABLES
	SQL_API_SQLTRANSACT

	SQL_ASYNC_ENABLE
	SQL_ASYNC_ENABLE_DEFAULT
	SQL_ASYNC_ENABLE_OFF
	SQL_ASYNC_ENABLE_ON
	SQL_ATTR_READONLY
	SQL_ATTR_READWRITE_UNKNOWN
	SQL_ATTR_WRITE
	SQL_AT_ADD_COLUMN
	SQL_AT_DROP_COLUMN
	SQL_AUTOCOMMIT
	SQL_AUTOCOMMIT_DEFAULT
	SQL_AUTOCOMMIT_OFF
	SQL_AUTOCOMMIT_ON
	SQL_BEST_ROWID
	SQL_BIGINT
	SQL_BINARY
	SQL_BIND_BY_COLUMN
	SQL_BIND_TYPE
	SQL_BIT
	SQL_BOOKMARK_PERSISTENCE
	SQL_BP_CLOSE
	SQL_BP_DELETE
	SQL_BP_DROP
	SQL_BP_OTHER_HSTMT
	SQL_BP_SCROLL
	SQL_BP_TRANSACTION
	SQL_BP_UPDATE
	SQL_CASCADE
	SQL_CB_CLOSE
	SQL_CB_DELETE
	SQL_CB_NON_NULL
	SQL_CB_NULL
	SQL_CB_PRESERVE
	SQL_CC_CLOSE
	SQL_CC_DELETE
	SQL_CC_PRESERVE
	SQL_CHAR
	SQL_CLOSE
	SQL_CN_ANY
	SQL_CN_DIFFERENT
	SQL_CN_NONE
	SQL_COLATT_OPT_MAX
	SQL_COLATT_OPT_MIN
	SQL_COLUMN_ALIAS
	SQL_COLUMN_AUTO_INCREMENT
	SQL_COLUMN_CASE_SENSITIVE
	SQL_COLUMN_COUNT
	SQL_COLUMN_DISPLAY_SIZE
	SQL_COLUMN_DRIVER_START
	SQL_COLUMN_LABEL
	SQL_COLUMN_LENGTH
	SQL_COLUMN_MONEY
	SQL_COLUMN_NAME
	SQL_COLUMN_NULLABLE
	SQL_COLUMN_OWNER_NAME
	SQL_COLUMN_PRECISION
	SQL_COLUMN_QUALIFIER_NAME
	SQL_COLUMN_SCALE
	SQL_COLUMN_SEARCHABLE
	SQL_COLUMN_TABLE_NAME
	SQL_COLUMN_TYPE
	SQL_COLUMN_TYPE_NAME
	SQL_COLUMN_UNSIGNED
	SQL_COLUMN_UPDATABLE
	SQL_COMMIT
	SQL_CONCAT_NULL_BEHAVIOR
	SQL_CONCURRENCY
	SQL_CONCUR_LOCK
	SQL_CONCUR_READ_ONLY
	SQL_CONCUR_ROWVER
	SQL_CONCUR_TIMESTAMP
	SQL_CONCUR_VALUES
	SQL_CONNECT_OPT_DRVR_START
	SQL_CONN_OPT_MAX
	SQL_CONN_OPT_MIN
	SQL_CONVERT_BIGINT
	SQL_CONVERT_BINARY
	SQL_CONVERT_BIT
	SQL_CONVERT_CHAR
	SQL_CONVERT_DATE
	SQL_CONVERT_DECIMAL
	SQL_CONVERT_DOUBLE
	SQL_CONVERT_FLOAT
	SQL_CONVERT_FUNCTIONS
	SQL_CONVERT_INTEGER
	SQL_CONVERT_LONGVARBINARY
	SQL_CONVERT_LONGVARCHAR
	SQL_CONVERT_NUMERIC
	SQL_CONVERT_REAL
	SQL_CONVERT_SMALLINT
	SQL_CONVERT_TIME
	SQL_CONVERT_TIMESTAMP
	SQL_CONVERT_TINYINT
	SQL_CONVERT_VARBINARY
	SQL_CONVERT_VARCHAR
	SQL_CORRELATION_NAME
	SQL_CR_CLOSE
	SQL_CR_DELETE
	SQL_CR_PRESERVE
	SQL_CURRENT_QUALIFIER
	SQL_CURSOR_COMMIT_BEHAVIOR
	SQL_CURSOR_DYNAMIC
	SQL_CURSOR_FORWARD_ONLY
	SQL_CURSOR_KEYSET_DRIVEN
	SQL_CURSOR_ROLLBACK_BEHAVIOR
	SQL_CURSOR_STATIC
	SQL_CURSOR_TYPE
	SQL_CUR_DEFAULT
	SQL_CUR_USE_DRIVER
	SQL_CUR_USE_IF_NEEDED
	SQL_CUR_USE_ODBC
	SQL_CVT_BIGINT
	SQL_CVT_BINARY
	SQL_CVT_BIT
	SQL_CVT_CHAR
	SQL_CVT_DATE
	SQL_CVT_DECIMAL
	SQL_CVT_DOUBLE
	SQL_CVT_FLOAT
	SQL_CVT_INTEGER
	SQL_CVT_LONGVARBINARY
	SQL_CVT_LONGVARCHAR
	SQL_CVT_NUMERIC
	SQL_CVT_REAL
	SQL_CVT_SMALLINT
	SQL_CVT_TIME
	SQL_CVT_TIMESTAMP
	SQL_CVT_TINYINT
	SQL_CVT_VARBINARY
	SQL_CVT_VARCHAR
	SQL_C_BINARY
	SQL_C_BIT
	SQL_C_BOOKMARK
	SQL_C_CHAR
	SQL_C_DATE
	SQL_C_DEFAULT
	SQL_C_DOUBLE
	SQL_C_FLOAT
	SQL_C_LONG
	SQL_C_SHORT
	SQL_C_SLONG
	SQL_C_SSHORT
	SQL_C_STINYINT
	SQL_C_TIME
	SQL_C_TIMESTAMP
	SQL_C_TINYINT
	SQL_C_ULONG
	SQL_C_USHORT
	SQL_C_UTINYINT
	SQL_DATABASE_NAME
	SQL_DATA_AT_EXEC
	SQL_DATA_SOURCE_NAME
	SQL_DATA_SOURCE_READ_ONLY
	SQL_DATE
	SQL_DBMS_NAME
	SQL_DBMS_VER
	SQL_DECIMAL
	SQL_DEFAULT_PARAM
	SQL_DEFAULT_TXN_ISOLATION
	SQL_DELETE
	SQL_DOUBLE
	SQL_DRIVER_COMPLETE
	SQL_DRIVER_COMPLETE_REQUIRED
	SQL_DRIVER_HDBC
	SQL_DRIVER_HENV
	SQL_DRIVER_HLIB
	SQL_DRIVER_HSTMT
	SQL_DRIVER_NAME
	SQL_DRIVER_NOPROMPT
	SQL_DRIVER_ODBC_VER
	SQL_DRIVER_PROMPT
	SQL_DRIVER_VER
	SQL_DROP
	SQL_ENSURE
	SQL_ENTIRE_ROWSET
	SQL_ERROR
	SQL_EXPRESSIONS_IN_ORDERBY
	SQL_EXT_API_LAST
	SQL_EXT_API_START
	SQL_FD_FETCH_ABSOLUTE
	SQL_FD_FETCH_BOOKMARK
	SQL_FD_FETCH_FIRST
	SQL_FD_FETCH_LAST
	SQL_FD_FETCH_NEXT
	SQL_FD_FETCH_PREV
	SQL_FD_FETCH_PRIOR
	SQL_FD_FETCH_RELATIVE
	SQL_FD_FETCH_RESUME
	SQL_FETCH_ABSOLUTE
	SQL_FETCH_BOOKMARK
	SQL_FETCH_DIRECTION
	SQL_FETCH_FIRST
	SQL_FETCH_LAST
	SQL_FETCH_NEXT
	SQL_FETCH_PREV
	SQL_FETCH_PRIOR
	SQL_FETCH_RELATIVE
	SQL_FETCH_RESUME
	SQL_FILE_NOT_SUPPORTED
	SQL_FILE_QUALIFIER
	SQL_FILE_TABLE
	SQL_FILE_USAGE
	SQL_FLOAT
	SQL_FN_CVT_CONVERT
	SQL_FN_NUM_ABS
	SQL_FN_NUM_ACOS
	SQL_FN_NUM_ASIN
	SQL_FN_NUM_ATAN
	SQL_FN_NUM_ATAN2
	SQL_FN_NUM_CEILING
	SQL_FN_NUM_COS
	SQL_FN_NUM_COT
	SQL_FN_NUM_DEGREES
	SQL_FN_NUM_EXP
	SQL_FN_NUM_FLOOR
	SQL_FN_NUM_LOG
	SQL_FN_NUM_LOG10
	SQL_FN_NUM_MOD
	SQL_FN_NUM_PI
	SQL_FN_NUM_POWER
	SQL_FN_NUM_RADIANS
	SQL_FN_NUM_RAND
	SQL_FN_NUM_ROUND
	SQL_FN_NUM_SIGN
	SQL_FN_NUM_SIN
	SQL_FN_NUM_SQRT
	SQL_FN_NUM_TAN
	SQL_FN_NUM_TRUNCATE
	SQL_FN_STR_ASCII
	SQL_FN_STR_CHAR
	SQL_FN_STR_CONCAT
	SQL_FN_STR_DIFFERENCE
	SQL_FN_STR_INSERT
	SQL_FN_STR_LCASE
	SQL_FN_STR_LEFT
	SQL_FN_STR_LENGTH
	SQL_FN_STR_LOCATE
	SQL_FN_STR_LOCATE_2
	SQL_FN_STR_LTRIM
	SQL_FN_STR_REPEAT
	SQL_FN_STR_REPLACE
	SQL_FN_STR_RIGHT
	SQL_FN_STR_RTRIM
	SQL_FN_STR_SOUNDEX
	SQL_FN_STR_SPACE
	SQL_FN_STR_SUBSTRING
	SQL_FN_STR_UCASE
	SQL_FN_SYS_DBNAME
	SQL_FN_SYS_IFNULL
	SQL_FN_SYS_USERNAME
	SQL_FN_TD_CURDATE
	SQL_FN_TD_CURTIME
	SQL_FN_TD_DAYNAME
	SQL_FN_TD_DAYOFMONTH
	SQL_FN_TD_DAYOFWEEK
	SQL_FN_TD_DAYOFYEAR
	SQL_FN_TD_HOUR
	SQL_FN_TD_MINUTE
	SQL_FN_TD_MONTH
	SQL_FN_TD_MONTHNAME
	SQL_FN_TD_NOW
	SQL_FN_TD_QUARTER
	SQL_FN_TD_SECOND
	SQL_FN_TD_TIMESTAMPADD
	SQL_FN_TD_TIMESTAMPDIFF
	SQL_FN_TD_WEEK
	SQL_FN_TD_YEAR
	SQL_FN_TSI_DAY
	SQL_FN_TSI_FRAC_SECOND
	SQL_FN_TSI_HOUR
	SQL_FN_TSI_MINUTE
	SQL_FN_TSI_MONTH
	SQL_FN_TSI_QUARTER
	SQL_FN_TSI_SECOND
	SQL_FN_TSI_WEEK
	SQL_FN_TSI_YEAR
	SQL_GB_GROUP_BY_CONTAINS_SELECT
	SQL_GB_GROUP_BY_EQUALS_SELECT
	SQL_GB_NOT_SUPPORTED
	SQL_GB_NO_RELATION
	SQL_GD_ANY_COLUMN
	SQL_GD_ANY_ORDER
	SQL_GD_BLOCK
	SQL_GD_BOUND
	SQL_GETDATA_EXTENSIONS
	SQL_GET_BOOKMARK
	SQL_GROUP_BY
	SQL_IC_LOWER
	SQL_IC_MIXED
	SQL_IC_SENSITIVE
	SQL_IC_UPPER
	SQL_IDENTIFIER_CASE
	SQL_IDENTIFIER_QUOTE_CHAR
	SQL_IGNORE
	SQL_INDEX_ALL
	SQL_INDEX_CLUSTERED
	SQL_INDEX_HASHED
	SQL_INDEX_OTHER
	SQL_INDEX_UNIQUE
	SQL_INFO_DRIVER_START
	SQL_INFO_FIRST
	SQL_INFO_LAST
	SQL_INVALID_HANDLE
	SQL_KEYSET_SIZE
	SQL_KEYSET_SIZE_DEFAULT
	SQL_KEYWORDS
	SQL_LCK_EXCLUSIVE
	SQL_LCK_NO_CHANGE
	SQL_LCK_UNLOCK
	SQL_LEN_DATA_AT_EXEC_OFFSET
	SQL_LIKE_ESCAPE_CLAUSE
	SQL_LIKE_ONLY
	SQL_LOCK_EXCLUSIVE
	SQL_LOCK_NO_CHANGE
	SQL_LOCK_TYPES
	SQL_LOCK_UNLOCK
	SQL_LOGIN_TIMEOUT
	SQL_LOGIN_TIMEOUT_DEFAULT
	SQL_LONGVARBINARY
	SQL_LONGVARCHAR
	SQL_MAX_BINARY_LITERAL_LEN
	SQL_MAX_CHAR_LITERAL_LEN
	SQL_MAX_COLUMNS_IN_GROUP_BY
	SQL_MAX_COLUMNS_IN_INDEX
	SQL_MAX_COLUMNS_IN_ORDER_BY
	SQL_MAX_COLUMNS_IN_SELECT
	SQL_MAX_COLUMNS_IN_TABLE
	SQL_MAX_COLUMN_NAME_LEN
	SQL_MAX_CURSOR_NAME_LEN
	SQL_MAX_DSN_LENGTH
	SQL_MAX_INDEX_SIZE
	SQL_MAX_LENGTH
	SQL_MAX_LENGTH_DEFAULT
	SQL_MAX_MESSAGE_LENGTH
	SQL_MAX_OPTION_STRING_LENGTH
	SQL_MAX_OWNER_NAME_LEN
	SQL_MAX_PROCEDURE_NAME_LEN
	SQL_MAX_QUALIFIER_NAME_LEN
	SQL_MAX_ROWS
	SQL_MAX_ROWS_DEFAULT
	SQL_MAX_ROW_SIZE
	SQL_MAX_ROW_SIZE_INCLUDES_LONG
	SQL_MAX_STATEMENT_LEN
	SQL_MAX_TABLES_IN_SELECT
	SQL_MAX_TABLE_NAME_LEN
	SQL_MAX_USER_NAME_LEN
	SQL_MODE_DEFAULT
	SQL_MODE_READ_ONLY
	SQL_MODE_READ_WRITE
	SQL_MULTIPLE_ACTIVE_TXN
	SQL_MULT_RESULT_SETS
	SQL_NC_END
	SQL_NC_HIGH
	SQL_NC_LOW
	SQL_NC_START
	SQL_NEED_DATA
	SQL_NEED_LONG_DATA_LEN
	SQL_NNC_NON_NULL
	SQL_NNC_NULL
	SQL_NON_NULLABLE_COLUMNS
	SQL_NOSCAN
	SQL_NOSCAN_DEFAULT
	SQL_NOSCAN_OFF
	SQL_NOSCAN_ON
	SQL_NO_CONVERT
	SQL_NO_DATA_FOUND
	SQL_NO_NULLS
	SQL_NO_TOTAL
	SQL_NTS
	SQL_NULLABLE
	SQL_NULLABLE_UNKNOWN
	SQL_NULL_COLLATION
	SQL_NULL_DATA
	SQL_NULL_HDBC
	SQL_NULL_HENV
	SQL_NULL_HSTMT
	SQL_NUMERIC
	SQL_NUMERIC_FUNCTIONS
	SQL_NUM_EXTENSIONS
	SQL_NUM_FUNCTIONS
	SQL_OAC_LEVEL1
	SQL_OAC_LEVEL2
	SQL_OAC_NONE
	SQL_ODBC_API_CONFORMANCE
	SQL_ODBC_CURSORS
	SQL_ODBC_KEYWORDS
	SQL_ODBC_SAG_CLI_CONFORMANCE
	SQL_ODBC_SQL_CONFORMANCE
	SQL_ODBC_SQL_OPT_IEF
	SQL_ODBC_VER
	SQL_OJ_ALL_COMPARISON_OPS
	SQL_OJ_CAPABILITIES
	SQL_OJ_FULL
	SQL_OJ_INNER
	SQL_OJ_LEFT
	SQL_OJ_NESTED
	SQL_OJ_NOT_ORDERED
	SQL_OJ_RIGHT
	SQL_OPT_TRACE
	SQL_OPT_TRACEFILE
	SQL_OPT_TRACE_DEFAULT
	SQL_OPT_TRACE_FILE_DEFAULT
	SQL_OPT_TRACE_OFF
	SQL_OPT_TRACE_ON
	SQL_ORDER_BY_COLUMNS_IN_SELECT
	SQL_OSCC_COMPLIANT
	SQL_OSCC_NOT_COMPLIANT
	SQL_OSC_CORE
	SQL_OSC_EXTENDED
	SQL_OSC_MINIMUM
	SQL_OUTER_JOINS
	SQL_OU_DML_STATEMENTS
	SQL_OU_INDEX_DEFINITION
	SQL_OU_PRIVILEGE_DEFINITION
	SQL_OU_PROCEDURE_INVOCATION
	SQL_OU_TABLE_DEFINITION
	SQL_OWNER_TERM
	SQL_OWNER_USAGE
	SQL_PACKET_SIZE
	SQL_PARAM_INPUT
	SQL_PARAM_INPUT_OUTPUT
	SQL_PARAM_OUTPUT
	SQL_PARAM_TYPE_DEFAULT
	SQL_PARAM_TYPE_UNKNOWN
	SQL_PC_NON_PSEUDO
	SQL_PC_PSEUDO
	SQL_PC_UNKNOWN
	SQL_POSITION
	SQL_POSITIONED_STATEMENTS
	SQL_POS_ADD
	SQL_POS_DELETE
	SQL_POS_OPERATIONS
	SQL_POS_POSITION
	SQL_POS_REFRESH
	SQL_POS_UPDATE
	SQL_PROCEDURES
	SQL_PROCEDURE_TERM
	SQL_PS_POSITIONED_DELETE
	SQL_PS_POSITIONED_UPDATE
	SQL_PS_SELECT_FOR_UPDATE
	SQL_PT_FUNCTION
	SQL_PT_PROCEDURE
	SQL_PT_UNKNOWN
	SQL_QL_END
	SQL_QL_START
	SQL_QUALIFIER_LOCATION
	SQL_QUALIFIER_NAME_SEPARATOR
	SQL_QUALIFIER_TERM
	SQL_QUALIFIER_USAGE
	SQL_QUERY_TIMEOUT
	SQL_QUERY_TIMEOUT_DEFAULT
	SQL_QUICK
	SQL_QUIET_MODE
	SQL_QUOTED_IDENTIFIER_CASE
	SQL_QU_DML_STATEMENTS
	SQL_QU_INDEX_DEFINITION
	SQL_QU_PRIVILEGE_DEFINITION
	SQL_QU_PROCEDURE_INVOCATION
	SQL_QU_TABLE_DEFINITION
	SQL_RD_DEFAULT
	SQL_RD_OFF
	SQL_RD_ON
	SQL_REAL
	SQL_REFRESH
	SQL_RESET_PARAMS
	SQL_RESTRICT
	SQL_RESULT_COL
	SQL_RETRIEVE_DATA
	SQL_ROLLBACK
	SQL_ROWSET_SIZE
	SQL_ROWSET_SIZE_DEFAULT
	SQL_ROWVER
	SQL_ROW_ADDED
	SQL_ROW_DELETED
	SQL_ROW_ERROR
	SQL_ROW_NOROW
	SQL_ROW_NUMBER
	SQL_ROW_SUCCESS
	SQL_ROW_UPDATED
	SQL_ROW_UPDATES
	SQL_SCCO_LOCK
	SQL_SCCO_OPT_ROWVER
	SQL_SCCO_OPT_TIMESTAMP
	SQL_SCCO_OPT_VALUES
	SQL_SCCO_READ_ONLY
	SQL_SCOPE_CURROW
	SQL_SCOPE_SESSION
	SQL_SCOPE_TRANSACTION
	SQL_SCROLL_CONCURRENCY
	SQL_SCROLL_DYNAMIC
	SQL_SCROLL_FORWARD_ONLY
	SQL_SCROLL_KEYSET_DRIVEN
	SQL_SCROLL_OPTIONS
	SQL_SCROLL_STATIC
	SQL_SC_NON_UNIQUE
	SQL_SC_TRY_UNIQUE
	SQL_SC_UNIQUE
	SQL_SEARCHABLE
	SQL_SEARCH_PATTERN_ESCAPE
	SQL_SERVER_NAME
	SQL_SETPARAM_VALUE_MAX
	SQL_SET_NULL
	SQL_SIGNED_OFFSET
	SQL_SIMULATE_CURSOR
	SQL_SMALLINT
	SQL_SOLID_XLATOPT_7BITSCAND
	SQL_SOLID_XLATOPT_ANSI
	SQL_SOLID_XLATOPT_DEFAULT
	SQL_SOLID_XLATOPT_NOCNV
	SQL_SOLID_XLATOPT_PCOEM
	SQL_SO_DYNAMIC
	SQL_SO_FORWARD_ONLY
	SQL_SO_KEYSET_DRIVEN
	SQL_SO_MIXED
	SQL_SO_STATIC
	SQL_SPECIAL_CHARACTERS
	SQL_SPEC_MAJOR
	SQL_SPEC_MINOR
	SQL_SPEC_STRING
	SQL_SQLSTATE_SIZE
	SQL_SQ_COMPARISON
	SQL_SQ_CORRELATED_SUBQUERIES
	SQL_SQ_EXISTS
	SQL_SQ_IN
	SQL_SQ_QUANTIFIED
	SQL_SS_ADDITIONS
	SQL_SS_DELETIONS
	SQL_SS_UPDATES
	SQL_STATIC_SENSITIVITY
	SQL_STILL_EXECUTING
	SQL_STMT_OPT_MAX
	SQL_STMT_OPT_MIN
	SQL_STRING_FUNCTIONS
	SQL_SUBQUERIES
	SQL_SUCCESS
	SQL_SUCCESS_WITH_INFO
	SQL_SYSTEM_FUNCTIONS
	SQL_TABLE_STAT
	SQL_TABLE_TERM
	SQL_TC_ALL
	SQL_TC_DDL_COMMIT
	SQL_TC_DDL_IGNORE
	SQL_TC_DML
	SQL_TC_NONE
	SQL_TIME
	SQL_TIMEDATE_ADD_INTERVALS
	SQL_TIMEDATE_DIFF_INTERVALS
	SQL_TIMEDATE_FUNCTIONS
	SQL_TIMESTAMP
	SQL_TINYINT
	SQL_TRANSLATE_DLL
	SQL_TRANSLATE_OPTION
	SQL_TXN_CAPABLE
	SQL_TXN_ISOLATION
	SQL_TXN_ISOLATION_OPTION
	SQL_TXN_READ_COMMITTED
	SQL_TXN_READ_UNCOMMITTED
	SQL_TXN_REPEATABLE_READ
	SQL_TXN_SERIALIZABLE
	SQL_TXN_VERSIONING
	SQL_TYPE_MAX
	SQL_TYPE_MIN
	SQL_UB_DEFAULT
	SQL_UB_OFF
	SQL_UB_ON
	SQL_UNBIND
	SQL_UNION
	SQL_UNSEARCHABLE
	SQL_UNSIGNED_OFFSET
	SQL_UPDATE
	SQL_USER_NAME
	SQL_USE_BOOKMARKS
	SQL_U_UNION
	SQL_U_UNION_ALL
	SQL_VARBINARY
	SQL_VARCHAR
	SQL_INTEGER
   SQL_WCHAR
   SQL_WVARCHAR
   SQL_WLONGVARCHAR
);

# Autoload methods go after __END__, and are processed by the autosplit program.
sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.  If a constant is not found then control is passed
    # to the AUTOLOAD in AutoLoader.

    my $constname;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    my $val = constant($constname, @_ ? $_[0] : 0);
    if ($! != 0) {
	if ($! =~ /Invalid/) {
	    $AutoLoader::AUTOLOAD = $AUTOLOAD;
	    goto &AutoLoader::AUTOLOAD;
	}
	else {
		croak "DBD::Solid::Const macro $constname is undefined.";
	}
    }
    eval "sub $AUTOLOAD { $val }";
    goto &$AUTOLOAD;
}

bootstrap DBD::Solid::Const $VERSION;

# Preloaded methods go here.

# Autoload methods go after _=cut, and are processed by the autosplit program.

1;
__END__
# Below is the stub of documentation for your module. You better edit it!

=head1 NAME

DBD::Solid::Const - Constansts for DBD::Solid Perl extension 

=head1 SYNOPSIS

  use DBD::Solid::Const qw(:sql_types);

  if ($sth->{TYPE}->[5] == SQL_LONGVARCHAR) {
      do_something_very_different;
      }

=head1 DESCRIPTION

This module import some of the constants used by DBD::Solid into
your namespace. This is useful for querying some of the values
returned by the DBD::Solid interface.

=head1 AUTHOR

T.Wenrich, wenrich@ping.at

=head1 SEE ALSO

perl(1), DBD::Solid(perldoc), DBI, Exporter(perldoc)

=cut

