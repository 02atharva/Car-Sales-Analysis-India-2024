-- Database Created 
CREATE DATABASE car_sales_db;
USE car_sales_db;

-- Create Table
CREATE TABLE car_sales (
    make VARCHAR(50),
    model VARCHAR(50),
    month VARCHAR(20),
    sales INT,
    total INT,
    segment VARCHAR(20),
    body_type VARCHAR(20),
    mom_pct INT,
    yoy_pct INT
);

-- 1) View data
SELECT * FROM car_sales;

-- 2) Total records
SELECT COUNT(*) AS total_rows FROM car_sales;

-- 3) Unique brands
SELECT DISTINCT make FROM car_sales;

-- 4) Unique models per brand
SELECT make, COUNT(DISTINCT model) AS model_count
FROM car_sales
GROUP BY make;

-- 5) Total sales overall
SELECT SUM(sales) AS total_sales FROM car_sales;

-- 6) Total sales by brand
SELECT make, SUM(sales) AS total_sales
FROM car_sales
GROUP BY make
ORDER BY total_sales DESC;

-- 7) Total sales by model
SELECT make, model, SUM(sales) AS model_sales
FROM car_sales
GROUP BY make, model
ORDER BY model_sales DESC;

-- 8) Monthly total sales
SELECT month, SUM(sales) AS monthly_sales
FROM car_sales
GROUP BY month;

-- 9) Best performing month
SELECT month, SUM(sales) AS sales
FROM car_sales
GROUP BY month
ORDER BY sales DESC
LIMIT 1;

-- 10) Brand performance per month
SELECT month, make, SUM(sales) AS sales
FROM car_sales
GROUP BY month, make
ORDER BY month, sales DESC;

-- 11) Sales by segment
SELECT segment, SUM(sales) AS sales
FROM car_sales
GROUP BY segment
ORDER BY sales DESC;

-- 12) Sales by body type
SELECT body_type, SUM(sales) AS sales
FROM car_sales
GROUP BY body_type
ORDER BY sales DESC;

-- 13)  MoM growth by brand
SELECT make, ROUND(AVG(mom_pct), 2) AS avg_mom_growth
FROM car_sales
GROUP BY make
ORDER BY avg_mom_growth DESC;

-- 14) Average YoY growth by segment
SELECT segment, ROUND(AVG(yoy_pct), 2) AS avg_yoy_growth
FROM car_sales
GROUP BY segment
ORDER BY avg_yoy_growth DESC;

-- 15) Models with negative YoY growth
SELECT DISTINCT make, model
FROM car_sales
WHERE yoy_pct < 0;

-- 16) Top 5 selling models
SELECT make, model, SUM(sales) AS sales
FROM car_sales
GROUP BY make, model
ORDER BY sales DESC
LIMIT 5;

-- 17) Bottom 5 selling models
SELECT make, model, SUM(sales) AS sales
FROM car_sales
GROUP BY make, model
ORDER BY sales ASC
LIMIT 5;

-- 18) Brand contribution to total sales
SELECT 
    make,
    ROUND(SUM(sales) * 100.0 / (SELECT SUM(sales) FROM car_sales), 2) AS market_share
FROM car_sales
GROUP BY make
ORDER BY market_share DESC;

-- 19) Models with high sales but low growth
SELECT make, model, SUM(sales) AS sales, AVG(yoy_pct) AS yoy
FROM car_sales
GROUP BY make, model
HAVING sales > 10000 AND yoy < 5;

