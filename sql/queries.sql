select stop_id, stop_sequence from gtfs_stop_times g where trip_id = (select trip_id from gtfs_stop_times where (stop_id = 'TRIAJ' and stop_sequence = 1) and (stop_id = 'LIVADA' and stop_sequence = (select max(stop_sequence) from gtfs_stop_times where trip_id = g.trip_id)) limit 1) order by stop_sequence;

select stop_id, stop_sequence from gtfs_stop_times g where trip_id = (select trip_id from gtfs_stop_times where (stop_id = 'TRIAJ' and stop_sequence = 1) and (stop_id = 'LIVADA' and stop_sequence = (select max(stop_sequence) from gtfs_stop_times where trip_id = g.trip_id)) limit 1) order by stop_sequence;

select stop_id, stop_sequence from gtfs_stop_times where stop_sequence = 1 and trip_id = (select trip_id from gtfs_stop_times where stop_id = 'TRIAJ' limit 1);

select stop_id, stop_sequence from gtfs_stop_times g where trip_id = (select trip_id from gtfs_stop_times where (stop_id = 'TRIAJ' and stop_sequence = 1) limit 1) order by stop_sequence;

select distinct g.stop_id as id,
            stop_name as name,
            stop_lat as latitude,
            stop_lon as longitude,
            stop_sequence as sequence from gtfs_bucuresti.gtfs_stop_times g join gtfs_bucuresti.gtfs_stops s on g.stop_id = s.stop_id
            where trip_id = (select trip_id from gtfs_bucuresti.gtfs_stop_times where (stop_id = '0' and stop_sequence = 0) limit 1) 
            order by stop_sequence
            
and arrival_time = '05:00:00'
            select * from gtfs_bucuresti.gtfs_stop_times where stop_id = '0'

            truncate gtfs_bucuresti.gtfs_stop_times cascade


            select * from gtfs_bucuresti.gtfs_stop_times where trip_id = '1' order by arrival_time

# FIXME: This doesn't work for stops which are not route start
select distinct g.stop_id as id,
stop_name as name,
stop_lat as latitude,
stop_lon as longitude,
stop_sequence as sequence from gtfs_bucuresti.gtfs_stop_times g join gtfs_bucuresti.gtfs_stops s on g.stop_id = s.stop_id
where trip_id = (select trip_id from gtfs_bucuresti.gtfs_stop_times where (stop_id = '1' and stop_sequence = 0) limit 1)
        order by stop_sequence;

        
SELECT distinct on (s.stop_id) s.stop_id as id, s.stop_name as name, case when upper(substr(s.stop_id, -2)) = '_I' then 'backward' else 'forward' end as direction, stop_lat as latitude, stop_lon as longitude from gtfs_bucuresti.gtfs_stop_times g join gtfs_bucuresti.gtfs_stops s on g.stop_id = s.stop_id where stop_sequence = 1 order by s.stop_id, stop_sequence
