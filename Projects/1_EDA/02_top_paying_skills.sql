/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

SELECT 
    s.skills,
    ROUND(MEDIAN(J.salary_year_avg), 0) AS mediam_salary,
    COUNT(DISTINCT j.job_id) AS unique_jobs
FROM job_postings_fact j
INNER JOIN skills_job_dim AS sj ON j.job_id = sj.job_id 
INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id
WHERE 
    j.job_title_short = 'Data Engineer' 
    AND j.job_work_from_home = True
    AND j.salary_year_avg IS NOT NULL
GROUP BY
    s.skills
HAVING COUNT(DISTINCT j.job_id) >= 100
ORDER BY
    mediam_salary DESC
LIMIT 25;


/*
┌────────────┬───────────────┬─────────────┐
│   skills   │ mediam_salary │ unique_jobs │
│  varchar   │    double     │    int64    │
├────────────┼───────────────┼─────────────┤
│ terraform  │      184000.0 │         193 │
│ kubernetes │      150500.0 │         147 │
│ airflow    │      150000.0 │         386 │
│ kafka      │      145000.0 │         292 │
│ go         │      140000.0 │         113 │
│ pyspark    │      140000.0 │         152 │
│ git        │      140000.0 │         208 │
│ spark      │      140000.0 │         503 │
│ aws        │      137320.0 │         783 │
│ scala      │      137290.0 │         247 │
│ gcp        │      136000.0 │         196 │
│ snowflake  │      135500.0 │         438 │
│ java       │      135000.0 │         303 │
│ github     │      135000.0 │         127 │
│ docker     │      135000.0 │         144 │
│ bigquery   │      135000.0 │         123 │
│ hadoop     │      135000.0 │         198 │
│ python     │      135000.0 │        1133 │
│ r          │      134775.0 │         133 │
│ nosql      │      134415.0 │         193 │
│ databricks │      132750.0 │         266 │
│ mysql      │      130500.0 │         101 │
│ redshift   │      130000.0 │         274 │
│ sql        │      130000.0 │        1128 │
│ azure      │      128000.0 │         475 │
└────────────┴───────────────┴─────────────┘
  25 rows                        3 columns

Specialized skills such as Rust, Terraform, and Golang showed
some of the highest median salaries.

However, salary alone does not determine whether a skill is
valuable. Some high-paying skills appeared in relatively few
job postings.

Key Takeaways:
- High salary does not necessarily mean high market demand.
- Minimum sample-size thresholds improve the reliability of
  salary comparisons.
- Median salary is less sensitive to extreme salary values
  than the average.

Data Engineering Concept:
HAVING filters aggregated results after GROUP BY, while WHERE
filters individual rows before aggregation.

POV: BELOW ARE CODE I USED TO TEST SOME PARAMETERS BEFORE BUILDING MY FINAL PROJECT.

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT j.job_id) AS unique_jobs
FROM job_postings_fact AS j
WHERE j.job_title_short = 'Data Engineer'
  AND j.job_work_from_home = TRUE
  AND j.salary_year_avg IS NOT NULL;

SELECT
    MIN(j.salary_year_avg) AS min_salary,
    MAX(j.salary_year_avg) AS max_salary,
    AVG(j.salary_year_avg) AS avg_salary,
    MEDIAN(j.salary_year_avg) AS median_salary
FROM job_postings_fact AS j
WHERE j.job_title_short = 'Data Engineer'
  AND j.job_work_from_home = TRUE
  AND j.salary_year_avg IS NOT NULL;

SELECT
    COUNT(DISTINCT j.job_id) AS terraform_jobs
FROM job_postings_fact AS j
INNER JOIN skills_job_dim AS sj
    ON j.job_id = sj.job_id
INNER JOIN skills_dim AS s
    ON sj.skill_id = s.skill_id
WHERE j.job_title_short = 'Data Engineer'
  AND j.job_work_from_home = TRUE
  AND j.salary_year_avg IS NOT NULL
  AND s.skills = 'terraform';
*/