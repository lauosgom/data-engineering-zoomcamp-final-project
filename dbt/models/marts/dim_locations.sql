with taxi_zone_lookup as (
    select * from {{ ref('taxi_zone_lookup') }}
)

