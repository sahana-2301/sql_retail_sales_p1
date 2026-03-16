-- SQL Retail Sales Analysis 

-- Create Table

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales (
    transactions_id INt PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

SELECT * FROM retail_sales
LIMIT 10;

-- Count Number of Rows
SELECT COUNT(*) FROM retail_sales;

-- Data Cleaning
-- Null values
SELECT * FROM retail_sales
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

SELECT * FROM retail_sales
WHERE customer_id IS NULL;

SELECT * FROM retail_sales
WHERE gender IS NULL;

SELECT * FROM retail_sales
WHERE age IS NULL;

SELECT * FROM retail_sales
WHERE category IS NULL;

SELECT * FROM retail_sales
WHERE quantity IS NULL;

SELECT * FROM retail_sales
WHERE price_per_unit IS NULL; 

SELECT * FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

-- Deleting NULL values 
DELETE FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR 
	gender IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

-- Count the number of rows
SELECT COUNT(*) FROM retail_sales

-- Check if any null values
SELECT * FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;


-- Data Exploration

-- How many sales do we have now?
SELECT COUNT(*) AS total_sale FROM retail_sales;

-- Unique customers
SELECT COUNT(DISTINCT customer_id) AS total_sale FROM retail_sales;

SELECT DISTINCT category FROM retail_sales;


-- DATA ANALYSIS & BUSINESS KEY PROBLEMS
-- My Analysis & Finding

-- 1. Retrieve all columns for sales made on '2022-11-05
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- 2. Retrieve all transactions where the category is 'Clothing', and the quantity sold is more than 4 in the month of Nov-2022
SELECT transactions_id,	sale_date, category, quantity
FROM retail_sales
WHERE category = 'Clothing' AND TO_CHAR(sale_date, 'YYYY-MM')= '2022-11' AND quantity >= 4;

-- 3. Calculating the total sales (total_sale) for each category.
SELECT category, SUM(total_sale) AS net_sale, COUNT(*) AS total_order
FROM retail_sales
GROUP BY 1;

-- 4. Finding the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age), 2) AS avg_age FROM retail_sales
WHERE category = 'Beauty';

-- 5. Finding all transactions where the total_sale is greater than 1000.
SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- 6. Find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category, gender, COUNT(*) AS total_trans
FROM retail_sales
GROUP BY gender, category
ORDER BY 1;

--7. Calculate the average sale for each month. Find out the best-selling month in each year
SELECT year, month, avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

-- 8. Find the top 5 customers based on the highest total sales 
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- 9. Find the number of unique customers who purchased items from each category
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category







