with fact_sales_order_line as (
  SELECT *
  FROM `vit-lam-data.wide_world_importers.sales__order_lines`
),
fact_sales_order_line__renamed_column as (
  SELECT order_line_id as sales_order_line_key
      , order_id as sales_order_id_key
      , stock_item_id as  product_key
      , quantity
      , unit_price
      , quantity * unit_price as gross_amount
  FROM fact_sales_order_line
),
fact_sales_order_line__cast_type as (
  SELECT cast(sales_order_line_key as int) sales_order_line_key
        , sales_order_id_key
        , product_key
        , quantity
        , unit_price
        , quantity * unit_price as gross_amount
  FROM fact_sales_order_line__renamed_column
),
fact_sales_order_line__join_stg_sales_order as (
  SELECT sales_order_line_key
      , tb1.sales_order_id_key
      , tb2.customer_key
      , tb2.picked_by_person_key
      , product_key
      , quantity
      , unit_price
      , gross_amount
  FROM fact_sales_order_line__cast_type tb1 
  JOIN {{ref('stg_fact_sales_order')}} tb2
    ON tb1.sales_order_id_key = tb2.sales_order_key
)
select sales_order_line_key
      , sales_order_id_key
      , coalesce(customer_key,-1) customer_key
      , picked_by_person_key
      , product_key
      , quantity
      , unit_price
      , gross_amount
from fact_sales_order_line__join_stg_sales_order