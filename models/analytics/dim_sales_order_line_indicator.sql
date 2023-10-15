WITH is_undersupply_backordered AS (
    SELECT  TRUE as is_undersupply_backorder_boolean
        , "Undersupply Backorder" as is_undersupply_backorder

    UNION ALL
        SELECT FALSE as is_undersupply_backorder_boolean
        , "Not Undersupply Backorder" as is_undersupply_backorder
)

SELECT FARM_FINGERPRINT(
          CONCAT(is_undersupply_backorder, "-", CAST(package_type_key as STRING))
          ) as sales_order_line_indicator_key
        , is_undersupply_backorder_boolean
        , is_undersupply_backorder
        , package_type_key
        , package_type_name
FROM {{ref('dim_package_type')}}
CROSS JOIN is_undersupply_backordered