{% macro subcategory_score(product_key_column, sales_table=ref('int_sales_enriched')) %}
(
    select
        sum(quantity) * 1.0 /
        (
            select sum(quantity)
            from {{ sales_table }} as all_sales
            where all_sales.product_key in (
                select product_key
                from {{ ref('stg_products') }} p
                where p.subcategory = (
                    select subcategory
                    from {{ ref('stg_products') }}
                    where product_key = {{ product_key_column }}
                    limit 1
                )
            )
        )
    from {{ sales_table }} as product_sales
    where product_sales.product_key = {{ product_key_column }}
)
{% endmacro %}