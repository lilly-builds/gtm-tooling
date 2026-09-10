-- Purpose: bootstrap the isolated ClickHouse warehouse namespace used by the
-- EAS Builds Dev RudderStack destination.
--
-- Execution contract:
-- - This file contains no password and must remain safe to commit.
-- - The runner substitutes RUDDERSTACK_LOADER_PASSWORD only in memory.
-- - Run once against the intended ClickHouse Cloud service after review.
-- - Do not use this user for human/admin work.

CREATE DATABASE IF NOT EXISTS eas_plg;

CREATE USER IF NOT EXISTS rudderstack_loader
IDENTIFIED BY '{RUDDERSTACK_LOADER_PASSWORD:String}';

-- Required by RudderStack's documented ClickHouse warehouse setup.
GRANT SELECT ON system.databases TO rudderstack_loader;
GRANT SELECT ON system.columns TO rudderstack_loader;

-- Scope powerful table-management permissions to this dedicated database.
GRANT SELECT, INSERT, ALTER TABLE, CREATE DATABASE, CREATE TABLE, DROP TABLE
ON eas_plg.* TO rudderstack_loader;
