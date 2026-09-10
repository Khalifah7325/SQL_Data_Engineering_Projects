SELECT *
FROM information_schema.tables
WHERE table_catalog = 'data_jobs';
PRAGMA show_tables_expanded;

   

SHOW TABLES;

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'job_postings_fact';

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'skills_dim';

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'skills_job_dim';

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'company_dim';

SELECT 
    jpf.job_title,
    cd.name AS company_name, 
FROM job_postings_fact jpf
JOIN company_dim cd
    ON jpf.company_id = cd.company_id
LIMIT 10;

SELECT 
    jpf.job_title,
    sd.skills AS skill_name
FROM job_postings_fact jpf
JOIN skills_job_dim sjd
    ON jpf.job_id = sjd.job_id
JOIN skills_dim sd
    ON sjd.skill_id = sd.skill_id;
LIMIT 10;

SELECT
    c.name AS company,
    j.job_title,
    s.skills,
    j.job_location,
    j.salary_year_avg
FROM job_postings_fact j

JOIN company_dim c
    ON j.company_id = c.company_id

JOIN skills_job_dim sj
    ON j.job_id = sj.job_id

JOIN skills_dim s
    ON sj.skill_id = s.skill_id
LIMIT 10;

SELECT *
FROM job_postings_fact j
JOIN skills_job_dim sj
    ON j.job_id = sj.job_id
LIMIT 10;

SELECT
    j.job_title,
    c.name
FROM job_postings_fact AS j
INNER JOIN company_dim AS C 
    ON j.company_id = C.company_id;


SELECT
    j.job_title,
    c.name
FROM job_postings_fact AS j
LEFT JOIN company_dim AS C 
    ON j.company_id = C.company_id
LIMIT 10;

SELECT
    j.job_title,
    c.name
FROM job_postings_fact AS j
RIGHT JOIN company_dim AS C 
    ON j.company_id = C.company_id
WHERE j.job_id IS NULL
LIMIT 10;

SELECT
    sj.job_id,
    sj.skill_id,
    s.skills
FROM skills_job_dim  AS sj
INNER JOIN skills_dim AS s
    ON sj.skill_id = s.skill_id
LIMIT 10;

SELECT
    j.job_id,
    j.job_title_short,
    j.job_title,
    s.skills
FROM job_postings_fact AS j
INNER JOIN skills_job_dim AS sj
    ON j.job_id = sj.job_id
INNER JOIN skills_dim AS s
    ON sj.skill_id = s.skill_id
LIMIT 15;

SELECT 
    j.job_id,
    j.job_title,
    c.name AS company,
    s.skills
FROM job_postings_fact AS j
INNER JOIN company_dim AS c
    ON j.company_id = c.company_id
INNER JOIN skills_job_dim AS sj
    ON j.job_id = sj.job_id
INNER JOIN skills_dim AS s
    ON sj.skill_id=s.skill_id
LIMIT 15;

SELECT 
    j.job_id,
    j.job_title,
    c.name AS company,
    s.skills
FROM job_postings_fact AS j
INNER JOIN company_dim AS c
    ON j.company_id = c.company_id
INNER JOIN skills_job_dim AS sj
    ON j.job_id = sj.job_id
INNER JOIN skills_dim AS s
    ON sj.skill_id=s.skill_id
WHERE j.job_title_short = 'Data Analyst'
    AND s.skills = 'python'
LIMIT 15;


SELECT 
    s.skills,
    COUNT(DISTINCT j.job_id) AS job_count
FROM job_postings_fact AS j
INNER JOIN skills_job_dim AS sj
    ON j.job_id = sj.job_id
INNER JOIN skills_dim AS s
    ON sj.skill_id=s.skill_id
WHERE j.job_title_short = 'Data Analyst'
GROUP BY s.skills
ORDER BY job_count DESC
LIMIT 15;

SELECT 
    s.skills,
    COUNT(DISTINCT j.job_id) AS job_count
FROM job_postings_fact AS j
INNER JOIN skills_job_dim AS sj
    ON j.job_id = sj.job_id
INNER JOIN skills_dim AS s
    ON sj.skill_id=s.skill_id
WHERE j.job_title_short = 'Data Analyst'
    AND j.job_work_from_home = TRUE
GROUP BY s.skills
ORDER BY job_count DESC
LIMIT 15;

SELECT 
    s.skills,
    COUNT(DISTINCT j.job_id) AS job_count
FROM job_postings_fact AS j
INNER JOIN skills_job_dim AS sj
    ON j.job_id = sj.job_id
INNER JOIN skills_dim AS s
    ON sj.skill_id=s.skill_id
WHERE j.job_title_short = 'Data Analyst'
    AND j.job_work_from_home = TRUE
    AND s.skills IN ('python', 'sql')
GROUP BY s.skills
ORDER BY job_count DESC
LIMIT 15;


SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT j.job_id) AS unique_jobs
FROM job_postings_fact AS j
INNER JOIN skills_job_dim AS sj
    ON j.job_id = sj.job_id
INNER JOIN skills_dim AS s
    ON sj.skill_id = s.skill_id
WHERE j.job_title_short = 'Data Analyst';

SELECT
    s.skills,
    COUNT(*) AS total_rows,
    COUNT(DISTINCT j.job_id) AS unique_jobs
FROM job_postings_fact AS j
INNER JOIN skills_job_dim AS sj
    ON j.job_id = sj.job_id
INNER JOIN skills_dim AS s
    ON sj.skill_id = s.skill_id
WHERE j.job_title_short = 'Data Analyst'
GROUP BY s.skills
ORDER BY unique_jobs DESC
LIMIT 5;