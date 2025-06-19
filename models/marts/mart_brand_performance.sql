with base as (
    select
        brand,
        order_date,
        total_orders,
        total_quantity,
        total_revenue_usd,
        total_cost_usd,
        total_profit_usd,
        avg_unit_price_usd,
        avg_profit_margin,

    from {{ ref('int_brand_sales') }}
)

select * from base