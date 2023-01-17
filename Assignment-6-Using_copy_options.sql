select * from EXERCISE_DB.PUBLIC.CUSTOMERS;

--create file format object
CREATE or REPLACE file format EXERCISE_DB.PUBLIC.my_file_format
TYPE=CSV,
FIELD_DELIMITER = '|',
SKIP_HEADER = 1;

--Create a stage object
CREATE or REPLACE STAGE EXERCISE_DB.PUBLIC.aws_stage
url =' s3://snowflake-assignments-mc/fileformat/';

--list the files in the table
LIST @EXERCISE_DB.PUBLIC.aws_stage;

--load the data in the existing customers table using copy command

COPY INTO EXERCISE_DB.PUBLIC.CUSTOMERS
from @EXERCISE_DB.PUBLIC.aws_stage
file_format = (FORMAT_NAME = EXERCISE_DB.PUBLIC.my_file_format);
--files= ('customers4.csv');

select count(*) from EXERCISE_DB.PUBLIC.CUSTOMERS;
