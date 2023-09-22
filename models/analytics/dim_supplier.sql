with source_puschasing_suppliers as (
  SELECT
    *
  FROM `vit-lam-data.wide_world_importers.purchasing__suppliers`
),
source_puschasing_suppliers__rename_col as (
  SELECT supplier_id as supplier_key
      , supplier_name
  FROM source_puschasing_suppliers
),
source_puschasing_suppliers__cast_type as (
  SELECT cast(supplier_key as int) supplier_key
      , cast(supplier_name as string) supplier_name
  FROM source_puschasing_suppliers__rename_col
),
dim_supplier_union as (
    select *
    from source_puschasing_suppliers__cast_type
    union  all
    select 0 as supplier_key
        , "Undefined" as supplier_name
)
SELECT supplier_key
    , supplier_name
from dim_supplier_union