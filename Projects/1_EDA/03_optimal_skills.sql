SELECT 
    s.skills,
    MEDIAN(j.salary_year_avg) AS mediam_salary,
    COUNT(DISTINCT j.job_id) AS unique_jobs,
    ROUND(LN(COUNT(DISTINCT j.job_id)), 1) AS ln_unique_jobs,
    ROUND(
        (LN(COUNT(DISTINCT j.job_id)) * MEDIAN(j.salary_year_avg)) / 1000000,
        2
    ) AS optimal_score
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
    optimal_score DESC
LIMIT 25;

/* 
┌────────────┬───────────────┬─────────────┬────────────────┬───────────────┐
│   skills   │ mediam_salary │ unique_jobs │ ln_unique_jobs │ optimal_score │
│  varchar   │    double     │    int64    │     double     │    double     │
├────────────┼───────────────┼─────────────┼────────────────┼───────────────┤
│ terraform  │      184000.0 │         193 │            5.3 │          0.97 │
│ python     │      135000.0 │        1133 │            7.0 │          0.95 │
│ sql        │      130000.0 │        1128 │            7.0 │          0.91 │
│ aws        │   137320.3125 │         783 │            6.7 │          0.91 │
│ airflow    │      150000.0 │         386 │            6.0 │          0.89 │
│ spark      │      140000.0 │         503 │            6.2 │          0.87 │
│ kafka      │      145000.0 │         292 │            5.7 │          0.82 │
│ snowflake  │      135500.0 │         438 │            6.1 │          0.82 │
│ azure      │      128000.0 │         475 │            6.2 │          0.79 │
│ java       │      135000.0 │         303 │            5.7 │          0.77 │
│ scala      │ 137290.484375 │         247 │            5.5 │          0.76 │
│ kubernetes │      150500.0 │         147 │            5.0 │          0.75 │
│ git        │      140000.0 │         208 │            5.3 │          0.75 │
│ databricks │      132750.0 │         266 │            5.6 │          0.74 │
│ redshift   │      130000.0 │         274 │            5.6 │          0.73 │
│ gcp        │      136000.0 │         196 │            5.3 │          0.72 │
│ hadoop     │      135000.0 │         198 │            5.3 │          0.71 │
│ nosql      │      134415.0 │         193 │            5.3 │          0.71 │
│ pyspark    │      140000.0 │         152 │            5.0 │           0.7 │
│ docker     │      135000.0 │         144 │            5.0 │          0.67 │
│ go         │      140000.0 │         113 │            4.7 │          0.66 │
│ r          │      134775.0 │         133 │            4.9 │          0.66 │
│ bigquery   │      135000.0 │         123 │            4.8 │          0.65 │
│ github     │      135000.0 │         127 │            4.8 │          0.65 │
│ mysql      │      130500.0 │         101 │            4.6 │           0.6 │
└────────────┴───────────────┴─────────────┴────────────────┴───────────────┘
  25 rows                                                         5 columns


Terraform achieved the highest Optimal Skills Score, combining
a relatively high median salary with meaningful job demand.

Python and SQL also ranked highly because of their very strong
job-market demand.

AWS, Airflow, Spark, Kafka, Snowflake, and Kubernetes also showed
a strong balance between demand and compensation.

Key Takeaways:
- Terraform ranked highest in the custom scoring model.
- Python and SQL remain essential foundational skills.
- AWS, Spark, Airflow, Kafka, and Snowflake offer strong combinations
  of demand and compensation.
- Highly paid skills are not automatically optimal if demand is low.

Data Engineering Concept:

This analysis demonstrates how raw relational data can be transformed
into a derived business metric that supports decision-making.

*/