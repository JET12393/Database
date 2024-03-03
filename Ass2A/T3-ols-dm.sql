--****PLEASE ENTER YOUR DETAILS BELOW****
--T3-ols-dm.sql

--Student ID:31336574
--Student Name:Jin En Tan
--Tutorial No:03

/* Comments for your marker:




*/

-- 3(a)
--drop both sequence
drop sequence driver_seq;
drop sequence trip_seq;

--create both sequence needed
create sequence driver_seq start with 100 increment by 1;
create sequence trip_seq start with 100 increment by 1;





-- 3(b)
insert into driver values (driver_seq.nextval,'Michael','Chu','X33445566778899MCH','3');
insert into driver_language values(driver_seq.currval,'EN');
insert into driver_language values(driver_seq.currval,'ES');
insert into trip (trip_id,trip_start, trip_end, trip_passengers, veh_vin,location_id_from,location_id_to,off_olympic_id,driver_id) values (trip_seq.nextval,to_date('7-FEB-2022 7:30 AM','dd-mon-yyyy hh:mi AM'),to_date('7-FEB-2022 9:00 AM','dd-mon-yyyy hh:mi AM'),3,(select veh_vin from vehicle where veh_regonumber='OLSID22'),(select location_id from location where location_name='Beijing National Stadium'),(select location_id from location where location_name='National Alpine Ski Centre'),(select off_olympic_id from official where off_givenname='Simon' and off_familyname='Nathan' and country_ioc_code='AUS'),driver_seq.currval);
commit;


-- 3(c)
update trip set trip_start_km=5678, trip_end_km=5780,trip_start_actual=to_date('7-FEB-2022 7:35 AM','dd-mon-yyyy hh:mi am'),trip_end_actual=to_date('7-FEB-2022 9:00 AM','dd-mon-yyyy hh:mi am') 
where trip_id=(select trip_id from trip where trip_start=to_date('7-FEB-2022 7:30 AM','dd-mon-yyyy hh:mi AM') and veh_vin=(select veh_vin from vehicle where veh_regonumber='OLSID22'));
commit;




-- 3(d)
delete from trip
where trip_start>=to_date('8-FEB-2022','dd-mon-yyyy') and off_olympic_id= (select off_olympic_id from official where off_givenname='Simon' and off_familyname='Nathan' and country_ioc_code='AUS');
commit;