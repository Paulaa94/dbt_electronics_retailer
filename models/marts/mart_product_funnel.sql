select
    product_key,
    count(distinct customer_key) as total_customers,
    sum(case when customer_orders = 1 then 1 else 0 end) as one_time_buyers,
    sum(case when customer_orders > 1 then 1 else 0 end) as repeat_buyers
from (
    select
        customer_key,
        product_key,
        count(order_number) as customer_orders
    from {{ ref('int_sales_enriched') }}
    group by customer_key, product_key
)
group by product_key
