-- SQL statements for pgsql generated by Tree::Numbered::Tools->outputSQL().
-- For details, check the Tree::Numbered::Tools documentation.
-- Comment out the 'DROP TABLE ...' statement if you don't want to delete an existing table.
-- Usage of this output:
-- Redirect this output to a file called, for example, 'insert-into-pgsql.sql':
-- outputSQL.pl pgsql > insert-into-pgsql.sql
-- Then run from the command line (assumes that the database 'test' already exists):
-- psql -q -U pgsql -d test -f insert-into-pgsql.sql
--
SET SESSION AUTHORIZATION 'pgsql';
SET search_path = "public", pg_catalog;
-- Definition
DROP INDEX IF EXISTS "treetest_serial_index";
DROP TABLE IF EXISTS "treetest";
CREATE TABLE "treetest" (
  "serial" integer,
  "parent" integer,
  "name" text,
  "url" text,
  "color" text,
  "permission" text,
  "visible" text
) WITH OIDS;
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  1, 0, 'ROOT', 'ROOT', 'ROOT', 'ROOT', 'ROOT'
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  2, 1, 'File', 'file.pl', '#000000', 'admin,joe,alice', ''
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  3, 2, 'New', 'file-new.pl', '#000000', 'admin', ''
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  4, 3, 'Window', 'file-window.pl', '#000033', 'admin', ''
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  5, 3, 'Document', 'file-document.pl', '#000033', 'admin', ''
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  6, 3, 'Template', 'file-new-template.pl', '#000033', 'admin,joe,alice', '1'
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  7, 6, 'HTML', 'file-new-template-html.pl', '#336699', 'admin,joe,alice', '1'
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  8, 2, 'Open', 'file-open.pl', '#000000', 'admin', '1'
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  9, 2, 'Save', 'file-save.pl', '#000000', 'admin', '1'
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  10, 2, 'Close', 'file-close.pl', '#000000', 'admin''s', ''
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  11, 2, 'Exit', 'file-exit.pl', '#000000', 'that''s mine', ''
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  12, 1, 'Edit', 'edit.pl', '#000000', 'this value is "quoted"', ''
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  13, 12, 'Undo', 'edit-undo.pl', '#000000', '', ''
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  14, 12, 'Cut', 'edit-cut.pl', '#000000', '', ''
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  15, 12, 'Copy', 'edit-copy.pl', '#000000', '', ''
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  16, 12, 'Paste', 'edit-paste.pl', '#000000', '', ''
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  17, 12, 'Find', 'edit-find.pl', '#000000', '', ''
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  18, 17, 'RegExp', 'edit-find-regexp.pl', '#000033', '', ''
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  19, 1, 'View', 'view.pl', '#000000', '', ''
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  20, 19, 'Toolbars', 'view-tb.pl', '#000000', '', ''
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  21, 20, 'Navigation', 'view-tb-navigation.pl', '#000033', '', ''
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  22, 20, 'Location', 'view-tb-location.pl', '#000033', '', ''
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  23, 20, 'Personal', 'view-tb-personal.pl', '#000033', '', ''
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  24, 19, 'Reload', 'view-reload.pl', '#000000', '', ''
);
INSERT INTO "treetest" ( "serial", "parent", "name", "url", "color", "permission", "visible" )
VALUES (
  25, 19, 'Source', 'view-source.pl', '#000000', '', ''
);
-- Indexes
CREATE UNIQUE INDEX treetest_serial_index ON treetest USING btree (serial);
