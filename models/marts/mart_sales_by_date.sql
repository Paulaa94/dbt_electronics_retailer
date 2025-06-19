with base as (
    select
        order_date,
        total_orders,
        total_quantity,
        total_revenue_usd,
        total_cost_usd,
        total_profit_usd,
        safe_divide(total_revenue_usd, total_orders) as avg_order_value,
        day_of_week,
        is_weekend
    from {{ ref('int_sales_daily') }}
)

select * from base
