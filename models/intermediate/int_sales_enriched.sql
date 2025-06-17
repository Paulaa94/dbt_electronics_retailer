with sales as (
    select * from {{ ref('stg_sales') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

sales_joined as (
    select
        s.order_number,
        s.line_item,
        s.order_date,
        s.delivery_date,
        s.customer_key,
        s.store_key,
        s.product_key,
        s.quantity,
        s.currency_code,
        p.unit_price_usd,
        p.unit_cost_usd
    from sales s
    left join products p on s.product_key = p.product_key
),

sales_metrics as (
    select
        *,
        quantity * unit_price_usd as revenue_usd,
        quantity * unit_cost_usd as cost_usd,
        quantity * (unit_price_usd - unit_cost_usd) as profit_usd
    from sales_joined
)

select * from sales_metrics
