with fact_sales_order_line as (
  SELECT *
  FROM `vit-lam-data.wide_world_importers.sales__order_lines`
),
fact_sales_order_line__renamed_column as (
  SELECT order_line_id as sales_order_line_key
      , stock_item_id as  product_key
      , quantity
      , unit_price
      , quantity * unit_price as gross_amount
  FROM fact_sales_order_line
),
fact_sales_order_line__cast_type as (
  SELECT cast(sales_order_line_key as int) sales_order_line_key
        , product_key
        , quantity
        , unit_price
        , quantity * unit_price as gross_amount
  FROM fact_sales_order_line__renamed_column
)
SELECT sales_order_line_key
    , product_key
    , quantity
    , unit_price
    , gross_amount
FROM fact_sales_order_line__cast_type