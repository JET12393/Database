--****PLEASE ENTER YOUR DETAILS BELOW****
--T4-ols-alter.sql

--Student ID:31336574
--Student Name:Jin En Tan
--Tutorial No:03

/* Comments for your marker:




*/

-- 4(a)
alter table trip add duration number(4);
update trip set duration=round(((trip_end_actual-trip_start_actual)*24*60));
commit;


-- 4(b)

alter table driver add driver_availability char(1) default 'Y';
alter table driver add constraint driver_availability_chk check (driver_availability in ('Y','N'));
update driver set driver_availability= 'Y' where driver_id in (select driver_id from trip where to_char(trip_start,'dd-mon-yyyy')!= (select to_char(sysdate,'dd-mon-yyyy') from dual));
update driver set driver_availability= 'N' where driver_id in (select driver_id from trip where to_char(trip_start,'dd-mon-yyyy')= (select to_char(sysdate,'dd-mon-yyyy') from dual));

commit;



-- 4(c)
alter table trip add off_take_part_details varchar(100);



