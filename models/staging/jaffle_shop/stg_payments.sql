

with payments as (
    select
        orderid,
        paymentmethod,
        status,
        amount,
        created,
        _batched_at
    from {{ source("stripe", "payment") }}
)

select * from payments