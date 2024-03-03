--****PLEASE ENTER YOUR DETAILS BELOW****
--T1-ols-schm.sql

--Student ID: 31336574
--Student Name: Jin En Tan
--Tutorial No: 03

/* Comments for your marker:




*/

-- Task 1 Add Create table statements for the Missing TABLES below
-- Ensure all column comments, and constraints (other than FK's)
-- are included. FK constraints are to be added at the end of this script

-- DRIVER
create table driver(
    driver_id number(4) not null,
    driver_givenname varchar2(50),
    driver_familyname varchar2(50) not null,
    driver_license_no char(18) not null,
    driver_clearance_level char(1) not null,
    constraint driver_pk primary key(driver_id)
);

comment on column driver.driver_id is 'Unique identifier for a driver';
comment on column driver.driver_givenname is 'Driver''s given name';
comment on column driver.driver_familyname is 'Driver''s family name'; 
comment on column driver.driver_license_no is 'Driver''s license number';
comment on column driver.driver_clearance_level is 'The level of security clearance granted to the driver (1 to 4).';

alter table driver add constraint driver_clearance_level_ck check (driver_clearance_level in ('1','2','3','4'));

-- DRIVER_LANGUAGE
create table driver_language(
    driver_id number(4) not null,
    lang_iso_code char(2) not null,
    constraint driver_language_pk primary key(driver_id,lang_iso_code)
);

comment on column driver_language.driver_id is 'Unique identifier for a driver';
comment on column driver_language.lang_iso_code is 'ISO code for a language';

-- TRIP
create table trip(
    trip_id number(4) not null,
    trip_start date not null,
    trip_end date not null,
    trip_start_actual date,
    trip_end_actual date,
    trip_start_km number(6),
    trip_end_km number(6),
    trip_passengers number(2) not null,
    veh_vin char(17) not null,
    location_id_from number(6) not null,
    location_id_to number(6) not null,
    off_olympic_id char(8) not null,
    driver_id number(4) not null,
    constraint trip_pk primary key(trip_id),
    constraint uq_veh_trip unique(trip_start,veh_vin),
    constraint uq_off_trip unique(trip_start,off_olympic_id),
    constraint uq_driver_trip unique(trip_start,driver_id)
);

comment on column trip.trip_id is 'Unique identifier for a trip';
comment on column trip.trip_start is 'Date and time the trip is booked to start';
comment on column trip.trip_end is 'Date and time the trip is booked to end';
comment on column trip.trip_start_actual is 'Date and time the booked trip actually starts';
comment on column trip.trip_end_actual is 'Date and time the booked trip actually ends';
comment on column trip.trip_start_km is 'The odometer reading at the start of the trip';
comment on column trip.trip_end_km is 'The odometer reading at the end of the trip';
comment on column trip.trip_passengers is 'The number of booked passengers for the trip';
comment on column trip.veh_vin is 'Vehicle identification number';
comment on column trip.location_id_from is 'pickup location';
comment on column trip.location_id_to is 'drop off location';
comment on column trip.off_olympic_id is 'Official olympic id';
comment on column trip.driver_id is 'Unique identifier for a driver';

-- Add all missing FK Constraints below here
--for driver_language table
alter table driver_language add constraint driver_driv_lang foreign key(driver_id) references driver(driver_id);
alter table driver_language add constraint lang_driv_lang foreign key(lang_iso_code) references language(lang_iso_code);

--for trip table
alter table trip add constraint vehicle_trip foreign key(veh_vin) references vehicle(veh_vin);
alter table trip add constraint location_trip_from foreign key(location_id_from) references location(location_id);
alter table trip add constraint location_trip_to foreign key(location_id_to) references location(location_id);
alter table trip add constraint off_trip foreign key(off_olympic_id) references official(off_olympic_id);
alter table trip add constraint driver_trip foreign key(driver_id) references driver(driver_id);


