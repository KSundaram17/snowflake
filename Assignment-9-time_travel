--Switch to role of accountadmin
USE ROLE ACCOUNTADMIN;
CREATE DATABASE DEMO_DB;
USE DATABASE DEMO_DB;
USE WAREHOUSE COMPUTE_WH;

CREATE OR REPLACE TABLE DEMO_DB.PUBLIC.PART
AS
SELECT * FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."PART";

SELECT * FROM PART ORDER BY P_MFGR DESC;

--update the  table
UPDATE DEMO_DB.PUBLIC.PART
SET P_MFGR='Manufacturer#CompanyX'
WHERE P_MFGR = 'Manufacturer#5';

--note the query id = 01a9b645-0102-3031-0000-00017ca29075

select * from part
order by P_MFGR DESC;

--travel back using the offset until you get thr rrsult of before the update
SELECT * FROM DEMO_DB.PUBLIC.PART at (OFFSET => -60*1.5) ;

--travel back using the query id to get the result before the update

select * from DEMO_DB.PUBLIC.PART before (statement => '01a9b645-0102-3031-0000-00017ca29075');

