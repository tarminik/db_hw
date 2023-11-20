CREATE OR REPLACE FUNCTION serial_generator(start_val_inc INTEGER, last_val_ex INTEGER)
    RETURNS TABLE (serial_generator INTEGER) AS $$
    DECLARE
        start_ INTEGER;
        end_ INTEGER;
    BEGIN
        start_ := $1;
        end_ := $2;
        RETURN QUERY
            WITH RECURSIVE t AS (
                SELECT start_ AS curr
                WHERE start_ < end_
                UNION ALL
                SELECT curr + 1 AS curr
                FROM t
                WHERE curr < end_ - 1
            )
            SELECT * FROM t;
    END;
$$ LANGUAGE plpgsql;
