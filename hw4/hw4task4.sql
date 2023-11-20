create or replace view v_first_level_partition_info as
select
    parent_ns.nspname as parent_schema,
    pgc.relname as parent_table,
    child_ns.nspname as child_schema,
    child_rel.relname as child_table,
    array_agg(child_rel.oid) as child_oids,
    1                        as part_level
from
    pg_class pgc
        join pg_namespace child_ns
            on pgc.relnamespace = child_ns.oid
        join pg_inherits
            on pg_inherits.inhrelid = pgc.oid
        join pg_class child_rel
            on pg_inherits.inhrelid = child_rel.oid
        join pg_namespace parent_ns
            on pgc.relnamespace = parent_ns.oid

where 1=1
    and not exists (
        select 1 from pg_inherits
        where pg_inherits.inhparent = pgc.oid
        and pg_inherits.inhrelid <> child_rel.oid
    )
    and pgc.relname = 'people_partitioned'
    and parent_ns.nspname = 'public'

group by
    parent_ns.nspname,
    pgc.relname,
    child_ns.nspname,
    child_rel.relname;

create or replace view v_rec_level_partition_info(parent_schema, parent_table, child_schema, child_table, part_level) as
with recursive cte_partition_info as (
    select
        parent_schema,
        parent_table,
        child_schema,
        child_table,
        child_oids,
        part_level
    from v_first_level_partition_info

    union all

    select
        parent_ns.nspname  as parent_schema,
        parent_rel.relname as parent_table,
        child_ns.nspname   as child_schema,
        child_rel.relname  as child_table,
        child_oids,
        part_level + 1

    from
         cte_partition_info
             join pg_inherits
                 on cte_partition_info.child_oids && array [pg_inherits.inhparent]
             join pg_class parent_rel
                 on pg_inherits.inhparent = parent_rel.oid
             join pg_namespace parent_ns
                 on parent_rel.relnamespace = parent_ns.oid
             join pg_class child_rel
                 on pg_inherits.inhrelid = child_rel.oid
             join pg_namespace child_ns
                 on child_rel.relnamespace = child_ns.oid
    where not exists(
        select 1
        from pg_inherits
        where 1=1
            and pg_inherits.inhparent = parent_rel.oid
            and pg_inherits.inhrelid <> child_rel.oid
        )
)
select
    parent_schema,
    parent_table,
    child_schema,
    child_table,
    part_level
from cte_partition_info;

-------------------------------------------------------------------
