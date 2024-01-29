SELECT pickup_date, MAX(trip_distance) AS max_trip_distance FROM (
    SELECT DATE(lpep_pickup_datetime) AS pickup_date, trip_distance FROM trips
) GROUP BY pickup_date ORDER BY max_trip_distance DESC;
