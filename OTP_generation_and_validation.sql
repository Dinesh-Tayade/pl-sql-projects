-- created table account_holder_details holding data of customers ..
create table ACCOUNT_HOLDER_DETAILS (Account_Number NUMBER PRIMARY KEY ,
                                     Customer_ID NUMBER ,
                                     Customer_Name varchar2(50),
                                     Mobile_Number NUMBER,
                                     Account_status varchar2(30));

INSERT INTO ACCOUNT_HOLDER_DETAILS VALUES (5546412478594278,14578523,'DINESH TAYADE',7745471236,'ACTIVE');
INSERT INTO ACCOUNT_HOLDER_DETAILS VALUES (5546412478594279,14578524,'STEPHEN NAUNDLA',8545471236,'ACTIVE');
INSERT INTO ACCOUNT_HOLDER_DETAILS VALUES (5546412478594280,14578525,'HRISHIKESH AMBAJI',6345471236,'ACTIVE');
INSERT INTO ACCOUNT_HOLDER_DETAILS VALUES (5546412478594281,14578526,'HARESH LASE',8845471236,'ACTIVE');
INSERT INTO ACCOUNT_HOLDER_DETAILS VALUES (5546412478594282,14578527,'SANTOSH GHUGHE',9945471236,'INACTIVE');

SELECT *FROM ACCOUNT_HOLDER_DETAILS;
/
-- -- created table otp_details  ..
create table OTP_DETAILS (Customer_ID NUMBER PRIMARY KEY,
                          Account_Number NUMBER,
                          Mobile_Number NUMBER,
                          OTP NUMBER,
                          OTP_Generated_Time DATE,
                          OTP_Expired_Time DATE,
                          CONSTRAINT FK FOREIGN KEY(ACCOUNT_NUMBER) REFERENCES ACCOUNT_HOLDER_DETAILS(ACCOUNT_NUMBER));
                           
/ 
-- created table CUSTOMERS_PIN_DETAILS to store pin related  data..
create table CUSTOMERS_PIN_DETAILS ( Customer_ID NUMBER,
                                     Account_Number NUMBER ,
                                     Customer_Name varchar2(50),
                                     Mobile_Number  NUMBER,
                                     Pin_Generated NUMBER,
                                     Pin_Generated_Time DATE,
                                     CONSTRAINT FK_PIN_DETAILS FOREIGN KEY(Customer_ID) REFERENCES OTP_DETAILS(Customer_ID));
/
-- created procedure OTP_GENERATION for generation of otp..
create or replace procedure OTP_GENERATION (v_Customer_ID NUMBER,
                                            v_Account_Number NUMBER,
                                            v_MobileNumber NUMBER ,
                                            v_OTP out NUMBER) as
begin
select trunc(dbms_random.value(100000,999999)) into v_otp  -- generates random 6 digit OTP ..
from dual;


Insert into OTP_DETAILS values (v_Customer_ID ,
                                v_Account_Number,
                                v_MobileNumber,
                                v_OTP,
                                SYSDATE,
                                SYSDATE+1/(24*60));
commit;
end;
/
-- called procedure OTP_GENERATION in anonymous block..
declare
v_OTP int;
v_Customer_ID NUMBER:=14578523;  -- enter customer Id ..
v_MobileNumber number:=7745471236; -- enter  mobile number..
v_Account_Number number:=5546412478594278; -- enter 16 digit account number..
begin
OTP_generation(v_Customer_ID,v_Account_Number,v_MobileNumber,v_OTP);
dbms_output.put_line('Your OTP code for mobile no. '||v_mobileNumber|| ' is : '||v_OTP||
                     '.'|| ' Do not share with anyone else.');
end;
/

-- created procedure to validate otp which is received on registered mobile..
create or replace procedure OTP_VALIDATION (v_Mobile_Number number,
                                            v_OTP number,
                                            v_message out varchar2)  as
v_count pls_integer;
begin
select count(*) into v_count
from OTP_DETAILS
WHERE Mobile_number=v_Mobile_Number 
and OTP=v_OTP 
and sysdate between OTP_Generated_Time and OTP_Expired_Time;

if v_count=1 then
v_message:='OTP validated successfully';
else 
v_message:='OTP is invalid/expired.Try to verify OTP within one minute.';
end if;
end;
/
-- called procedure OTP_VALIDATION in following anonymous block..
declare
v_message varchar2(50);
begin
OTP_VALIDATION(7745471236,600230,v_message); -- enter the 6 digit OTP at second parameter place..
dbms_output.put_line(v_message);
end;
/

 select * from OTP_DETAILS; -- Now you can check otp details of account holder in this table ..
 
/
-- created procedure to generate pin ..
create or replace procedure PIN_GENERATION (v_Customer_ID NUMBER ,
                                            v_Account_Number NUMBER ,
                                            v_Customer_Name varchar2,
                                            v_Mobile_Number  NUMBER,
                                            v_Pin_Generated NUMBER,
                                            v_Pin_Generated_Time DATE,
                                            v_message out varchar2) as 

begin

v_message:='Pin generated successfully';

insert into CUSTOMERS_PIN_DETAILS ( Customer_ID ,
                                   Account_Number ,
                                   Customer_Name,
                                   Mobile_Number ,
                                   Pin_Generated ,
                                   Pin_Generated_Time)
                                 values
                                ( v_Customer_ID ,
                                 v_Account_Number ,
                                 v_Customer_Name ,
                                 v_Mobile_Number ,
                                 v_Pin_Generated,
                                 sysdate);

--commit;
end;
/

-- called procedure PIN_GENERATION here..
declare 
v_message varchar2(50);
begin
PIN_GENERATION(14578523,5546412478594278,'Dinesh Tayade',7745471236,1234,sysdate,v_message);
dbms_output.put_line(v_message);
end;
/

select * from CUSTOMERS_PIN_DETAILS; -- now you can check the account holder's PIN details here..

ALTER SESSION SET NLS_DATE_FORMAT='DD-MON-YY HH24:MI:SS';



