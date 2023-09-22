with buying_group_source as (
    select buying_group_id as buying_group_key
        , buying_group_name
    from `vit-lam-data.wide_world_importers.sales__buying_groups`
),
    buying_group_source_cast_type as (
        select CAST(buying_group_key as int) as buying_group_key
            , CAST(buying_group_name as string) as buying_group_name
        from buying_group_source
    ),
    buying_group_union as (
        select *
        from buying_group_source_cast_type

        union all
        select 0 as buying_group_key
            , "Undefined" as buying_group_name

        union all
        select -1 as buying_group_key
            , "Error/ Invalid" as buying_group_name
    )
select buying_group_key
    , buying_group_name
from buying_group_union


