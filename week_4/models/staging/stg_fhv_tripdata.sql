{{
    config(
        materialized='view'
    )
}}


with tripdata as (
    select * from {{ source('staging', 'fhv_tripdata') }}
    where EXTRACT(YEAR FROM pickup_datetime) = 2019
)
select
    dispatching_base_num,
    pickup_datetime,
    drop_off_datetime,
    pu_location_id,
    do_location_id,
    sr_flag,
    affiliated_base_number
from tripdata

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}
