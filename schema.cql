CREATE KEYSPACE audit WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : '1' };

DROP TABLE IF EXISTS audit.audit;

CREATE TABLE audit.audit (key timeuuid
    , keyspace_name text
    , table_name text
    , primary_key text
    , key_val text
    , PRIMARY KEY(key));

DROP TRIGGER IF EXISTS logger ON dvr.stb;

DROP TRIGGER IF EXISTS logger ON dvr.recordings;

CREATE TRIGGER IF NOT EXISTS logger ON dvr.recordings USING 'org.apache.cassandra.triggers.SendMessageTrigger';
CREATE TRIGGER IF NOT EXISTS logger ON dvr.extstbmetadata USING 'org.apache.cassandra.triggers.SendMessageTrigger';
CREATE TRIGGER IF NOT EXISTS logger ON dvr.stb USING 'org.apache.cassandra.triggers.SendMessageTrigger';