select
    customer_key,
    date_diff(current_date(), last_order_date, day) as recency_days,
    no_of_orders as frequency,
    customer_lifetime_value as monetary_value,
    
    ntile(5) over (order by date_diff(current_date(), last_order_date, day) asc) as recency_score,
    ntile(5) over (order by no_of_orders desc) as frequency_score,
    ntile(5) over (order by customer_lifetime_value desc) as monetary_score

from {{ ref('int_customers_enriched') }}
