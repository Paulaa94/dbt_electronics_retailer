with sales_agg as (
    select
        customer_key,
        min(order_date) as first_order_date,
        max(order_date) as last_order_date,
        count(distinct order_number) as no_of_orders,
        sum(revenue_usd) as customer_lifetime_value
    from {{ ref('int_sales_enriched') }}
    group by customer_key
),

customers as (
    select
        customer_key,
        name,
        gender,
        birthday,
        state,
        country,
        continent
    from {{ ref('stg_customers') }}
),

joined as (
    select
        c.*,
        s.first_order_date,
        s.last_order_date,
        s.no_of_orders,
        s.customer_lifetime_value,
        date_diff(s.first_order_date, c.birthday, year) as age_at_first_purchase
    from customers c
    left join sales_agg s on c.customer_key = s.customer_key
),

final as (
    select
        *,
        case
            when age_at_first_purchase < 25 then '18-24'
            when age_at_first_purchase < 35 then '25-34'
            when age_at_first_purchase < 50 then '35-49'
            when age_at_first_purchase < 70 then '50-69'
            else '70+'
        end as age_group,

        case
            when no_of_orders = 1 then 'One-time'
            when no_of_orders > 1 then 'Returning'
            else 'No Orders'
        end as customer_type
    from joined
)

select * from final
