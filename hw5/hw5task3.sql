CREATE OR REPLACE FUNCTION view_insert_func()
    RETURNS TRIGGER AS $PROC$
    DECLARE
        new_event_id INTEGER;
        tmp_string TEXT;
        tmp TEXT;
        auctioneer_str TEXT;
        attachment_str TEXT;
        bet_str TEXT;
 
    BEGIN
        new_event_id := 1 + (SELECT MAX(num) FROM number_event_id);
        tmp_string = cast(NEW AS TEXT);
        tmp = replace(replace(tmp_string, '(', ''), ')', '');
        tmp_string = replace(tmp, '""', '"');
        tmp = replace(tmp_string, ' ', '');
        tmp_string = REGEXP_REPLACE(tmp, E'[\\n\\r]+', '', 'g' );
        tmp = SUBSTRING(tmp_string, 2, LENGTH(tmp_string) - 2);
 
        attachment_str = tmp::json->'attachment';
        auctioneer_str = tmp::json->'auctioneer';
        bet_str        = tmp::json->'bet';
 
 
        INSERT INTO number_event_id VALUES (new_event_id);
        INSERT INTO auctioneer VALUES (new_event_id, auctioneer_str::json->'firstname',
                                       auctioneer_str::json->'lastname',
                                       auctioneer_str::json->'nickname',
                                       auctioneer_str::json->'email');
 
 
        INSERT INTO attachment VALUES (new_event_id, attachment_str::json->'filename',
                                       attachment_str::json->'location'->'datacenter',
                                       attachment_str::json->'location'->'localname');
 
 
        INSERT INTO bet        VALUES (new_event_id, cast(cast(bet_str::json->'volume' AS TEXT) AS NUMERIC),
                                        TO_TIMESTAMP(cast(cast(bet_str::json->'ts' AS TEXT) AS NUMERIC)));
 
        RAISE NOTICE '%', tmp::json->'bet';
        RETURN NEW;
    END;
$PROC$ LANGUAGE plpgsql;
 
CREATE TABLE number_event_id AS
    SELECT 0 AS num;
 
CREATE OR REPLACE TRIGGER view_insert_trigger
    INSTEAD OF INSERT ON v_auction_payload
    FOR EACH ROW
    EXECUTE FUNCTION view_insert_func();
