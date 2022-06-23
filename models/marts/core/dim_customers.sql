with orders as (

    select * from {{ ref('fct_orders') }}

)

, customers as (

    select * from {{ ref('stg_customers') }}

)

, customer_orders as (

    select 
        customer_id
        , min(order_date) as first_order_date
        , max(order_date) as most_recent_order_date
        , count(order_date) as number_of_orders
        , sum(amount) as lifetime_value 
    from orders
    {{ dbt_utils.group_by(1) }}

)

, final as (

    select
        customers.customer_id
        , customers.first_name
        , customers.last_name
        , customer_orders.first_order_date
        , customer_orders.most_recent_order_date
        , coalesce(customer_orders.number_of_orders, 0) as number_of_orders
        , customer_orders.lifetime_value
    from customers
    left join customer_orders using (customer_id)

)

select * from final