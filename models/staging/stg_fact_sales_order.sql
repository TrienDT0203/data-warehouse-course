with source_sales_order as (
    SELECT *
    FROM `vit-lam-data.wide_world_importers.sales__orders`
),
     sales_order__rename_col as (
         select order_id as sales_order_key
              , order_date as sales_order_date
              , customer_id as customer_key
              , picked_by_person_id as	picked_by_person_key
              , salesperson_person_id as salesperson_person_key
         from source_sales_order
     ),
     sales_order_cast_type as (
         select cast(sales_order_key as int) sales_order_key
              , cast(sales_order_date as date) sales_order_date
              , cast(customer_key as int) customer_key
              , cast(picked_by_person_key as int ) picked_by_person_key
              , cast(salesperson_person_key as int ) salesperson_person_key
    from sales_order__rename_col
    )

select sales_order_key
      , sales_order_date
      , customer_key
      , coalesce(picked_by_person_key,0) as picked_by_person_key
      , coalesce(salesperson_person_key,0) as salesperson_person_key
from sales_order_cast_type
