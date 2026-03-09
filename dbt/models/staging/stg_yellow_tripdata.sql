select
    -- *
    -- identifiers (standarized naming for consistency across yellow/green)
    cast(Vendorid as INT64) as vendor_id,
    cast(ratecodeid as INT64) as rate_code_id,
    cast(pulocationid as INT64) as pickup_location_id,
    cast(dolocationid as INT64) as dropoff_location_id,
    -- timestamps
    cast(tpep_pickup_datetime as timestamp) as pickup_datetime,
    cast(tpep_dropoff_datetime as timestamp) as dropoff_datetime,
    -- trip info
    store_and_fwd_flag,
    cast(passenger_count as INT64) as passenger_count,
    cast(trip_distance as FLOAT64) as trip_distance,
    1 as trip_type, -- yellow taxis can only be street-hail
    -- payment info
    cast(fare_amount as NUMERIC) as fare_amount,
    cast(extra as NUMERIC) as extra,
    cast(mta_tax as NUMERIC) as mta_tax,
    cast(tip_amount as NUMERIC) as tip_amount,
    cast(tolls_amount as NUMERIC) as tolls_amount,
    0 as ehail_fee,
    cast(improvement_surcharge as NUMERIC) as improvement_surcharge,
    cast(total_amount as NUMERIC) as total_amount,
    cast(payment_type as INT64) as payment_type

from {{source('raw_data', 'yellow_tripdata')}}

where Vendorid is not null
order by tpep_pickup_datetime asc
limit 2