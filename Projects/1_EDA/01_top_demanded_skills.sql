/*
Question: What are the most in-demand skills for data engineers?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/

SELECT 
    s.skills,
    COUNT(DISTINCT j.job_id) as unique_jobs
FROM job_postings_fact j
INNER JOIN skills_job_dim sj ON j.job_id = sj.job_id 
INNER JOIN skills_dim s ON sj.skill_id = s.skill_id
WHERE 
    j.job_title_short = 'Data Engineer' 
    AND j.job_work_from_home = True
GROUP BY
    s.skills
ORDER BY
    unique_jobs DESC
LIMIT 10;

/*
┌────────────┬─────────────┐
│   skills   │ unique_jobs │
│  varchar   │    int64    │
├────────────┼─────────────┤
│ sql        │       29221 │
│ python     │       28776 │
│ aws        │       17823 │
│ azure      │       14143 │
│ spark      │       12799 │
│ airflow    │        9996 │
│ snowflake  │        8639 │
│ databricks │        8183 │
│ java       │        7267 │
│ gcp        │        6446 │
└────────────┴─────────────┘
  10 rows        2 columns

Python and SQL were the most frequently requested skills,
followed by AWS, Spark, Azure, and Snowflake.

Key Takeaways:
- Python and SQL remain foundational Data Engineering skills.
- Cloud platforms such as AWS and Azure are highly valuable.

Data Engineering Concept:
COUNT(DISTINCT job_id) is used to avoid double-counting jobs
because one job can be associated with multiple skills.
*/