--ols_simplifiedSchemaInsert.sql

/*Run the script to create and populate DRIVER, DRIVER_TRAINING,
TRAINING tables for PART B*/


DROP TABLE driver CASCADE CONSTRAINTS;

DROP TABLE driver_training CASCADE CONSTRAINTS;

DROP TABLE training CASCADE CONSTRAINTS;


CREATE TABLE driver (
    driver_id               NUMBER(4) NOT NULL,
    driver_givenname        VARCHAR2(50),
    driver_familyname       VARCHAR2(50) NOT NULL,
    driver_dob              DATE NOT NULL,
    driver_licence_no       CHAR(18) NOT NULL,
    driver_clearance_level  CHAR(1) NOT NULL,
    driver_modscomp         NUMBER(2) NOT NULL
);

ALTER TABLE driver
    ADD CONSTRAINT driver_clearance_level_chk CHECK ( driver_clearance_level IN ( '1', '2', '3', '4' ) );

COMMENT ON COLUMN driver.driver_id IS
    'Driver id as PK';

COMMENT ON COLUMN driver.driver_givenname IS
    'Driver given name';

COMMENT ON COLUMN driver.driver_familyname IS
    'Driver family name';

COMMENT ON COLUMN driver.driver_dob IS
    'Driver date of birth';

COMMENT ON COLUMN driver.driver_licence_no IS
    'Driver licence number';

COMMENT ON COLUMN driver.driver_clearance_level IS
    'Driver clearance level';

COMMENT ON COLUMN driver.driver_modscomp IS
    'The number of training modules that the driver completed';

ALTER TABLE driver ADD CONSTRAINT driver_pk PRIMARY KEY ( driver_id );

CREATE TABLE driver_training (
    driver_id          NUMBER(4) NOT NULL,
    training_code      CHAR(5) NOT NULL,
    dt_date_completed  DATE NOT NULL
);

COMMENT ON COLUMN driver_training.driver_id IS
    'Driver id as PK';

COMMENT ON COLUMN driver_training.training_code IS
    'Training code';

COMMENT ON COLUMN driver_training.dt_date_completed IS
    'Training date that the driver completed';

ALTER TABLE driver_training
    ADD CONSTRAINT driver_training_pk PRIMARY KEY ( dt_date_completed,
                                                    driver_id,
                                                    training_code );

CREATE TABLE training (
    training_code  CHAR(5) NOT NULL,
    training_name  VARCHAR2(80) NOT NULL
);

COMMENT ON COLUMN training.training_code IS
    'Training code';

COMMENT ON COLUMN training.training_name IS
    'Training name';

ALTER TABLE training ADD CONSTRAINT training_pk PRIMARY KEY ( training_code );

ALTER TABLE driver_training
    ADD CONSTRAINT drv_drv_train_rel FOREIGN KEY ( driver_id )
        REFERENCES driver ( driver_id );

ALTER TABLE driver_training
    ADD CONSTRAINT train_drv_train_rel FOREIGN KEY ( training_code )
        REFERENCES training ( training_code );




--Partial Data
-- =======================================
-- DRIVER
-- =======================================
INSERT INTO DRIVER VALUES (21,'Peter','Wang',to_date('03-Mar-1997','dd-Mon-yyyy'),'K11223344556677SWL',3,2);
INSERT INTO DRIVER VALUES (22,'Masimo','Liu',to_date('21-Feb-1996','dd-Mon-yyyy'),'C11223344556677SQW',3,1);
INSERT INTO DRIVER VALUES (23,'Mary','Choong',to_date('01-Jun-1995','dd-Mon-yyyy'),'A11223344556677JQR',4,4);
INSERT INTO DRIVER VALUES (24,'Gabriel','Lee',to_date('12-Jul-1996','dd-Mon-yyyy'),'G11223344556677OFB',3,1);
INSERT INTO DRIVER VALUES (25,'Joao','Sun',to_date('23-Aug-1994','dd-Mon-yyyy'),'J11223344556677NMB',3,1);
INSERT INTO DRIVER VALUES (26,'Erick','Yuan',to_date('11-Sep-1995','dd-Mon-yyyy'),'Y11223344556677JAR',2,1);
INSERT INTO DRIVER VALUES (27,'Miki','Khan',to_date('14-Jan-1993','dd-Mon-yyyy'),'M11223344556677CTL',2,1);
INSERT INTO DRIVER VALUES (28,'Emily','Yang',to_date('16-Dec-1994','dd-Mon-yyyy'),'E11223344556677SJQ',3,1);

-- =======================================
-- TRAINING
-- =======================================

INSERT INTO TRAINING VALUES ('VIP','Transport of VIPs');
INSERT INTO TRAINING VALUES ('AID','First Aid Training');
INSERT INTO TRAINING VALUES ('SEC','Security Training');


-- =======================================
-- DRIVER_TRAINING
-- =======================================
INSERT INTO DRIVER_TRAINING VALUES (21,'VIP',to_date('03-MAR-2021','dd-mon-yyyy'));
INSERT INTO DRIVER_TRAINING VALUES (22,'VIP',to_date('03-MAR-2021','dd-mon-yyyy'));
INSERT INTO DRIVER_TRAINING VALUES (23,'VIP',to_date('03-MAR-2021','dd-mon-yyyy'));
INSERT INTO DRIVER_TRAINING VALUES (24,'VIP',to_date('10-MAR-2021','dd-mon-yyyy'));
INSERT INTO DRIVER_TRAINING VALUES (25,'VIP',to_date('10-MAR-2021','dd-mon-yyyy'));
INSERT INTO DRIVER_TRAINING VALUES (26,'VIP',to_date('10-MAR-2021','dd-mon-yyyy'));
INSERT INTO DRIVER_TRAINING VALUES (27,'VIP',to_date('19-JAN-2021','dd-mon-yyyy'));
INSERT INTO DRIVER_TRAINING VALUES (28,'VIP',to_date('28-APR-2021','dd-mon-yyyy'));
INSERT INTO DRIVER_TRAINING VALUES (21,'AID',to_date('20-MAY-2021','dd-mon-yyyy'));
INSERT INTO DRIVER_TRAINING VALUES (23,'SEC',to_date('03-FEB-2021','dd-mon-yyyy'));
INSERT INTO DRIVER_TRAINING VALUES (23,'SEC',to_date('28-NOV-2021','dd-mon-yyyy'));
INSERT INTO DRIVER_TRAINING VALUES (23,'AID',to_date('20-DEC-2021','dd-mon-yyyy'));

commit;