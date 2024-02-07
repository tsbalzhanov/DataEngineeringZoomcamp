-- Create external table
CREATE OR REPLACE EXTERNAL TABLE dataengineeringzoomcamp-412520.week_3.green_taxi_green_tripdata_2022__external
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://tsbalzhanov-dtc-week-3/green_taxi_data/green_tripdata_2022']
);

-- Create materialized table
CREATE OR REPLACE TABLE dataengineeringzoomcamp-412520.week_3.green_taxi_green_tripdata_2022__materialized AS
SELECT * FROM dataengineeringzoomcamp-412520.week_3.green_taxi_green_tripdata_2022__external;

-- Get number of records
SELECT COUNT(1) FROM dataengineeringzoomcamp-412520.week_3.green_taxi_green_tripdata_2022__materialized;

-- Estimate amount of read data for following queries

SELECT DISTINCT PULocationID FROM dataengineeringzoomcamp-412520.week_3.green_taxi_green_tripdata_2022__external;

SELECT DISTINCT PULocationID FROM dataengineeringzoomcamp-412520.week_3.green_taxi_green_tripdata_2022__materialized;

-- Count number of trips with zero fare

SELECT COUNT(1) FROM dataengineeringzoomcamp-412520.week_3.green_taxi_green_tripdata_2022__materialized WHERE fare_amount = 0;

-- Create partitioned and clustered table

CREATE OR REPLACE TABLE dataengineeringzoomcamp-412520.week_3.green_taxi_green_tripdata_2022__partitioned
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PULocationID AS
SELECT * FROM dataengineeringzoomcamp-412520.week_3.green_taxi_green_tripdata_2022__materialized;

-- Compare queries from non-partitioned and partitioned tables

SELECT DISTINCT PULocationID FROM dataengineeringzoomcamp-412520.week_3.green_taxi_green_tripdata_2022__materialized WHERE DATE(lpep_pickup_datetime) >= DATE(2022, 6, 1) AND DATE(lpep_pickup_datetime) < DATE(2022, 7, 1);

SELECT DISTINCT PULocationID FROM dataengineeringzoomcamp-412520.week_3.green_taxi_green_tripdata_2022__partitioned WHERE DATE(lpep_pickup_datetime) >= DATE(2022, 6, 1) AND DATE(lpep_pickup_datetime) < DATE(2022, 7, 1);
