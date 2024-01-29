SELECT tip_amount, "Zone" AS do_zone FROM (
    SELECT DATE(lpep_pickup_datetime) AS pickup_date, "DOLocationID", tip_amount FROM trips INNER JOIN zones ON(trips."PULocationID" = zones."LocationID") WHERE "Zone" = 'Astoria'
) AS trips INNER JOIN zones ON(trips."DOLocationID" = zones."LocationID") WHERE pickup_date >= DATE '2019-09-01' AND pickup_date < DATE '2019-10-01' ORDER BY tip_amount DESC;
