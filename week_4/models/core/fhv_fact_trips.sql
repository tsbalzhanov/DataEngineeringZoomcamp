{{
    config(
        materialized='table'
    )
}}

with fhv_tripdata as (
    select *
    from {{ ref('stg_fhv_tripdata') }}
),
dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select
    fhv_tripdata.dispatching_base_num,
    fhv_tripdata.pickup_datetime,
    fhv_tripdata.drop_off_datetime,
    fhv_tripdata.pu_location_id,
    fhv_tripdata.do_location_id,
    fhv_tripdata.sr_flag,
    fhv_tripdata.affiliated_base_number
from fhv_tripdata
inner join dim_zones as pickup_zone
on fhv_tripdata.pu_location_id = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on fhv_tripdata.do_location_id = dropoff_zone.locationid
