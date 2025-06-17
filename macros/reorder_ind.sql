{% macro group_reorder_indicator(customer_key, product_key, order_date, sales_table=ref('int_sales_enriched')) %}
exists (
    select 1
    from {{ sales_table }} as prev
    where prev.customer_key = {{ customer_key }}
      and prev.product_key = {{ product_key }}
      and prev.order_date < {{ order_date }}
      and date_diff({{ order_date }}, prev.order_date, day) >= 7
)
{% endmacro %}
