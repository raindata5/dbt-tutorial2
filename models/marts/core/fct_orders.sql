

with payments as (
    select * from {{ ref('stg_payments')}}
),

 orders as (
    select * from {{ref('stg_orders')}}
),

 customers as (
    select * from {{ref('stg_customers')}}
),

 customers_orders as (
    select
        o.order_id,
        c.customer_id,
        o.order_date
    from customers c 
    left join orders o on c.customer_id=o.customer_id
),

final as (
    select 
    co.order_id,
    co.customer_id,
    p.amount,
    co.order_date
from customers_orders co
left join payments p on co.order_id=p.orderid
)

select * from final