with source as (

    select * from {{ source('raw', 'products') }}

),

cleaned as (

    select
        cast("ProductKey" as int) as product_key,
        trim("Product Name") as product_name,
        trim("Brand") as brand,
        trim("Color") as color,
        cast(replace("Unit Cost USD", '$', '') as float64) as unit_cost_usd,
        cast(replace("Unit Price USD", '$', '') as float64) as unit_price_usd,
        cast("SubcategoryKey" as string) as subcategory_key,
        trim("Subcategory") as subcategory,
        cast("CategoryKey" as string) as category_key,
        trim("Category") as category

    from source

)

select * from cleaned
