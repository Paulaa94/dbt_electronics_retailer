with source as (

    select * from {{ source('raw', 'Customers') }}

),

cleaned as (

    select
        cast(`CustomerKey` as int64) as customer_key,
        trim(Gender) as gender,
        trim(Name) as name,
        trim(City) as city,
        trim(`State Code`) as state_code,
        trim(State) as state,
        trim(`Zip Code`) as zip_code,
        trim(Country) as country,
        trim(Continent) as continent,
        cast(Birthday as date) as birthday

    from source

)

select * from cleaned
