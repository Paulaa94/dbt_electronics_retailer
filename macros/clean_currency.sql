{% macro clean_currency(value) %}
    cast(
        REGEXP_REPLACE(
            cast({{ value }} as string),
            r'[\s$€£¥₽₩₹,]',
            ''
        ) as float64
    )
{% endmacro %}

