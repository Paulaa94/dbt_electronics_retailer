with source as (

    select * from {{ source('raw', 'Stores') }}

),

renamed as (

    select
        cast(`StoreKey` as int64) as store_key,
        trim(Country) as country,
        trim(State) as state,
        cast(`Square Meters` as int64) as square_meters,
        cast(`Open Date` as string) as open_date

    from source

)

select * from renamed
