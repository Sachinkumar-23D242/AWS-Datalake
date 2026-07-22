-- =====================================================
-- AWS ETL Data Pipeline
-- Amazon Athena Table Definitions
-- =====================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS sachin_datalake;

-- Use Database
USE sachin_datalake;

-- =====================================================
-- Orders Table (Parquet)
-- =====================================================

CREATE EXTERNAL TABLE IF NOT EXISTS orders (
    order_id DOUBLE,
    order_date DATE,
    customer_id STRING,
    product_name STRING,
    quantity DOUBLE,
    unit_price DOUBLE,
    category STRING,
    city STRING,
    payment_method STRING,
    order_status STRING
)
STORED AS PARQUET
LOCATION 's3://sachin-after-data-cleaned/orders/';

-- =====================================================
-- Shop Table (Parquet)
-- =====================================================

CREATE EXTERNAL TABLE IF NOT EXISTS shop (
    shop_id STRING,
    shop_name STRING,
    city STRING,
    state STRING,
    region STRING,
    manager_name STRING,
    opened_date DATE,
    shop_category STRING
)
STORED AS PARQUET
LOCATION 's3://sachin-after-data-cleaned/shop/';

-- =====================================================
-- Verify Tables
-- =====================================================

SHOW TABLES;

DESCRIBE orders;

DESCRIBE shop;

-- Preview Data

SELECT *
FROM orders
LIMIT 10;

SELECT *
FROM shop
LIMIT 10;