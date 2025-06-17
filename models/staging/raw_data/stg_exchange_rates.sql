with source as (

    select * from {{ source('raw', 'Exchange_Rates') }}

),

renamed as (

    select
        cast(Date as date) as date,
        upper(Currency) as currency,
        cast(Exchange as float64) as exchange_rate_to_usd

    from source

)

select * from renamed
