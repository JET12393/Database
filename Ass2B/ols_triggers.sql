/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*ols_triggers.sql*/

/*Student ID:31336574*/
/*Student Name:Jin En Tan*/
/*Tutorial No:03*/

/* Comments for your marker:




*/

/* 
    Q1 
*/
/*Please copy your trigger code and any other necessary SQL statements after this line*/

CREATE OR REPLACE TRIGGER maintain_modules_completed BEFORE
    INSERT OR UPDATE OF driver_id, training_code, dt_date_completed ON driver_training
    FOR EACH ROW
DECLARE
    old_date DATE;
BEGIN
    SELECT
        MAX(dt_date_completed)
    INTO old_date
    FROM
        driver_training
    WHERE
            driver_id = :new.driver_id
        AND training_code = :new.training_code;

    IF months_between(:new.dt_date_completed, old_date) < 6 THEN
        raise_application_error(-20000, 'Must have at least 6 months gap!!!');
    ELSE
        UPDATE driver
        SET
            driver_modscomp = driver_modscomp + 1
        WHERE
            driver_id = :new.driver_id;

    END IF;

END;
/

/*test harness*/
/*display before value*/
SELECT
    *
FROM
    driver_training;

SELECT
    *
FROM
    driver;

INSERT INTO driver_training VALUES (
    21,
    'AID',
    TO_DATE('20-Nov-2021', 'dd-Mon-yyyy')
);

/*display after value*/
SELECT
    *
FROM
    driver_training;

SELECT
    *
FROM
    driver;

ROLLBACK;





/* 
    Q2
*/
/*Please copy your trigger code and any other necessary SQL statements after this line*/
CREATE OR REPLACE TRIGGER change_sec_lvl BEFORE
    INSERT OR UPDATE OF driver_clearance_level ON driver
    FOR EACH ROW
DECLARE
    last_day_v  DATE;
    last_day_a  DATE;
    last_day_s  DATE;
BEGIN
    SELECT
        MAX(dt_date_completed)
    INTO last_day_v
    FROM
        driver_training
    WHERE
            driver_id = :new.driver_id
        AND training_code = 'VIP';

    SELECT
        MAX(dt_date_completed)
    INTO last_day_a
    FROM
        driver_training
    WHERE
            driver_id = :new.driver_id
        AND training_code = 'AID';

    SELECT
        MAX(dt_date_completed)
    INTO last_day_s
    FROM
        driver_training
    WHERE
            driver_id = :new.driver_id
        AND training_code = 'SEC';

    IF :new.driver_clearance_level = '4' THEN
        IF ( last_day_v IS NULL OR last_day_a IS NULL OR last_day_s IS NULL ) OR months_between(
        sysdate, last_day_v) > 12 OR months_between(sysdate, last_day_a) > 12 OR months_between(
        sysdate, last_day_s) > 12 THEN
            raise_application_error(-20000,
                                   'Driver must have completed all three training courses within last 12 months period');
        END IF;
    END IF;

END;
/


/*test harness*/
/*display before value*/
SELECT
    *
FROM
    driver
WHERE
    driver_id = 21;

SELECT
    *
FROM
    driver_training
WHERE
    driver_id = 21;

INSERT INTO driver_training VALUES (
    21,
    'SEC',
    TO_DATE('8-Feb-2022', 'dd-Mon-yyyy')
);

/*test trigger*/
UPDATE driver
SET
    driver_clearance_level = '4'
WHERE
    driver_id = 21;

/*display after value*/
SELECT
    *
FROM
    driver_training
WHERE
    driver_id = 21;

SELECT
    *
FROM
    driver
WHERE
    driver_id = 21;

ROLLBACK;