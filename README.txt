Cassandra Trigger Example:
==========================

The SendMessageTrigger class will create a basic audit of activity on a table.

Installation:
============
change directory to <cassandra_src_dir>/examples/triggers
run "ant jar"
Copy build/trigger-example.jar to <cassandra_conf>/triggers/
Copy conf/* to <cassandra_home>/conf/

Create the keyspace and table configured in AuditTrigger.properties:

    CREATE KEYSPACE test WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : '1' };

    CREATE KEYSPACE audit WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : '1' };

    CREATE TABLE test.audit (key timeuuid, keyspace_name text, table_name text, primary_key text, PRIMARY KEY(key));

    DROP TABLE audit.audit;
    CREATE TABLE audit.audit (key timeuuid
    , keyspace_name text
    , table_name text
    , primary_key text
    , key_val text
    , PRIMARY KEY(key));

Create a table to add the trigger to:
    CREATE TABLE test.test (key text, value text, PRIMARY KEY(key));
    Note: The example currently only handles non-composite partition keys

Configure the trigger on the table:
    CREATE TRIGGER IF NOT EXISTS test1 ON test.test USING 'org.apache.cassandra.triggers.AuditTrigger';

    CREATE TRIGGER IF NOT EXISTS test1 ON dvr.recordings USING 'org.apache.cassandra.triggers.AuditTrigger';

    DROP TRIGGER IF EXISTS logger ON dvr.stb;
    CREATE TRIGGER IF NOT EXISTS logger ON dvr.stb USING 'org.apache.cassandra.triggers.SendMessageTrigger';

Start inserting data to the table that has the trigger. For each
partition added to the table an entry should appear in the 'audit' table:
    INSERT INTO test.test (key, value) values ('1', '1');
    SELECT * FROM test.audit;

    key                                  | keyspace_name | primary_key | table_name
   --------------------------------------+---------------+-------------+------------
    7dc75b60-770f-11e5-9019-033d8af33e6f |          test |           1 |       test


SELECT * FROM system_schema.triggers;

INSERT INTO dvr.recordings(deviceid, recordingid) VALUES ('000003A8BEA2',384000004);

##Docker build
docker build -t cassandra-cache:latest .
##Docker run
docker run -p 9142:9042 cassandra-cache:latest