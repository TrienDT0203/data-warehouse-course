SELECT 
      people_key as salesperson_person_key 
    , full_name as salesperson_person_name 
    , search_name as salesperson_search_name 
FROM {{ ref('dim_person')}}