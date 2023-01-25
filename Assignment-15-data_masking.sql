USE DEMO_DB;
USE ROLE ACCOUNTADMIN;

--Prepare table--

create or replace table customers(
id number,
full_name varchar,
email varchar,
phone varchar,
spent number,
create_date DATE DEFAULT CURRENT_DATE);

--insert values in table--

insert into customers(id, full_name, email, phone,spent)
values
(1,'Lewiss MacDwyer','lmacdwyer0@un.org','262-665-9168',140),
(2,'Ty Pettingall','tpettingall1@mayoclinic.com', '734-987-7120', 254),
(3,'Marlee Spandazzi','mspadazzi@txnews.com','867-946-3659',120),
(4,'Heywood Tearney','htearny3@patch.com','563-853-8192',1230),
(5,'Odilla Seti','oseti4@globo.com','730-451-8637',143),
(6,'Meggie Washtell','mwashtell@rediff.com','568-896-6138',600);

-- set up roles
CREATE OR REPLACE ROLE ANALYST_MASKED;
CREATE OR REPLACE ROLE ANALYST_FULL;


-- grant select on table to roles
GRANT SELECT ON TABLE DEMO_DB.PUBLIC.CUSTOMERS TO ROLE ANALYST_MASKED;
GRANT SELECT ON TABLE DEMO_DB.PUBLIC.CUSTOMERS TO ROLE ANALYST_FULL;

GRANT USAGE ON SCHEMA DEMO_DB.PUBLIC TO ROLE ANALYST_MASKED;
GRANT USAGE ON SCHEMA DEMO_DB.PUBLIC TO ROLE ANALYST_FULL;

-- grant warehouse access to roles
GRANT USAGE ON WAREHOUSE COMPUTE_WH TO ROLE ANALYST_MASKED;
GRANT USAGE ON WAREHOUSE COMPUTE_WH TO ROLE ANALYST_FULL;

-- assign roles to a user
GRANT ROLE ANALYST_MASKED TO USER KSUNDARAM17;
GRANT ROLE ANALYST_FULL TO USER KSUNDARAM17;



--set up masking policy Create masking policy called name that is showing '***' instead of the original varchar value except the role analyst_full is used in this case show the original value.


create or replace masking policy name
as (val varchar) returns varchar ->
case 
when current_role() in ('ANALYST_FULL','ACCOUNT_ADMIN') then val
else '***'
end;

--apply masking policy on the column full_name
ALTER TABLE IF EXISTS CUSTOMERS MODIFY COLUMN full_name
SET MASKING POLICY name;



--Validate the result using the role analyst_masked and analyst_full

USE ROLE ANALYST_FULL;
SELECT * FROM CUSTOMERS limit 5;

USE ROLE ANALYST_MASKED;
SELECT * FROM CUSTOMERS limit 5;

--Alter policy so that at least two characyers are shown and before that only '***'
USE ROLE ACCOUNTADMIN;
--Unset the policy
ALTER TABLE IF EXISTS CUSTOMER MODIFY COLUMN full_name
UNSET MASKING POLICY;

ALTER MASKING POLICY name set name ->
case
when current_role() in ('ANALYST_FULL','ACCOUNT_ADMIN') then val
else CONCAT('***',RIGHT(val,2))
end;

--apply policy again on the column full name and validate the policy
ALTER TABLE IF EXISTS CUSTOMERS MODIFY COLUMN full_name SET MASKING POLICY name;

