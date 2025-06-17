with source as (

    select * from {{ source('raw', 'Sales') }}

),

renamed as (

    select
        cast(`Order Number` as int) as order_number,
        cast(`Line Item` as int) as line_item,
        cast(`Order Date` as date) as order_date,
        cast(`Delivery Date` as date) as delivery_date,
        cast(CustomerKey as int) as customer_key,
        cast(StoreKey as int) as store_key,
        cast(ProductKey as int) as product_key,
        cast(Quantity as int) as quantity,
        upper(`Currency Code`) as currency_code

    from source

)

select * from renamed
