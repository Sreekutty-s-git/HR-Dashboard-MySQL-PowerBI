-- qsn
-- what is the gender breakdown of employees in the co?
SELECT gender, count(*) AS count
FROM hr
WHERE age>=18 AND termdate IS NULL
GROUP BY gender;

-- what is the race/ethinicity of employees in the co?
SELECT race, count(*) AS count
FROM hr
WHERE age>=18 AND termdate IS NULL
GROUP BY race
order by count(*) desc;

-- 3. wht is the age distribution of employees in the co?
SELECT
 min(age) as youngest,
 max(age) as oldest
FROM hr
WHERE age>=18 and termdate IS NULL;

SELECT
 CASE
  WHEN age>=18 AND age<=24 THEN '18-24'
  WHEN age>=25 AND age<=34 THEN '25-34'
  WHEN age>=35 AND age<=44 THEN '35-44'
  WHEN age>=45 AND age<=54 THEN '45-54'
  WHEN age>=55 AND age<=64 THEN '55-64'
  ELSE '65+'
END AS age_group,
count(*) AS count
FROM hr
WHERE age>=18 and termdate IS NULL
GROUP BY age_group
ORDER BY age_group;

SELECT
 CASE
  WHEN age>=18 AND age<=24 THEN '18-24'
  WHEN age>=25 AND age<=34 THEN '25-34'
  WHEN age>=35 AND age<=44 THEN '35-44'
  WHEN age>=45 AND age<=54 THEN '45-54'
  WHEN age>=55 AND age<=64 THEN '55-64'
  ELSE '65+'
END AS age_group, gender,
count(*) AS count
FROM hr
WHERE age>=18 and termdate IS NULL
GROUP BY age_group, gender
ORDER BY age_group, gender;

-- how many employees work at headquarters versus remote loca?
SELECT location, count(*) AS count
FROM hr
WHERE age>=18 AND termdate IS NULL
GROUP BY location;

-- wha is the avg length of employment for employees who have been terminated?
SELECT
 round(avg(datediff(termdate, hire_date))/365,0) AS avg_length_empl
 FROM hr
 WHERE termdate<=curdate() AND termdate IS NOT NULL AND age >= 18;
 
 -- how does the gender distribution vary across departmnt and job titles?
 SELECT department, gender, count(*) as count
 FROM hr
 WHERE age>=18 AND termdate IS NULL
 GROUP BY department, gender
 ORDER BY department;
 
 -- what is the distri of job titles across the compan?
SELECT jobtitle, count(*) as count
 FROM hr
 WHERE age>=18 AND termdate IS NULL
 GROUP BY jobtitle
 ORDER BY jobtitle DESC;
 
 -- which depart has the higest turnover rate?
 SELECT department,
 total_count,
 terminated_count,
 terminated_count/total_count as termination_rate
FROM (
 SELECT department, 
 count(*) as total_count,
 sum(CASE WHEN termdate is not null and termdate <= curdate() THEN 1 ELSE 0 END) as terminated_count
 FROM hr
 WHERE age>=18
 GROUP BY department
 ) as subquery
 ORDER BY termination_rate DESC;
 
 -- what is the distribution of employees across loca by city and state?
 SELECT location_state, count(*) as count
 FROM hr
WHERE age>=18 and termdate is not null
GROUP BY location_state
ORDER BY count DESC;

-- how the no of employee count changed over time based on hire and term date?
SELECT 
  year,
  hires,
  terminations,
  hires - terminations as net_change,
  round((hires - terminations) / hires * 100, 2) as net_change_percent
FROM (
  SELECT year(hire_date) as year, 
         count(*) as hires,
         sum(case when termdate is not null and termdate <= curdate() then 1 else 0 end) as terminations
  FROM hr
  WHERE age >= 18
  GROUP BY year(hire_date)
) as subquery
ORDER BY year ASC;

-- WHAT is the tenure distribution for each department?
SELECT department, round(avg(datediff(termdate, hire_date)/365), 0) as avg_tenure
from hr
WHERE termdate <=curdate() and termdate is not null and age >= 18
 GROUP BY department;
