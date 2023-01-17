select * from EXERCISE_DB.PUBLIC.CUSTOMERS;

-- Create stage object

CREATE STAGE EXERCISE_DB.PUBLIC.data_stage
url= s3://snowflake-assignments-mc/loadingdata/
file_format = (type= csv field_delimiter=';' skip_header = 1);

--List the files in the table
LIST @EXERCISE_DB.PUBLIC.data_stage;

--Load the data in the existing customer table using COPY command

COPY INTO EXERCISE_DB.PUBLIC.CUSTOMERS
from @EXERCISE_DB.PUBLIC.data_stage
file_format=(type= csv field_delimiter=';' skip_header=1);

select count(*) from EXERCISE_DB.PUBLIC.CUSTOMERS;