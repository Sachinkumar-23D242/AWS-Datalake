# AWS Data Lake Project

## Overview

This project demonstrates how to build a serverless AWS Data Lake using Amazon S3, AWS Glue, Amazon Athena, and PySpark.

The pipeline ingests raw data into Amazon S3, catalogs it using AWS Glue, performs data cleaning with PySpark, and enables SQL-based analytics using Amazon Athena.

---

## Architecture

Raw Data
↓
Amazon S3
↓
AWS Glue Crawler
↓
Glue Data Catalog
↓
PySpark Data Cleaning
↓
Amazon Athena
↓
SQL Analytics

---

## AWS Services Used

- Amazon S3
- AWS Glue
- AWS Glue Crawler
- AWS Athena
- IAM

---

## Tech Stack

- Python
- PySpark
- SQL
- AWS

---

## Project Structure

```
AWS-Datalake/
│
├── architecture/
├── data/
├── docs/
├── screenshots/
├── scripts/
├── sql/
└── README.md
```

---

## Future Improvements

- Convert CSV files to Parquet
- Automate ETL using AWS Lambda
- Add Amazon QuickSight Dashboard
- Schedule Glue Jobs