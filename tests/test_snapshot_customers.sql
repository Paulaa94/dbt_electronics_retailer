select *
from {{ ref('snap_customers') }}
where customer_key is null
