with source as (
    select * from {{ source('raw', 'Products') }}
),

cleaned as (
    select
        cast(ProductKey as int64) as product_key,
        trim(`Product Name`) as product_name,
        trim(Brand) as brand,
        trim(Color) as color,
        {{ clean_currency('`Unit Cost USD`') }} as unit_cost_usd,
        {{ clean_currency('`Unit Price USD`') }} as unit_price_usd,
        cast(SubcategoryKey as string) as subcategory_key,
        trim(Subcategory) as subcategory,
        cast(CategoryKey as string) as category_key,
        trim(Category) as category
    from source
)

select * from cleaned
