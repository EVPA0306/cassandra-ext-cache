INSERT INTO dvr.extstbmetadata (lineupid,channelnumber,starttime,endtime,metadata,seriesid,tmsprgid)
VALUES ('1106',3,1523469511000,1523555911000,'{"episodeTitle":"Breaking Bad","seasonNumber":0,"tvRating":"TVPG"}','SH00380341001','SH015547980001');

UPDATE dvr.extstbmetadata SET metadata = '{"episodeTitle":"Continuum"}' WHERE lineupid = '1015' AND channelnumber = 2 AND starttime = 1432811065000;

DELETE FROM dvr.extstbmetadata WHERE lineupid = '1106' AND channelnumber = 3 AND starttime = 1523469511000;