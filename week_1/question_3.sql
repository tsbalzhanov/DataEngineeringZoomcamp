SELECT COUNT(*) FROM trips WHERE DATE(lpep_pickup_datetime) = DATE '2019-09-18' AND DATE(lpep_dropoff_datetime) = DATE '2019-09-18';
