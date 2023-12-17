-- created table which contains aadhar card details..
CREATE TABLE aadhar_card_details ( aadhar_number int,
                                   first_name varchar2(50),
                                   middle_name varchar2(50),
                                   last_name varchar2(50),
                                   date_of_birth date,
                                   mobile_number int,
                                   email_id varchar2(50),
                                   address varchar2(200),
                                   citizenship varchar2(50));
                                   
INSERT INTO aadhar_card_details VALUES(999493993937,'Dinesh','Madan','Tayde','15-09-1999',9848848488,'xyz123@gmail.com','karanjade,secotor-6,navi-mumbai','Indian');

select *from aadhar_card_details;

/
-- created package specs containing different procedures..
CREATE OR REPLACE PACKAGE aadhar_pkg IS

  v_count INT;

  PROCEDURE captcha_code_generation 
  (
    v_aadhar_number IN NUMBER,
    captcha_code OUT VARCHAR2
  );
  
  PROCEDURE generate_otp
  (
    captcha_code VARCHAR2,
    v_otp OUT VARCHAR2
  );
  
  PROCEDURE aadhar_updation 
  ( 
    v_aadhar_number int,
    v_last_name varchar2,
    v_email_id varchar2,
    dob date,
    v_address varchar2,
    v_message out varchar2
   );
END aadhar_pkg;
/

-- this package body has executable code description of procedures which were specified in package body..
CREATE OR REPLACE PACKAGE BODY aadhar_pkg IS
  -- This procedure generates captcha code..
  PROCEDURE captcha_code_generation (
    v_aadhar_number IN NUMBER,
    captcha_code OUT VARCHAR2
  ) AS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(*) INTO v_count
    FROM aadhar_card_details
    WHERE aadhar_number = v_aadhar_number;

    IF v_count > 0 THEN
      captcha_code := dbms_random.string('a', 5); -- generates 5 digit random string..
      dbms_output.put_line('Captcha code generated successfully');
    ELSE
      dbms_output.put_line('Invalid Aadhar number');
    END IF;
  END captcha_code_generation;

  -- This procedure creates  OTP after entering the captcha code..
  PROCEDURE generate_otp (
    captcha_code VARCHAR2,
    expected_captcha_code VARCHAR2,
    v_otp OUT VARCHAR2
  ) AS
  BEGIN
    IF captcha_code IS NOT NULL AND captcha_code = expected_captcha_code THEN
      v_otp := TO_CHAR(TRUNC(dbms_random.value(100000, 999999))); -- generates 6 digit random number..
      dbms_output.put_line('OTP generated successfully');
    ELSE 
      dbms_output.put_line('Invalid captcha code');
    END IF;
  END generate_otp;
  
  -- This procedure created for updatation of aadhaar card details..
  PROCEDURE aadhar_updation ( v_aadhar_number int,
                              v_last_name varchar2,
                              v_email_id varchar2,
                              dob date,
                              v_address varchar2,
                              v_message out varchar2) AS
  BEGIN
     UPDATE aadhar_card_details 
     SET last_name = v_last_name,
         email_id  = v_email_id,
         date_of_birth = dob,
         address = v_address
     WHERE aadhar_number= v_aadhar_number;
     
     IF sql%found then
     commit; 
     v_message:='aadhar details updated successfully';
     rollback;
     ELSE
     v_message:='error in server .please try later..';
     END IF;
   END aadhar_updation ;
   
END aadhar_pkg;
/

-- called procedure captcha_code_generation which return captcha code..
DECLARE
captcha_code varchar2(10);
BEGIN
aadhar_pkg.captcha_code_generation(999493993937,captcha_code);
dbms_output.put_line(captcha_code || ' is captcha code for your aadhar login');
END;
/
--  called procedure generate_otp generates OTP after entering the captcha code..
DECLARE
v_otp int;

BEGIN
aadhar_pkg.generate_otp('SPgkp','SPgkp',v_otp);
dbms_output.put_line(v_otp|| ' is OTP for your aadhar login');
END;
/
-- called procedure aadhar_updation  to update aadhar card details..
DECLARE
v_message varchar2(100);
BEGIN
aadhar_pkg.aadhar_updation(v_aadhar_number => 999493993937,
                           v_last_name => 'Tayade',
                           v_email_id => 'abcd124@gmail.com',
                           dob => '15-09-1999',
                           v_address => 'khandeshwar,sector-9,navi-mumbai',
                           v_message => v_message);
dbms_output.put_line(v_message);
END;
/

ALTER SESSION SET NLS_DATE_FORMAT='DD-MM-YYYY ';
