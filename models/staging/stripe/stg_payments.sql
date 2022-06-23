with payments as (

    select
        id as customer_id
        , orderid as order_id
        , paymentmethod as payment_method
        , status as status
        , coalesce(amount/100, 0) as amount
        , created as created_at
        , _batched_at
    from  `dbt-tutorial`.stripe.payment

)

select * from payments