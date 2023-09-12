with customers__source as (
  SELECT  *
  FROM `vit-lam-data.wide_world_importers.sales__customers`
),
customer_category_source as (
  SELECT customer_category_id as customer_category_key
      , customer_category_name
  FROM `vit-lam-data.wide_world_importers.sales__customer_categories`
),
buying_group_source as (
  SELECT buying_group_id as buying_group_key
        , buying_group_name
  FROM `vit-lam-data.wide_world_importers.sales__buying_groups`
),
customers_rename_col as (
  SELECT  cast(customer_id as int) customer_key
      , cast(customer_name as string) customer_name 
      , cast(customer_category_id as int) customer_category_key
      , cast(buying_group_id as int) buying_group_key
  FROM customers__source
)

SELECT dim_customer.customer_key
    , dim_customer.customer_name 
    , customer_category_source.customer_category_name
    , buying_group_source.buying_group_name 
FROM customers_rename_col as dim_customer
LEFT JOIN customer_category_source 
  ON dim_customer.customer_category_key = customer_category_source.customer_category_key
LEFT JOIN buying_group_source
  ON dim_customer.buying_group_key = buying_group_source.buying_group_key
