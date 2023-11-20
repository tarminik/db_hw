CREATE OR REPLACE VIEW v_first_level_partition_info AS
SELECT n.nspname  as parent_schema,
       pc.relname as parent_table,
       n2.nspname as child_schema,
       c.relname  as child_table
FROM pg_inherits i
         JOIN
     pg_class c ON (i.inhrelid = c.oid)
         JOIN
     pg_class pc ON (i.inhparent = pc.oid)
         JOIN
     pg_namespace n ON (pc.relnamespace = n.oid)
         JOIN
     pg_namespace n2 ON (c.relnamespace = n2.oid)
WHERE n.nspname NOT LIKE 'pg_%'
  AND n.nspname <> 'information_schema'
  AND n2.nspname NOT LIKE 'pg_%'
  AND n2.nspname <> 'information_schema'
  AND c.relkind = 'p'
  AND NOT EXISTS (SELECT 1
                  FROM pg_inherits i2
                  WHERE i2.inhparent = c.oid);

