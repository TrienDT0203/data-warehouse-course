SELECT cast(order_line_id as int)	sales_order_line_key
    , cast(stock_item_id as int) product_key
    , cast(quantity as int) quantity
    , cast(unit_price as float64) unit_price
    , cast(quantity as int) * cast(unit_price as float64) as gross_amount
FROM `vit-lam-data.wide_world_importers.sales__order_lines`
