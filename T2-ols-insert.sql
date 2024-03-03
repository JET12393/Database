--****PLEASE ENTER YOUR DETAILS BELOW****
--T2-ols-insert.sql

--Student ID:31336574
--Student Name:Jin En Tan
--Tutorial No:03

/* Comments for your marker:




*/

-- Task 2 Load the DRIVER, DRIVER_LANGUAGE and TRIP tables with your own
-- test data following the data requirements expressed in the brief
insert into driver values(1,'Bill','Gates','111111111111111111','1');
insert into driver values(2,'Peter','Parker','111111111111111112','2');
insert into driver values(3,'Gal','Gadot','111111111111111113','3');
insert into driver values(4,'John','Runner','111111111111111114','4');
insert into driver values(5,'Sean','Tan','111111111111111115','1');
insert into driver values(6,'Andrew','Garner','111111111111111116','2');
insert into driver values(7,'Cassandra','Chew','111111111111111117','3');
insert into driver values(8,'Angelina','Jolie','111111111111111118','4');

--insert values for driver_language
insert into driver_language values(1,'EN');
insert into driver_language values(1,'BE');
insert into driver_language values(1,'ZH');
insert into driver_language values(2,'DA');
insert into driver_language values(2,'EN');
insert into driver_language values(3,'DE');
insert into driver_language values(4,'DE');
insert into driver_language values(5,'NL');
insert into driver_language values(6,'EN');
insert into driver_language values(7,'EN');
insert into driver_language values(8,'EN');
insert into driver_language values(8,'FA');
insert into driver_language values(8,'JA');
insert into driver_language values(8,'MS');

--insert values for trip

insert into trip (trip_id,trip_start,trip_end,trip_start_actual,trip_end_actual,trip_passengers,veh_vin,location_id_from,location_id_to,off_olympic_id,driver_id) values (1,to_date('26-JAN-2022 7:00 AM','dd-mon-yyyy hh:mi pm'),to_date('26-JAN-2022 1:00 PM','dd-mon-yyyy hh:mi pm'),to_date('26-JAN-2022 7:10 AM','dd-mon-yyyy hh:mi pm'),to_date('26-JAN-2022 1:10 PM','dd-mon-yyyy hh:mi pm'),3,'SANFDAE11U1286116',34,35,'AUS00101',1);
insert into trip (trip_id,trip_start,trip_end,trip_start_actual,trip_end_actual,trip_passengers,veh_vin,location_id_from,location_id_to,off_olympic_id,driver_id) values (2,to_date('27-JAN-2022 7:00 AM','dd-mon-yyyy hh:mi pm'),to_date('27-JAN-2022 1:00 PM','dd-mon-yyyy hh:mi pm'),to_date('27-JAN-2022 7:09 AM','dd-mon-yyyy hh:mi pm'),to_date('27-JAN-2022 1:05 PM','dd-mon-yyyy hh:mi pm'),3,'SB2252300ADT00644',34,35,'AUS00102',2);
insert into trip (trip_id,trip_start,trip_end,trip_start_actual,trip_end_actual,trip_passengers,veh_vin,location_id_from,location_id_to,off_olympic_id,driver_id) values (3,to_date('28-JAN-2022 7:00 AM','dd-mon-yyyy hh:mi pm'),to_date('28-JAN-2022 1:00 PM','dd-mon-yyyy hh:mi pm'),to_date('28-JAN-2022 7:08 AM','dd-mon-yyyy hh:mi pm'),to_date('28-JAN-2022 1:05 PM','dd-mon-yyyy hh:mi pm'),3,'SD2252300BDU00040',34,35,'AUS00103',6);
insert into trip (trip_id,trip_start,trip_end,trip_start_actual,trip_end_actual,trip_passengers,veh_vin,location_id_from,location_id_to,off_olympic_id,driver_id) values (4,to_date('29-JAN-2022 7:00 AM','dd-mon-yyyy hh:mi pm'),to_date('29-JAN-2022 1:00 PM','dd-mon-yyyy hh:mi pm'),to_date('29-JAN-2022 7:05 AM','dd-mon-yyyy hh:mi pm'),to_date('29-JAN-2022 1:08 PM','dd-mon-yyyy hh:mi pm'),3,'SK30URHHAAS217472',34,35,'AUS00104',7);
insert into trip (trip_id,trip_start,trip_end,trip_start_actual,trip_end_actual,trip_passengers,veh_vin,location_id_from,location_id_to,off_olympic_id,driver_id) values (5,to_date('30-JAN-2022 7:00 AM','dd-mon-yyyy hh:mi pm'),to_date('30-JAN-2022 1:00 PM','dd-mon-yyyy hh:mi pm'),to_date('30-JAN-2022 7:15 AM','dd-mon-yyyy hh:mi pm'),to_date('30-JAN-2022 1:10 PM','dd-mon-yyyy hh:mi pm'),3,'SB2252300ADT01359',34,35,'AUS00105',8);
insert into trip (trip_id,trip_start,trip_end,trip_passengers,veh_vin,location_id_from,location_id_to,off_olympic_id,driver_id) values (6,to_date('31-JAN-2022 7:00 AM','dd-mon-yyyy hh:mi pm'),to_date('31-JAN-2022 1:00 PM','dd-mon-yyyy hh:mi pm'),3,'SANFDAE11U1286116',34,35,'AUS00106',1);
insert into trip (trip_id,trip_start,trip_end,trip_passengers,veh_vin,location_id_from,location_id_to,off_olympic_id,driver_id) values (7,to_date('1-FEB-2022 7:00 AM','dd-mon-yyyy hh:mi pm'),to_date('1-FEB-2022 1:00 PM','dd-mon-yyyy hh:mi pm'),3,'SB2252300ADT01359',34,35,'JPN00101',8);
insert into trip (trip_id,trip_start,trip_end,trip_passengers,veh_vin,location_id_from,location_id_to,off_olympic_id,driver_id) values (8,to_date('1-FEB-2022 7:00 AM','dd-mon-yyyy hh:mi pm'),to_date('1-FEB-2022 1:00 PM','dd-mon-yyyy hh:mi pm'),3,'SANFDAE11U1286116',34,35,'AUS00106',1);
insert into trip (trip_id,trip_start,trip_end,trip_passengers,veh_vin,location_id_from,location_id_to,off_olympic_id,driver_id) values (9,to_date('2-FEB-2022 7:00 AM','dd-mon-yyyy hh:mi pm'),to_date('2-FEB-2022 1:00 PM','dd-mon-yyyy hh:mi pm'),3,'SANFDAE11U1286116',34,35,'AUS00106',1);
insert into trip (trip_id,trip_start,trip_end,trip_passengers,veh_vin,location_id_from,location_id_to,off_olympic_id,driver_id) values (10,to_date('3-FEB-2022 7:00 AM','dd-mon-yyyy hh:mi pm'),to_date('3-FEB-2022 1:00 PM','dd-mon-yyyy hh:mi pm'),3,'SANFDAE11U1286116',34,35,'AUS00106',1);
commit;