-- created this table which google pay customer details.. 
create table google_pay_customer_payment_details 
(user_id int ,
 user_name varchar2(100),
 payment_id int,
 payment_type varchar2(200),
 payment_date date,
 reward varchar2(200));

-- inserted sample data in the table..
insert into google_pay_customer_payment_details values (100,'Dinesh',111111,'Mobile recharge',sysdate,'flat 50% off on JBL earbuds'); 
insert into google_pay_customer_payment_details values (101,'Kamlesh',111112,'Electricity bill',sysdate,'lenskart gold membership for one year'); 
insert into google_pay_customer_payment_details values (103,'Sana',111113,'DTH/Cable TV',sysdate,'flat 200 rs. off on first order from Kuku FM'); 
insert into google_pay_customer_payment_details values (104,'Suraj',111114,'Broadband landline',sysdate,'50 rs. cashback at Flipkart'); 
insert into google_pay_customer_payment_details values (105,'Rakesh',111115,'Book a Uber cab',sysdate,'60% off on Mamaearth products'); 

select * from google_pay_customer_payment_details; 

drop table google_pay_customer_payment_details;
/
-- This table has customers coupon and reward details.. 
create table users_reward 
(user_id int,
 coupon_code varchar2(50),
 coupon_applied_time date,
 coupon_expired_time date,
 reward varchar2(200),
 status varchar2(50)
 );

-- inserted sample data..
insert into users_reward values (100,'JBL50',sysdate,sysdate+1/(24*60),'flat 50% off on JBL earbuds','active'); 
insert into users_reward values (101,'LENSKARTGOLD365',sysdate,sysdate+2/(24*60),'lenskart gold membership for one year','active'); 
insert into users_reward values (103,'KUKUFM200',sysdate,sysdate+3/(24*60),'flat 200 rs. off on first order from Kuku FM','active'); 
insert into users_reward values (104,'FLIPKARTC50',sysdate,sysdate+5/(24*60),'50 rs. cashback at Flipkart','inactive'); 
insert into users_reward values (105,'MAMAREARTH60',sysdate,sysdate+4/(24*60),'60% off on Mamaearth products','active'); 

drop table users_reward;
select * from users_reward;
/
-- This procedure created to validate coupon code..
create or replace procedure coupon_code_validation (v_coupon_code varchar2,
                                                    v_message out varchar2)
as 
v_count int;
begin 
select count(1) into v_count 
from users_reward 
where status='active'
and coupon_code=UPPER(v_coupon_code)
and sysdate between coupon_applied_time  and coupon_expired_time ;

case
when v_count=1 then
v_message:='It is a valid coupon';
when v_count<> 1 then 
v_message:='coupon has  expired';
end case;

end;
/
-- called procedure here to see the output..
declare 
v_message varchar2(100);
begin
coupon_code_validation ('MAMAREARTH60',v_message);
dbms_output.put_line(v_message);
end;
/
ALTER SESSION SET NLS_DATE_FORMAT='DD-MON-YY HH24:MI:SS';

