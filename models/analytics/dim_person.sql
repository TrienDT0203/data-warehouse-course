with application_people__source as (
  SELECT 
    *
  FROM `vit-lam-data.wide_world_importers.application__people`
),
dim_people_rename_col as (
  SELECT person_id as people_key
      , full_name as full_name
      , search_name 
      , is_employee
      , is_salesperson
  FROM application_people__source
),
dim_people_cast_type as (
  SELECT cast(people_key as int) people_key  
        , cast(full_name as string) full_name
        , cast(search_name as string) search_name  
        , cast(is_employee as boolean) is_employee 
        , cast(is_salesperson as boolean) is_salesperson 
  FROM dim_people_rename_col
),
dim_people_case_when as (
  SELECT  people_key  
        , full_name
        , search_name  
        , case 
            when is_employee = true then "Employee"
            when  is_employee = false then "Not employee"
            else "Undefined"
          end as is_employee
        , case 
            when is_salesperson = true then "Salesperson"
            when  is_salesperson = false then "Not salesperson"
            else "Undefined"
          end as is_salesperson
  FROM dim_people_rename_col
),
dim_people_union as (
  select *
  from dim_people_case_when

  union all 
  select 0 as people_key
      , "Undefined" as full_name
      , "Undefind" as search_name
      , "Undefind" as is_employee
      , "Undefind" as is_salesperson

  union all 
  select -1 as people_key
      , "Error/ Invalid" as full_name
      , "Error/ Invalid" as search_name
      , "Error/ Invalid" as is_employee
      , "Error/ Invalid" as is_salesperson
)

SELECT people_key
      , full_name
      , search_name
      , is_employee
      , is_salesperson
FROM dim_people_union