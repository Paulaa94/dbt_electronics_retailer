select
    customer_key,
    name,
    gender,
    age_at_first_purchase,
    age_group,
    no_of_orders,
    customer_lifetime_value,
    customer_type,
    country,
    continent,

    date_diff(last_order_date, first_order_date, day) as customer_tenure_days,

from {{ ref('int_customers_enriched') }}
