SELECT cast(stock_item_id as int) product_key  
    , cast(stock_item_name as string) product_name 
    , cast(brand as string) brand_name   
FROM `vit-lam-data.wide_world_importers.warehouse__stock_items`
