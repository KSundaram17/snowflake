CREATE DATABASE CUSTOMER_DB;

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
--Create a share object called CUSTOMER_SHARE and grant sufficient grant privileges (provide sql commands)

create or replace share CUSTOMER_SHARE;
grant usage on database CUSTOMER_DB to share CUSTOMER_SHARE;
grant usage on schema CUSTOMER_DB.PUBLIC to share CUSTOMER_SHARE;
grant select on table CUSTOMER_DB.PUBLIC.CUSTOMERS to share CUSTOMER_SHARE;

--Add the consumer account (provide sql commands)
Alter share CUSTOMER_SHARE add accounts=sdw135733;