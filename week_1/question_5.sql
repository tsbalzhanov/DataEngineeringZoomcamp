SELECT "Borough", SUM(total_amount) AS sum_total_amount FROM (
    SELECT DATE(lpep_pickup_datetime) AS pickup_date, total_amount, "PULocationID", "Zone", "Borough" FROM trips INNER JOIN zones ON(trips."PULocationID" = zones."LocationID")
) WHERE pickup_date = DATE '2019-09-18' AND "Borough" != 'Unknown' GROUP BY "Borough";
