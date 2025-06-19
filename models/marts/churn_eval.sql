with customers as (
    select
        customer_key,
        last_order_date
    from {{ ref('int_customers_enriched') }}
),

churn as (
    select
        customer_key,
        last_order_date,
        current_date() as today,
        date_diff(current_date(), last_order_date, day) as days_since_last_order,
        {{ is_churned('last_order_date', 90) }} as is_churned
    from customers
)

select * from churn
