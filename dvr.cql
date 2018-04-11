DROP KEYSPACE IF EXISTS dvr;
CREATE KEYSPACE dvr WITH replication = {
	'class': 'SimpleStrategy',
	'replication_factor': '2'
};

USE dvr;
DROP TABLE IF EXISTS deleterecordingshistory;
CREATE TABLE deleterecordingshistory (
  deviceid text,
  recordingid bigint,
  adddatacrc bigint,
  advisories int,
  bookmark int,
  bookmarktime timestamp,
  callsign text,
  cast text,
  channelid int,
  channelnumber int,
  dateofdeletion timestamp,
  deliveryid text,
  duplicate int,
  endoffset int,
  episodedef int,
  episodenum int,
  episodetitle text,
  genres text,
  groupid text,
  groupname text,
  images text,
  intstorage int,
  keepuntil int,
  longdescription text,
  metadatamask int,
  mpaarating int,
  prgdesc text,
  prgtmsid text,
  programtitle text,
  qualifiers int,
  recduration int,
  recend timestamp,
  recformat int,
  recordingcrc bigint,
  recstart timestamp,
  rectype int,
  repeat int,
  schduration int,
  schedulerid uuid,
  schend timestamp,
  schstart timestamp,
  seasonnum int,
  seriesid text,
  shortdescription text,
  startoffset int,
  status int,
  stbrecordingid bigint,
  team1id int,
  team1name text,
  team2id int,
  team2name text,
  tvrating int,
  lastupdated timestamp,
  PRIMARY KEY (deviceid, recordingid)
) WITH
  bloom_filter_fp_chance=0.010000 AND
  //caching='KEYS_ONLY' AND
  comment='' AND
  dclocal_read_repair_chance=0.000000 AND
  gc_grace_seconds=86400 AND
  //index_interval=128 AND
  read_repair_chance=0.100000 AND
  //replicate_on_write='true' AND
  //populate_io_cache_on_flush='false' AND
  default_time_to_live=0 AND
  speculative_retry='0.009899999999999999PERCENTILE' AND
  memtable_flush_period_in_ms=0 AND
  compaction={'class': 'LeveledCompactionStrategy'} AND
  compression={'sstable_compression': 'LZ4Compressor'};

DROP TABLE IF EXISTS extcrcdata;
CREATE TABLE extcrcdata (
  adddatacrc bigint,
  metadata text,
  PRIMARY KEY (adddatacrc)
) WITH
  bloom_filter_fp_chance=0.010000 AND
  //caching='KEYS_ONLY' AND
  comment='' AND
  dclocal_read_repair_chance=0.000000 AND
  gc_grace_seconds=864000 AND
  //index_interval=128 AND
  read_repair_chance=0.100000 AND
  //replicate_on_write='true' AND
  //populate_io_cache_on_flush='false' AND
  default_time_to_live=0 AND
  speculative_retry='0.009899999999999999PERCENTILE' AND
  memtable_flush_period_in_ms=0 AND
  compaction={'class': 'LeveledCompactionStrategy'} AND
  compression={'sstable_compression': 'LZ4Compressor'};

DROP TABLE IF EXISTS extmetadatabychanneltimeslot;
CREATE TABLE extmetadatabychanneltimeslot (
  tmschannelsourceid text,
  starttime timestamp,
  endtime timestamp,
  metadata text,
  seriesid text,
  tmsprgid text,
  PRIMARY KEY (tmschannelsourceid, starttime, endtime)
) WITH
  bloom_filter_fp_chance=0.010000 AND
  //caching='KEYS_ONLY' AND
  comment='' AND
  dclocal_read_repair_chance=0.000000 AND
  gc_grace_seconds=864000 AND
  //index_interval=128 AND
  read_repair_chance=0.100000 AND
  //replicate_on_write='true' AND
  //populate_io_cache_on_flush='false' AND
  default_time_to_live=0 AND
  speculative_retry='99.0PERCENTILE' AND
  memtable_flush_period_in_ms=0 AND
  compaction={'class': 'LeveledCompactionStrategy'} AND
  compression={'sstable_compression': 'LZ4Compressor'};

DROP TABLE IF EXISTS extmetadatabytmsprgid;
CREATE TABLE extmetadatabytmsprgid (
  tmsprgid text,
  seriesid text,
  metadata text,
  PRIMARY KEY (tmsprgid, seriesid)
) WITH
  bloom_filter_fp_chance=0.010000 AND
  //caching='KEYS_ONLY' AND
  comment='' AND
  dclocal_read_repair_chance=0.000000 AND
  gc_grace_seconds=864000 AND
  //index_interval=128 AND
  read_repair_chance=0.100000 AND
  //replicate_on_write='true' AND
  //populate_io_cache_on_flush='false' AND
  default_time_to_live=0 AND
  speculative_retry='99.0PERCENTILE' AND
  memtable_flush_period_in_ms=0 AND
  compaction={'class': 'LeveledCompactionStrategy'} AND
  compression={'sstable_compression': 'LZ4Compressor'};

DROP TABLE IF EXISTS extmetadataupdate;
CREATE TABLE extmetadataupdate (
  deviceid text,
  recordingid bigint,
  entrytime timestamp,
  PRIMARY KEY (deviceid, recordingid)
) WITH
  bloom_filter_fp_chance=0.010000 AND
  //caching='KEYS_ONLY' AND
  comment='' AND
  dclocal_read_repair_chance=0.000000 AND
  gc_grace_seconds=864000 AND
  //index_interval=128 AND
  read_repair_chance=0.100000 AND
  //replicate_on_write='true' AND
  //populate_io_cache_on_flush='false' AND
  default_time_to_live=0 AND
  speculative_retry='99.0PERCENTILE' AND
  memtable_flush_period_in_ms=0 AND
  compaction={'class': 'LeveledCompactionStrategy'} AND
  compression={'sstable_compression': 'LZ4Compressor'};

DROP TABLE IF EXISTS extstbmetadata;
CREATE TABLE extstbmetadata (
  lineupid text,
  channelnumber int,
  starttime timestamp,
  endtime timestamp,
  metadata text,
  seriesid text,
  tmsprgid text,
  PRIMARY KEY (lineupid, channelnumber, starttime)
) WITH
  bloom_filter_fp_chance=0.010000 AND
  //caching='KEYS_ONLY' AND
  comment='' AND
  dclocal_read_repair_chance=0.000000 AND
  gc_grace_seconds=864000 AND
  //index_interval=128 AND
  read_repair_chance=0.100000 AND
  //replicate_on_write='true' AND
  //populate_io_cache_on_flush='false' AND
  default_time_to_live=0 AND
  speculative_retry='0.009899999999999999PERCENTILE' AND
  memtable_flush_period_in_ms=0 AND
  compaction={'class': 'LeveledCompactionStrategy'} AND
  compression={'sstable_compression': 'LZ4Compressor'};

DROP TABLE IF EXISTS exttmsdata;
CREATE TABLE exttmsdata (
  prgtmsid text,
  metadata text,
  PRIMARY KEY (prgtmsid)
) WITH
  bloom_filter_fp_chance=0.010000 AND
  //caching='KEYS_ONLY' AND
  comment='' AND
  dclocal_read_repair_chance=0.000000 AND
  gc_grace_seconds=864000 AND
  //index_interval=128 AND
  read_repair_chance=0.100000 AND
  //replicate_on_write='true' AND
  //populate_io_cache_on_flush='false' AND
  default_time_to_live=0 AND
  speculative_retry='0.009899999999999999PERCENTILE' AND
  memtable_flush_period_in_ms=0 AND
  compaction={'class': 'LeveledCompactionStrategy'} AND
  compression={'sstable_compression': 'LZ4Compressor'};

DROP TABLE IF EXISTS lineupconfig;
CREATE TABLE lineupconfig (
  url text,
  cassandraprops text,
  PRIMARY KEY (url)
) WITH
  bloom_filter_fp_chance=0.010000 AND
  //caching='KEYS_ONLY' AND
  comment='' AND
  dclocal_read_repair_chance=0.000000 AND
  gc_grace_seconds=864000 AND
  //index_interval=128 AND
  read_repair_chance=0.100000 AND
  //replicate_on_write='true' AND
  //populate_io_cache_on_flush='false' AND
  default_time_to_live=0 AND
  speculative_retry='99.0PERCENTILE' AND
  memtable_flush_period_in_ms=0 AND
  compaction={'class': 'SizeTieredCompactionStrategy'} AND
  compression={'sstable_compression': 'LZ4Compressor'};

DROP TABLE IF EXISTS recentlyrecorded;
CREATE TABLE recentlyrecorded (
  recstart timestamp,
  accountnumber text,
  deviceid text,
  prgtmsid text,
  recordingid bigint,
  recordingtype int,
  PRIMARY KEY (recstart)
) WITH
  bloom_filter_fp_chance=0.010000 AND
  //caching='KEYS_ONLY' AND
  comment='' AND
  dclocal_read_repair_chance=0.000000 AND
  gc_grace_seconds=864000 AND
  //index_interval=128 AND
  read_repair_chance=0.100000 AND
  //replicate_on_write='true' AND
  //populate_io_cache_on_flush='false' AND
  default_time_to_live=0 AND
  speculative_retry='99.0PERCENTILE' AND
  memtable_flush_period_in_ms=0 AND
  compaction={'class': 'LeveledCompactionStrategy'} AND
  compression={'sstable_compression': 'LZ4Compressor'};

DROP TABLE IF EXISTS recentlyscheduled;
CREATE TABLE recentlyscheduled (
  scheduletime timestamp,
  accountnumber text,
  deviceid text,
  prgtmsid text,
  recordingid bigint,
  recordingtype int,
  PRIMARY KEY (scheduletime)
) WITH
  bloom_filter_fp_chance=0.010000 AND
  //caching='KEYS_ONLY' AND
  comment='' AND
  dclocal_read_repair_chance=0.000000 AND
  gc_grace_seconds=864000 AND
  //index_interval=128 AND
  read_repair_chance=0.100000 AND
  //replicate_on_write='true' AND
  //populate_io_cache_on_flush='false' AND
  default_time_to_live=0 AND
  speculative_retry='99.0PERCENTILE' AND
  memtable_flush_period_in_ms=0 AND
  compaction={'class': 'LeveledCompactionStrategy'} AND
  compression={'sstable_compression': 'LZ4Compressor'};

DROP TABLE IF EXISTS recordings;
CREATE TABLE recordings (
  deviceid text,
  recordingid bigint,
  adddatacrc bigint,
  advisories int,
  bookmark int,
  bookmarktime timestamp,
  callsign text,
  cast text,
  channelid int,
  channelnumber int,
  deliveryid text,
  duplicate int,
  endoffset int,
  episodedef int,
  episodenum int,
  episodetitle text,
  genres text,
  groupid text,
  groupname text,
  images text,
  intstorage int,
  keepuntil int,
  longdescription text,
  metadatamask int,
  mpaarating int,
  prgdesc text,
  prgtmsid text,
  programtitle text,
  qualifiers int,
  recduration int,
  recend timestamp,
  recformat int,
  recordingcrc bigint,
  recstart timestamp,
  rectype int,
  repeat int,
  schduration int,
  schedulerid uuid,
  schend timestamp,
  schstart timestamp,
  seasonnum int,
  seriesid text,
  shortdescription text,
  startoffset int,
  status int,
  team1id int,
  team1name text,
  team2id int,
  team2name text,
  tvrating int,
  lastupdated timestamp,
  PRIMARY KEY (deviceid, recordingid)
) WITH
  bloom_filter_fp_chance=0.010000 AND
  //caching='KEYS_ONLY' AND
  comment='' AND
  dclocal_read_repair_chance=0.000000 AND
  gc_grace_seconds=86400 AND
  //index_interval=128 AND
  read_repair_chance=0.100000 AND
  //replicate_on_write='true' AND
  //populate_io_cache_on_flush='false' AND
  default_time_to_live=0 AND
  speculative_retry='99.0PERCENTILE' AND
  memtable_flush_period_in_ms=0 AND
  compaction={'class': 'LeveledCompactionStrategy'} AND
  compression={'sstable_compression': 'LZ4Compressor'};

DROP TABLE IF EXISTS recordingshistory;
CREATE TABLE recordingshistory (
  deviceid text,
  starttime timestamp,
  recordingid bigint,
  PRIMARY KEY (deviceid, starttime)
) WITH
  bloom_filter_fp_chance=0.010000 AND
  //caching='KEYS_ONLY' AND
  comment='' AND
  dclocal_read_repair_chance=0.000000 AND
  gc_grace_seconds=864000 AND
  //index_interval=128 AND
  read_repair_chance=0.100000 AND
  //replicate_on_write='true' AND
  //populate_io_cache_on_flush='false' AND
  default_time_to_live=0 AND
  speculative_retry='99.0PERCENTILE' AND
  memtable_flush_period_in_ms=0 AND
  compaction={'class': 'LeveledCompactionStrategy'} AND
  compression={'sstable_compression': 'LZ4Compressor'};

DROP TABLE IF EXISTS recordingsviewinghistory;
CREATE TABLE recordingsviewinghistory (
  deviceid text,
  bookmarktime timestamp,
  recordingid bigint,
  PRIMARY KEY (deviceid, bookmarktime)
) WITH
  bloom_filter_fp_chance=0.010000 AND
  //caching='KEYS_ONLY' AND
  comment='' AND
  dclocal_read_repair_chance=0.000000 AND
  gc_grace_seconds=864000 AND
  //index_interval=128 AND
  read_repair_chance=0.100000 AND
  //replicate_on_write='true' AND
  //populate_io_cache_on_flush='false' AND
  default_time_to_live=0 AND
  speculative_retry='99.0PERCENTILE' AND
  memtable_flush_period_in_ms=0 AND
  compaction={'class': 'LeveledCompactionStrategy'} AND
  compression={'sstable_compression': 'LZ4Compressor'};

DROP TABLE IF EXISTS scheduler;
CREATE TABLE scheduler (
  deviceid text,
  schedulerid uuid,
  callsign text,
  channelid int,
  channelnumber int,
  deliveryid text,
  duplicate int,
  endoffset int,
  episodedefinition int,
  groupid text,
  groupname text,
  keepuntil int,
  recordingformat int,
  recordingtype int,
  repeat int,
  scheduleendtime timestamp,
  schedulestarttime timestamp,
  seriesidentifier text,
  startoffset int,
  PRIMARY KEY (deviceid, schedulerid)
) WITH
  bloom_filter_fp_chance=0.010000 AND
  //caching='KEYS_ONLY' AND
  comment='' AND
  dclocal_read_repair_chance=0.000000 AND
  gc_grace_seconds=864000 AND
  //index_interval=128 AND
  read_repair_chance=0.100000 AND
  //replicate_on_write='true' AND
  //populate_io_cache_on_flush='false' AND
  default_time_to_live=0 AND
  speculative_retry='99.0PERCENTILE' AND
  memtable_flush_period_in_ms=0 AND
  compaction={'class': 'LeveledCompactionStrategy'} AND
  compression={'sstable_compression': 'LZ4Compressor'};

DROP TABLE IF EXISTS schedulerequests;
CREATE TABLE schedulerequests (
  accountnumber text,
  deviceid text,
  amsstatus boolean,
  callsign text,
  channelid int,
  channelnumber text,
  deliveryid text,
  duplicate int,
  endoffset int,
  episodenumber text,
  episodetitle text,
  keepuntil int,
  newonly text,
  priority text,
  programid text,
  recordingtype int,
  repeat int,
  scheduleendtime timestamp,
  schedulestarttime timestamp,
  seasonnumber text,
  seriesidentifier text,
  startoffset int,
  title text,
  PRIMARY KEY (accountnumber, deviceid)
) WITH
  bloom_filter_fp_chance=0.010000 AND
  //caching='KEYS_ONLY' AND
  comment='' AND
  dclocal_read_repair_chance=0.000000 AND
  gc_grace_seconds=864000 AND
  //index_interval=128 AND
  read_repair_chance=0.100000 AND
  //replicate_on_write='true' AND
  //populate_io_cache_on_flush='false' AND
  default_time_to_live=0 AND
  speculative_retry='99.0PERCENTILE' AND
  memtable_flush_period_in_ms=0 AND
  compaction={'class': 'LeveledCompactionStrategy'} AND
  compression={'sstable_compression': 'LZ4Compressor'};

DROP TABLE IF EXISTS stb;
CREATE TABLE stb (
  deviceid text,
  checksumrecorded bigint,
  checksumscheduled bigint,
  hddspaceextfree int,
  hddspaceexttotal int,
  hddspacefreein2weeks int,
  hddspaceinternalfree int,
  hddspaceinternaltotal int,
  lastrequesttime timestamp,
  lastupdated timestamp,
  priorityvector text,
  seriesschedulerpriorityvector text,
  PRIMARY KEY (deviceid)
) WITH
  bloom_filter_fp_chance=0.010000 AND
  //caching='KEYS_ONLY' AND
  comment='' AND
  dclocal_read_repair_chance=0.000000 AND
  gc_grace_seconds=864000 AND
  //index_interval=128 AND
  read_repair_chance=0.100000 AND
  //replicate_on_write='true' AND
  //populate_io_cache_on_flush='false' AND
  default_time_to_live=0 AND
  speculative_retry='0.009899999999999999PERCENTILE' AND
  memtable_flush_period_in_ms=0 AND
  compaction={'class': 'LeveledCompactionStrategy'} AND
  compression={'sstable_compression': 'LZ4Compressor'};

DROP TABLE IF EXISTS stblineup;
CREATE TABLE stblineup (
  deviceid text,
  lineupid text,
  PRIMARY KEY (deviceid)
) WITH
  bloom_filter_fp_chance=0.010000 AND
  //caching='KEYS_ONLY' AND
  comment='' AND
  dclocal_read_repair_chance=0.000000 AND
  gc_grace_seconds=864000 AND
  //index_interval=128 AND
  read_repair_chance=0.100000 AND
  //replicate_on_write='true' AND
  //populate_io_cache_on_flush='false' AND
  default_time_to_live=0 AND
  speculative_retry='0.009899999999999999PERCENTILE' AND
  memtable_flush_period_in_ms=0 AND
  compaction={'class': 'LeveledCompactionStrategy'} AND
  compression={'sstable_compression': 'LZ4Compressor'};

DROP TABLE IF EXISTS stbsyncdata;
CREATE TABLE stbsyncdata (
  deviceid text,
  syncendtime timestamp,
  syncstarttime timestamp,
  PRIMARY KEY (deviceid)
) WITH
  bloom_filter_fp_chance=0.010000 AND
  //caching='KEYS_ONLY' AND
  comment='' AND
  dclocal_read_repair_chance=0.000000 AND
  gc_grace_seconds=864000 AND
  //index_interval=128 AND
  read_repair_chance=0.100000 AND
  //replicate_on_write='true' AND
  //populate_io_cache_on_flush='false' AND
  default_time_to_live=0 AND
  speculative_retry='99.0PERCENTILE' AND
  memtable_flush_period_in_ms=0 AND
  compaction={'class': 'LeveledCompactionStrategy'} AND
  compression={'sstable_compression': 'LZ4Compressor'};

  CREATE TABLE stbprocessing (
    deviceid text,
    recordingid bigint,
    adddatacrc bigint,
    advisories int,
    bookmark int,
    bookmarktime timestamp,
    callsign text,
    cast text,
    channelid int,
    channelnumber int,
    deliveryid text,
    duplicate int,
    endoffset int,
    episodedef int,
    episodenum int,
    episodetitle text,
    genres text,
    groupid text,
    groupname text,
    images text,
    intstorage int,
    keepuntil int,
    longdescription text,
    metadatamask int,
    mpaarating int,
    prgdesc text,
    prgtmsid text,
    programtitle text,
    qualifiers int,
    recduration int,
    recend timestamp,
    recformat int,
    recordingcrc bigint,
    recstart timestamp,
    rectype int,
    repeat int,
    schduration int,
    schedulerid uuid,
    schend timestamp,
    schstart timestamp,
    seasonnum int,
    seriesid text,
    shortdescription text,
    startoffset int,
    status int,
    team1id int,
    team1name text,
    team2id int,
    team2name text,
    tvrating int,
    processingstatus int,
    lastupdated timestamp,
    PRIMARY KEY (deviceid,recordingid)
  ) WITH
    bloom_filter_fp_chance=0.010000 AND
    //caching='KEYS_ONLY' AND
    comment='' AND
    dclocal_read_repair_chance=0.000000 AND
    gc_grace_seconds=86400 AND
    //index_interval=128 AND
    read_repair_chance=0.100000 AND
    //replicate_on_write='true' AND
    //populate_io_cache_on_flush='false' AND
    default_time_to_live=0 AND
    speculative_retry='99.0PERCENTILE' AND
    memtable_flush_period_in_ms=0 AND
    compaction={'class': 'LeveledCompactionStrategy'} AND
    compression={'sstable_compression': 'LZ4Compressor'};

CREATE TABLE stb_schedule_processing (
    deviceid text,
    recordingid bigint,
    adddatacrc bigint,
    advisories int,
    bookmark int,
    bookmarktime timestamp,
    callsign text,
    cast text,
    channelid int,
    channelnumber int,
    deliveryid text,
    duplicate int,
    endoffset int,
    episodedef int,
    episodenum int,
    episodetitle text,
    genres text,
    groupid text,
    groupname text,
    images text,
    intstorage int,
    keepuntil int,
    longdescription text,
    metadatamask int,
    mpaarating int,
    prgdesc text,
    prgtmsid text,
    programtitle text,
    qualifiers int,
    recduration int,
    recend timestamp,
    recformat int,
    recordingcrc bigint,
    recstart timestamp,
    rectype int,
    repeat int,
    schduration int,
    schedulerid uuid,
    schend timestamp,
    schstart timestamp,
    seasonnum int,
    seriesid text,
    shortdescription text,
    startoffset int,
    status int,
    team1id int,
    team1name text,
    team2id int,
    team2name text,
    tvrating int,
    processingstatus int,
    lastupdated timestamp,
    PRIMARY KEY (deviceid,channelid,seriesid,prgtmsid,schstart)
  ) WITH
    bloom_filter_fp_chance=0.010000 AND
    //caching='KEYS_ONLY' AND
    comment='' AND
    dclocal_read_repair_chance=0.000000 AND
    gc_grace_seconds=86400 AND
    //index_interval=128 AND
    read_repair_chance=0.100000 AND
    //replicate_on_write='true' AND
    //populate_io_cache_on_flush='false' AND
    default_time_to_live=0 AND
    speculative_retry='99.0PERCENTILE' AND
    memtable_flush_period_in_ms=0 AND
    compaction={'class': 'LeveledCompactionStrategy'} AND
    compression={'sstable_compression': 'LZ4Compressor'};



INSERT INTO lineupconfig(url,cassandraprops) VALUES('http://spec.partnerapi.engprod-charter.net/api/pub/lineupmiddle/controllers/lineups', null);
INSERT INTO stblineup(deviceid,lineupid) values('000003A8BEA2', '1001');