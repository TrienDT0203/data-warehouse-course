with source_warehouse_stock_items as (
  SELECT 
    *
  FROM `vit-lam-data.wide_world_importers.warehouse__stock_items`
),
source_warehouse_stock_items__rename_col as (
  SELECT stock_item_id as product_key
      , stock_item_name
  FROM source_warehouse_stock_items
),
source_warehouse_stock_items__cast_type as (
  SELECT cast(product_key as int) product_key
      , cast(stock_item_name as string) product_name
  FROM source_warehouse_stock_items__rename_col
)

SELECT product_key
      , product_name
from source_warehouse_stock_items__cast_type