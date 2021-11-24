with customers as (
select * from {{ ref('stg_customers')}}
),

orders as (

select * from {{ ref('fct_orders')}}

),
query1 as (

select
    customer_id,
    min(order_date) as first_order_date,
    max(order_date) as most_recent_order_date,
    count(order_id) as number_of_orders,
    sum(amount) as amount

from orders

group by 1
),

final as (
  select
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    query1.first_order_date,
    query1.most_recent_order_date,
    coalesce(query1.number_of_orders, 0) as number_of_orders,
    query1.amount
from customers 

left join query1 on query1.customer_id=customers.customer_id

)

select * from final
 