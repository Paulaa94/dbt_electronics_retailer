with sales as (
    select product_key, customer_key
    from {{ ref('int_sales_enriched') }}
),

customers as (
    select distinct customer_key
    from {{ ref('stg_customers') }}
),

conversion as (
    select
        s.product_key,
        count(distinct s.customer_key) as purchasing_customers,
        (select count(*) from customers) as total_customers
    from sales s
    group by s.product_key
)

select
    product_key,
    purchasing_customers,
    total_customers,
    safe_divide(purchasing_customers, total_customers) as product_conversion_rate
from conversion
