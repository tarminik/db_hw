CREATE OR REPLACE FUNCTION count_non_volatile_days(full_nm TEXT) RETURNS INTEGER AS $$
    DECLARE
        ans INTEGER;
        num INTEGER;
    BEGIN
        SELECT COUNT(*) INTO STRICT ans
        FROM coins c
        WHERE c.full_nm = $1 AND c.high_price = c.low_price;
        SELECT COUNT(*) INTO num
        FROM coins c2
        WHERE c2.full_nm = $1;
        IF num = 0 THEN
            RAISE EXCEPTION 'Crypto currency with name: % is absent in database!', $1
                    USING ERRCODE = '02000';
        ELSE
            RETURN ans;
        END IF;
    END;
$$ LANGUAGE plpgsql;
