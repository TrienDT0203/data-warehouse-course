with source_warehouse_stock_items as (
  SELECT
    *
  FROM `vit-lam-data.wide_world_importers.warehouse__stock_items`
),
source_dim_supplier as (
  SELECT *
  FROM `data-warehouse-course-398307.learn_data_warehouse.dim_supplier`
)
,source_warehouse_stock_items__rename_col as (
  SELECT stock_item_id as product_key
      , stock_item_name
      , coalesce(brand,"Undefined") as brand_name
      , supplier_id as supplier_key
      , case
        when is_chiller_stock = True then "Chiller Stock"
        when is_chiller_stock = False then "Not Chiller Stock"
        when is_chiller_stock is null then "Undefined"
        else "Invalid"
        end as is_chiller_stock
  FROM source_warehouse_stock_items
),
source_warehouse_stock_items__cast_type as (
  SELECT cast(product_key as int) product_key
      , cast(stock_item_name as string) product_name
      , cast(brand_name as string) brand_name
      , cast(supplier_key as int) supplier_key
      , cast(is_chiller_stock as string) is_chiller_stock
  FROM source_warehouse_stock_items__rename_col
),
dim_product_source as (
    select *
    from source_warehouse_stock_items__cast_type
    union all
    select 0 as product_key
        , "Undefined" as product_name
        , "Undefined" as brand_name
        , 0 as supplier_key
        , "Undefined" as is_chiller_stock
    union all
    select -1 as product_key
        , "Error/ Invalid" as product_name
        , "Error/ Invalid" as brand_name
        , -1 as supplier_key
        , "Error/ Invalid" as is_chiller_stock
)

SELECT dim_product.product_key
      , dim_product.product_name
      , dim_product.brand_name
      , dim_product.supplier_key
      , coalesce(dim_supplier.supplier_name,"Invalid") as supplier_name
      , dim_product.is_chiller_stock
from dim_product_source as dim_product
left join source_dim_supplier as dim_supplier
  on dim_product.supplier_key = dim_supplier.supplier_key