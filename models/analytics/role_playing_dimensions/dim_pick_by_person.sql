SELECT 
      people_key as pick_by_person_key 
    , full_name as pick_by_person_name 
    , search_name as pick_by_search_name 
FROM {{ ref('dim_person')}}