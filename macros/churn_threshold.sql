{% macro is_churned(last_order_date, threshold_days=90) %}
    case 
        when date_diff(current_date(), {{ last_order_date }}, day) > {{ threshold_days }} then 1 
        else 0 
    end
{% endmacro %}
