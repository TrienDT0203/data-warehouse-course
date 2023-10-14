with source_people as (
  SELECT 
    *
  FROM `vit-lam-data.wide_world_importers.application__people`
),
dim_people_rename_col as (
  SELECT person_id as people_key
      , full_name as full_name
  FROM source_people
),
dim_people_cast_type as (
  SELECT cast(people_key as int) people_key  
        , cast(full_name as string) full_name
  FROM dim_people_rename_col
),
dim_people_union as (
  select *
  from dim_people_cast_type

  union all 
  select 0 as people_key
      , "Undefined" as full_name

  union all 
  select -1 as people_key
      , "Error/ Invalid" as full_name
      
)

SELECT people_key as salesperson_key
      , full_name as salesperson_full_name
FROM dim_people_union