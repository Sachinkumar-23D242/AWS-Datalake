# AWS Data Lake using Amazon S3, AWS Glue, Athena & PySpark

## Project Overview

This project demonstrates how to build a serverless AWS Data Lake using Amazon S3, AWS Glue, Amazon Athena, and PySpark.

The pipeline stores raw data in Amazon S3, catalogs it using AWS Glue, cleans and transforms data with PySpark, and enables SQL-based analytics through Amazon Athena.

---

## Tech Stack

- Python
- PySpark
- SQL
- Amazon S3
- AWS Glue
- AWS Glue Crawler
- Amazon Athena
- IAM

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
│   └── Data_cleaning.py
├── sql/
└── README.md
```

---

## Workflow

1. Upload raw data to Amazon S3.
2. Catalog the data using AWS Glue Crawler.
3. Clean and transform data with PySpark.
4. Query the processed data using Amazon Athena.
5. Analyze results with SQL.

---

## Future Improvements

- Convert CSV data to Parquet format.
- Partition datasets for faster Athena queries.
- Automate ETL using AWS Lambda.
- Visualize data with Amazon QuickSight.