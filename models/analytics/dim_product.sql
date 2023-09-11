with customers__source as (
  SELECT  *
  FROM `vit-lam-data.wide_world_importers.sales__customers`
),
customers_rename_col as (
  SELECT  cast(customer_id as int) customer_key
      , cast(customer_name as string) customer_name 
  FROM customers__source
)
SELECT customer_key
    , customer_name 
FROM customers_rename_col
