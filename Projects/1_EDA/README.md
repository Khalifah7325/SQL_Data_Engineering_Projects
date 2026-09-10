# 🔎 Exploratory Data Analysis: Data Engineering Job Market

An SQL-based analysis of the Data Engineering job market to identify the **most demanded, highest-paying, and optimal skills** for aspiring Data Engineers.

## 🧾 Executive Summary

This project analyzes Data Engineering job postings to understand which technical skills are most valuable in the job market.

Using SQL, I analyzed:

* 📈 **Top Demanded Skills**
* 💰 **Top Paying Skills**
* ⚖️ **Optimal Skills** — balancing demand and salary

The analysis uses a relational data model and multi-table SQL queries to transform job and skill data into actionable insights.

## 🎯 Problem & Context

Data Engineering requires a broad range of technical skills, making it difficult to know which skills to prioritize.

This project answers three questions:

1. Which skills are most frequently requested?
2. Which skills are associated with higher salaries?
3. Which skills provide the best balance between demand and earning potential?

## 🧰 Tools & Technologies

* **SQL** — Data analysis and transformation
* **DuckDB** — Analytical SQL database
* **Git & GitHub** — Version control and documentation
* **VS Code** — SQL development environment

## 🗂️ Data Model

The dataset follows a dimensional structure consisting of fact, dimension, and bridge tables.

* `job_postings_fact` — Job posting and salary information
* `company_dim` — Company information
* `skills_dim` — Skill definitions
* `skills_job_dim` — Bridge table connecting jobs and skills

### Data Warehouse Schema

![Data Warehouse Schema](./images/1_2_Data_Warehouse.png)

The `skills_job_dim` table represents a **many-to-many relationship** between jobs and skills.

## 📊 Analysis

### 01 — Top Demanded Skills


Identified the skills most frequently requested in Data Engineer job postings using unique job counts.

**Key finding:** Python and SQL were the most frequently requested skills, followed by AWS, Spark, Azure, and Snowflake.

👉[View 01_top_demanded_skills.sql](./Projects/1_EDA/01_top_demanded_skills.sql)

### 02 — Top Paying Skills

Compared median annual salaries across skills while applying a minimum job-count threshold to reduce the effect of very small samples.

**Key finding:** Specialized skills such as Rust, Terraform, and Golang showed high median salaries, although some had relatively low demand.

[👉02_top_paying_skills.sql](./Projects/1_EDA/02_top_paying_skills.sql)

### 03 — Optimal Skills

Created a custom **Optimal Skills Score** combining skill demand and median salary:

```text
Optimal Score = LN(Demand) × Median Salary / 1,000,000
```

**Key finding:** Terraform ranked highest, followed by Python, AWS, Airflow, Spark, and SQL.

[👉 03_optimal_skills.sql`](./Projects/1_EDA/03_optimal_skills.sql)

## 💡 Key Insights

* 🐍 **Python** and **SQL** remain foundational Data Engineering skills.
* ☁️ **AWS**, **Spark**, and **Snowflake** showed strong market demand.
* ⚙️ **Terraform**, **Airflow**, **Kafka**, and **Kubernetes** provided a strong balance between demand and compensation.
* 💰 High salary alone does not necessarily make a skill optimal; **demand and sample size matter**.
* 🔍 Query results must be validated against known totals and business logic. A query executing successfully does not guarantee a correct result.

## 🧠 Data Engineering Concepts Demonstrated

* **Dimensional Modeling** — Working with fact and dimension tables.
* **Many-to-Many Relationships** — Using a bridge table to connect jobs and skills.
* **Data Transformation** — Joining and aggregating data across multiple tables.
* **Data Quality** — Using `COUNT(DISTINCT)` and validating unexpected results.
* **Analytical SQL** — `JOIN`, `GROUP BY`, `HAVING`, `MEDIAN()`, derived metrics, and `LN()`.
* **Business Logic** — Turning raw job data into meaningful decision-making metrics.

## 🚀 Key Takeaway

This project strengthened my SQL and data modeling skills while showing how analytical SQL can be used to answer real-world business questions.

The main takeaway:

> **Strong Data Engineers need more than the ability to write queries — they need to understand how data is modeled, transformed, validated, and used to support decisions.**
