with sales as (

    select 
        order_number,
        order_date,
        quantity,
        unit_price_usd,
        unit_cost_usd,
        quantity * unit_price_usd as revenue_usd,
        quantity * unit_cost_usd as cost_usd,
        quantity * (unit_price_usd - unit_cost_usd) as profit_usd
    from {{ ref('int_sales_enriched') }}

),

daily_agg as (

    select 
        order_date,
        count(distinct order_number) as total_orders,
        sum(quantity) as total_quantity,
        sum(revenue_usd) as total_revenue_usd,
        sum(cost_usd) as total_cost_usd,
        sum(profit_usd) as total_profit_usd,
        format_date('%A', order_date) as day_of_week,
        case 
            when extract(DAYOFWEEK from order_date) in (1, 7) then true
            else false
        end as is_weekend

    from sales
    group by order_date

)

select * from daily_agg
