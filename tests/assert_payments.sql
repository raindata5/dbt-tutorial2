select 
    orderid,
    sum(amount) total
from {{ ref('stg_payments') }}
group by 1
having not(total >= 0)