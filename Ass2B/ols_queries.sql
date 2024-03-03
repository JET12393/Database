/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/* ols_queries.sql*/

/*Student ID:31336574
/*Student Name:Jin En Tan

/* Comments for your marker:




*/


/*
    Q1
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon*/
/* (;) at the end of this answer*/
SELECT
    driver_givenname
    || ' '
    || driver_familyname AS full_name
FROM
         ols.driver d
    JOIN ols.driver_language dl
    ON d.driver_id = dl.driver_id
WHERE
        lang_iso_code = (
            SELECT
                lang_iso_code
            FROM
                ols.language
            WHERE
                lang_name = 'English'
        )
    AND d.driver_clearance_level = '3'
ORDER BY
    full_name;
/*
    Q2
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/
SELECT
    off_olympic_id,
    off_familyname
FROM
    (
             ols.official o
        JOIN ols.country     c
        ON o.country_ioc_code = c.country_ioc_code
    )
    JOIN ols.ioc_role    i
    ON o.ioc_role_code = i.ioc_role_code
WHERE
    country_ioc_name LIKE '%a%'
    AND ioc_role_desc = 'Head Coach'
ORDER BY
    off_familyname,
    off_olympic_id;

/*
    Q3
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/
SELECT
    trip_id,
    to_char(trip_start, 'dd-Mon-yyyy hh:mm PM')      AS planned_start_date_time,
    to_char(trip_end, 'dd-Mon-yyyy hh:mm PM')        AS planned_end_date_time
FROM
    ols.trip
WHERE
    location_id_from = (
        SELECT
            location_id
        FROM
            ols.location
        WHERE
            lower(location_name) LIKE '%airport%'
    )
    OR location_id_to = (
        SELECT
            location_id
        FROM
            ols.location
        WHERE
            lower(location_name) LIKE '%airport%'
    )
ORDER BY
    trip_start,
    trip_id;

/*
    Q4
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/
SELECT
    veh_regonumber,
    total_current_bookings
FROM
    (
        SELECT
            veh_regonumber,
            COUNT(*) AS total_current_bookings
        FROM
                 ols.trip t
            JOIN ols.vehicle v
            ON t.veh_vin = v.veh_vin
        WHERE
            trip_start_actual IS NULL
        GROUP BY
            veh_regonumber
    )
GROUP BY
    veh_regonumber,
    total_current_bookings
HAVING
    total_current_bookings = (
        SELECT
            MAX(total_current_bookings)
        FROM
            (
                SELECT
                    veh_regonumber,
                    COUNT(*) AS total_current_bookings
                FROM
                         ols.trip t
                    JOIN ols.vehicle v
                    ON t.veh_vin = v.veh_vin
                WHERE
                    trip_start_actual IS NULL
                GROUP BY
                    veh_regonumber
            )
    )
ORDER BY
    veh_regonumber DESC;

/*
    Q5
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/
SELECT
    off_olympic_id,
    off_fullname,
    total_number_of_trips
FROM
         (
        SELECT
            off_olympic_id,
            COUNT(*) AS total_number_of_trips
        FROM
            ols.trip
        GROUP BY
            off_olympic_id
    )
    NATURAL JOIN (
        SELECT
            off_olympic_id,
            off_givenname
            || ' '
            || off_familyname AS off_fullname
        FROM
            ols.official
    )
WHERE
    total_number_of_trips > (
        SELECT
            COUNT(*) / COUNT(DISTINCT off_olympic_id)
        FROM
            ols.trip
    )
ORDER BY
    total_number_of_trips DESC,
    off_olympic_id;



/*
    Q6
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/

SELECT
    trip_id,
    to_char(trip_start_actual, 'dd-Mon-yyyy hh24:mi')            AS trip_start_actual,
    to_char(trip_end_actual, 'dd-Mon-yyyy hh24:mi')              AS trip_end_actual,
    l.location_name                                              AS original_location,
    l2.location_name                                             AS destination_location,
    round((trip_end_actual - trip_start_actual) * 24 * 60)       AS trip_duration
FROM
         ols.trip t
    JOIN ols.location    l
    ON t.location_id_from = l.location_id
    JOIN ols.location    l2
    ON t.location_id_to = l2.location_id
WHERE
    trip_end_actual IS NOT NULL
    AND round((trip_end_actual - trip_start_actual) * 24 * 60) > (
        SELECT
            AVG(trip_end_actual - trip_start_actual) * 24 * 60
        FROM
            ols.trip
        WHERE
            trip_start_actual IS NOT NULL
    )
ORDER BY
    to_date(trip_start_actual, 'dd-Mon-yyyy hh24:mi'),
    trip_id;

/*
    Q7
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/
SELECT
    location_id,
    location_name,
    total_number_booked
FROM
         (
        SELECT
            location_id_to,
            COUNT(*) AS total_number_booked
        FROM
            ols.trip
        GROUP BY
            location_id_to
        HAVING
            COUNT(*) = (
                SELECT
                    MAX(freq)
                FROM
                    (
                        SELECT DISTINCT
                            COUNT(*) AS freq
                        FROM
                            ols.trip
                        GROUP BY
                            location_id_to
                        MINUS
                        SELECT
                            MAX(COUNT(*)) AS freq
                        FROM
                            ols.trip
                        GROUP BY
                            location_id_to
                    )
            )
    ) t
    JOIN ols.location l
    ON t.location_id_to = l.location_id
ORDER BY
    location_name;

/*
    Q8
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/
SELECT
    driver_id,
    driver_givenname
    || ' '
    || driver_familyname   AS fullname,
    CASE
        WHEN total_period_payment IS NULL THEN
            lpad(('Not Applicable'), 20, ' ')
        ELSE
            lpad(total_period_payment, 20, ' ')
    END                    total_period_payment
FROM
    (
        SELECT
            t.driver_id,
            to_char(SUM(round((trip_end_actual - trip_start_actual) * 24 * 40, 2)),
                    '$9999.99') AS total_period_payment
        FROM
                 ols.trip t
            JOIN ols.driver d
            ON t.driver_id = d.driver_id
        WHERE
                trip_start_actual > TO_DATE('26-Jan-2022 0659', 'dd-Mon-yyyy hh24:mi')
            AND trip_end_actual < TO_DATE('10-Feb-2022', 'dd-Mon-yyyy')
        GROUP BY
            t.driver_id
    )
    FULL OUTER JOIN ols.driver
    USING ( driver_id )
ORDER BY
    driver_id;

/*
    Q9
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/
SELECT
    lang_name,
    nvl("Number of drivers", 0)       AS "Number of drivers",
    nvl("Number of trips", 0)         AS "Number of trips"
FROM
    ols.language
    FULL OUTER JOIN (
        SELECT
            lang_iso_code,
            COUNT(*) AS "Number of drivers"
        FROM
            ols.driver_language
        GROUP BY
            lang_iso_code
    )
    USING ( lang_iso_code )
    FULL OUTER JOIN (
        SELECT
            lang_iso_code,
            COUNT(*) AS "Number of trips"
        FROM
                 ols.trip t
            JOIN ols.driver_language l
            ON t.driver_id = l.driver_id
        GROUP BY
            lang_iso_code
    )
    USING ( lang_iso_code )
ORDER BY
    lang_name;