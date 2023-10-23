with customers__source as (
  SELECT  *
  FROM `vit-lam-data.wide_world_importers.sales__customers`
),
    customers_rename_col as (
    SELECT  cast(customer_id as int) customer_key
        , cast(customer_name as string) customer_name
        , cast(customer_category_id as int) customer_category_key
        , cast(buying_group_id as int) buying_group_key
        , cast(is_on_credit_hold as string) is_on_credit_hold
    FROM customers__source
  ),
  customers_map_value as (
    select customer_key
        , customer_name
        , customer_category_key
        , buying_group_key
        , case 
            when lower(is_on_credit_hold) = "true" then "On Credit Hold"
            when lower(is_on_credit_hold) = "false" then "Not on Credit Hold"
            when is_on_credit_hold is Null then "Undefined"
            else "Error/ Invalid"
          end as is_on_credit_hold
    from customers_rename_col
  ),
    dim_customer_union as (
    select *
    from customers_map_value
    union all
    select 0 as customer_key
        , "Undefined" as customer_name
        , 0 as customer_category_key
        , 0 as buying_group_key
        , "Undefined" as is_on_credit_hold
    union all
    select -1 as customer_key
        , "Error/ Invalid" as customer_name
        , -1 as customer_category_key
        , -1 as buying_group_key
        , "Error/ Invalid" as is_on_credit_hold
)

SELECT dim_customer.customer_key
    , dim_customer.customer_name 
    , dim_customer_category.customer_category_key
    , coalesce(dim_customer_category.customer_category_name, "Invalid") customer_category_name
    , dim_buying_group.buying_group_key 
    , coalesce(dim_buying_group.buying_group_name, "Invalid") buying_group_name
    , dim_customer.is_on_credit_hold as credit_hold_type
FROM dim_customer_union as dim_customer
LEFT JOIN {{ ref('stg_dim_customer_category')}} dim_customer_category
  ON dim_customer.customer_category_key = dim_customer_category.customer_category_key
LEFT JOIN {{ ref('stg_dim_buying_group')}} dim_buying_group
  ON dim_customer.buying_group_key = dim_buying_group.buying_group_key
