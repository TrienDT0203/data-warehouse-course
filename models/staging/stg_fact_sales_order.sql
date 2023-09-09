with source_sales_order as (
  SELECT *
  FROM `vit-lam-data.wide_world_importers.sales__orders`
),
sales_order__rename_col as (
  select order_id as sales_order_key
      , customer_id as customer_key
  from source_sales_order
),
sales_order_cast_type as (
  select cast(sales_order_key as int) sales_order_key
        , cast(customer_key as int) customer_key
  from sales_order__rename_col
)
select *
from sales_order_cast_type
