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
  )

SELECT fact_order_line.sales_order_line_key
    , fact_order_line.sales_order_id_key
    , coalesce(fact_order_header.customer_key,-1) customer_key
    , coalesce(fact_order_header.picked_by_person_key,-1) picked_by_person_key
    , fact_order_line.product_key
    , fact_order_header.sales_order_date
    , quantity
    , unit_price
    , gross_amount
FROM fact_sales_order_line__cast_type fact_order_line 
JOIN {{ref('stg_fact_sales_order')}} fact_order_header
  ON fact_order_line.sales_order_id_key = fact_order_header.sales_order_key
