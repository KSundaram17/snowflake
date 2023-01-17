create database EXERCISE_DB;

----- ASSIGNMENT- GETTING STARTED----

--Create Table
create or replace table customers(
customer_id INT,
first_name varchar,
last_name varchar,
email varchar,
age int,
city varchar);

--Load data
COPY INTO customers
  from s3://snowflake-assignments-mc/gettingstarted/customers.csv
  file_format = (
    type = csv 
    field_delimiter = ',' 
    skip_header = 1);

select * from customers;