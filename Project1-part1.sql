SHOW DATABASES;
CREATE DATABASE projects;

USE projects;


USE projects;
-- cleaning change the column name
ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;
SELECT * FROM hr; 
-- checking data types
DESCRIBE hr;

SELECT birthdate FROM hr;
-- update the date format in sql format

SET sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE'%/%'THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
    WHEN birthdate LIKE'%-%'THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;

-- change the data type
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;
DESCRIBE hr;

-- correct format for hiredate
UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE'%/%'THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
    WHEN hire_date LIKE'%-%'THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;
SELECT termdate FROM hr;
-- change the data type

UPDATE hr
SET termdate = date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '';


-- Set termdate to '0000-00-00 00:00:00' for NULL or empty values
UPDATE hr
SET termdate = '0000-00-00 00:00:00'
WHERE termdate IS NULL OR termdate = '';

-- Set termdate to '0000-00-00' for NULL or empty values
UPDATE hr
SET termdate = '0000-00-00'
WHERE termdate IS NULL OR termdate = '' OR termdate = '0000-00-00 00:00:00';
SELECT termdate FROM hr;
-- Update invalid dates to NULL
UPDATE hr
SET termdate = NULL
WHERE termdate = '0000-00-00';
-- Modify the termdate column to be of type DATE
ALTER TABLE hr
MODIFY COLUMN termdate DATE;
DESCRIBE hr;

ALTER TABLE hr ADD COLUMN age INT;
SELECT * FROM hr;
-- CALCULATING THE AGE
UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());
SELECT birthdate, age FROM hr;

SELECT
  min(age) AS youngest,
  max(age) AS oldest
FROM hr;
-- count
SELECT count(*) FROM hr WHERE age<18;

