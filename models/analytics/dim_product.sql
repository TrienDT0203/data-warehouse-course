with source_warehouse_stock_items as (
  SELECT 
    *
  FROM `vit-lam-data.wide_world_importers.warehouse__stock_items`
),
source_dim_supplier as (
  SELECT *
  FROM {{ref('dim_supplier')}}
)
,source_warehouse_stock_items__rename_col as (
  SELECT stock_item_id as product_key
      , stock_item_name
      , brand as brand_name
      , supplier_id as supplier_key
  FROM source_warehouse_stock_items
),
source_warehouse_stock_items__cast_type as (
  SELECT cast(product_key as int) product_key
      , cast(stock_item_name as string) product_name
      , cast(brand_name as string) brand_name
      , cast(supplier_key as int) supplier_key
  FROM source_warehouse_stock_items__rename_col
)

SELECT product_key
      , product_name
      , brand_name
      , dim_product.supplier_key
      , dim_supplier.supplier_name
from source_warehouse_stock_items__cast_type as dim_product
left join source_dim_supplier as dim_supplier
  on dim_product.supplier_key = dim_supplier.supplier_key