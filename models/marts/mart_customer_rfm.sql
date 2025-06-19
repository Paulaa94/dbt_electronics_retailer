with base as (
    select
        customer_key,
        current_date() as today,
        last_order_date,
        date_diff(current_date(), last_order_date, day) as recentness_days,
        no_of_orders as freq,
        customer_lifetime_value as monetary_value
    from {{ ref('int_customers_enriched') }}
)

select * from base