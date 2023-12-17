## PL/SQL PROJECTS
This README provides basic instructions of the project, details about the tables, sample data, and a procedures.

markdown


# PROJECT-1 -> OTP-generation-and-validation-for-Debit-card-PIN-generation

This project contains SQL scripts and PL/SQL procedures for a basic Bank Account Management System. 
The system involves tables for storing account holder details, OTPs, PINs, and procedures for OTP and PIN generation and validation.

How to Use -->

->Execute the SQL scripts to create tables and procedures.
<br>
->Insert sample data into the ACCOUNT_HOLDER_DETAILS table.
<br>
->Call the procedures for OTP and PIN generation and validation in your PL/SQL environment.

Note: Ensure that you have the necessary privileges to execute these scripts and procedures in your database environment.
Feel free to modify the procedures or add more functionalities as needed for your specific use case.

# PROJECT-2 -> Google Pay coupon code validation

This project manages customer payment details for Google Pay, including transactions, rewards, and coupon validation.
Follow the code and the instructions.

Usage -->

->Firstly, Create tables google pay customers payments data and cusmtomers rewards data .
<br>
->Insert sample data in both tables according to convenience.
<br>
->Create procedure and call it to see the output.

# PROJECTS-3 -> Aadhar login and updation of details

This project implements an Aadhar Card Management System, including a table for storing Aadhar card details 
<br>
and a package with procedures for generating captcha codes, OTPs, and updating Aadhar card information.

How to use -->

->Create the table of aadhar card details of customers.
<br>
->Insert sample data in both tables according to convenience.
<br>
->Create a package specs aadhar_pkg and specify three procedures like captcha_code_generation , otp_generation and aadhar_updataion.
<br>
->Now,create package body aadhar_pkg (this package body has executable code of these procedures which are specified in package specs).
<br>
->Then,call the procedure captcha_code_generation which will generate captcha code(enter your aadhar number in it which is specified in table aadhar_card_details).
<br>
->call the next procedure otp_generation and enter the generated (valid) captcha code.
<br>
->Call the last procedure aadhar_updation and update the whichever details you would like to update. 

