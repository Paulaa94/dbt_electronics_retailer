with base as (

    select
        s.order_number,
        s.order_date,
        s.product_key,
        s.quantity,
        s.revenue_usd,
        s.cost_usd,
        s.profit_usd,
        p.brand
    from {{ ref('int_sales_enriched') }} s
    left join {{ ref('stg_products') }} p
        on s.product_key = p.product_key

), aggregated as (

    select
        order_date,
        brand,
        sum(quantity) as total_quantity,
        count(distinct order_number) as total_orders,
        sum(revenue_usd) as total_revenue_usd,
        sum(cost_usd) as total_cost_usd,
        sum(profit_usd) as total_profit_usd,
        safe_divide(sum(revenue_usd), sum(quantity)) as avg_unit_price_usd,
        safe_divide(sum(profit_usd), sum(revenue_usd)) as avg_profit_margin
    from base
    group by order_date, brand

)

select * from aggregated
