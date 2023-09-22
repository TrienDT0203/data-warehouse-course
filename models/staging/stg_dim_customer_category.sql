with customer_category_source as (
  SELECT customer_category_id as customer_category_key
      , customer_category_name
  FROM `vit-lam-data.wide_world_importers.sales__customer_categories`
),
    customer_category_cast_type as (
        select CAST(customer_category_key as int) as customer_category_key
            , CAST(customer_category_name as string) as customer_category_name
        from customer_category_source
    ),
    customer_category_union as (
        select *
        from customer_category_cast_type

        union  all
        select 0 as customer_category_key
            , 'Undefined' as customer_category_name

        union  all
        select -1 as customer_category_key
            , 'Error/ Invalid' as customer_category_name

    )

select customer_category_key
      , customer_category_name
from customer_category_union