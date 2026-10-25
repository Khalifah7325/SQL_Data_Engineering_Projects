SELECT *
FROM valid_salaries;

---Scenaario 1 - subquery in 'SELECT'
--- SHIW EACH job's salary next to the overall market
SELECT
    job_title_short,
    salary_year_avg,
    (
      SELECT MEDIAN(salary_year_avg) 
      FROM job_postings_fact
    ) AS market_median_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 10;

--SCENARIO 2 - SUBQUERY IN FRIM
--stage only jobs that are remote before aggregating 

SELECT
    job_title_short,
    MEDIAN(salary_year_avg) AS median_salary,
    (
      SELECT MEDIAN(salary_year_avg) 
      FROM job_postings_fact
      WHERE job_work_from_home = TRUE 
    ) AS market_median_salary
FROM (
    SELECT 
        job_title_short,
        salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE 
) AS clean_jobs
GROUP BY job_title_short
LIMIT 10;

--scenario 3 - subquery in HAVING
-- keep only job titke whose median salary is above the overall mdian:

SELECT
    job_title_short,
    MEDIAN(salary_year_avg) AS median_salary,
    (
      SELECT MEDIAN(salary_year_avg) 
      FROM job_postings_fact
      WHERE job_work_from_home = TRUE 
    ) AS market_median_salary
FROM (
    SELECT 
        job_title_short,
        salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE 
) AS clean_jobs
GROUP BY job_title_short
HAVING MEDIAN(salary_year_avg) > (
    SELECT MEDIAN(salary_year_avg) 
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE 
)
LIMIT 10;

--compare how much more (or less) reomote roles pay comapered to onsite roles for each job titles 
--use CTE to calculate the median salary by title and work arrangement, then compare those median
WITH title_median AS (
    SELECT 
        job_title_short,
        job_work_from_home,
        MEDIAN(salary_year_avg)::INT AS median_salary
    FROM job_postings_fact
    WHERE job_country = 'United States'
    GROUP BY 
        job_title_short,
        job_work_from_home
)

SELECT 
     r.job_title_short,
     r.median_salary AS remote_median_salary,
     o.median_salary AS onsite_median_salary,
     (r.median_salary - o.median_salary) AS remote_premium
FROM title_median AS r
INNER JOIN title_median AS o
    ON r.job_title_short = o.job_title_short
WHERE r.job_work_from_home = TRUE 
    AND o.job_work_from_home = FALSE
ORDER BY remote_premium DESC;