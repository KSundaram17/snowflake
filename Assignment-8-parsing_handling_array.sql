select * from EXERCISE_DB.PUBLIC.JSON_RAW;

SELECT 
$1:first_name::STRING as first_name,
$1:last_name::STRING as last_name,
$1:Skills::STRING as skills
from EXERCISE_DB.PUBLIC.JSON_RAW;


SELECT 
$1:first_name::STRING as first_name,
$1:last_name::STRING as last_name,
$1:Skills[0]::STRING as skills_1,
$1:Skills[1]::STRING as skills_2
from EXERCISE_DB.PUBLIC.JSON_RAW;

CREATE TABLE EXERCISE_DB.PUBLIC.JSON_TABLE
as
SELECT 
$1:first_name::STRING as first_name,
$1:last_name::STRING as last_name,
$1:Skills[0]::STRING as skills_1,
$1:Skills[1]::STRING as skills_2
from EXERCISE_DB.PUBLIC.JSON_RAW;

select * from EXERCISE_DB.PUBLIC.JSON_TABLE where first_name='Florina';