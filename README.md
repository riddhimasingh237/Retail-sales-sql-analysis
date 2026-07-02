# Retail-sales-sql-analysis

# Project Overview 
This project focuses on analyzing retail sales transaction data using SQL to understand customer purchasing behavior, overall sales performance, product category trends, and time-based sales patterns. The aim of the project is to transform raw retail transaction data into meaningful business insights that can help retailers make informed decisions related to inventory management, customer targeting, sales strategy, and product performance.

# Project Objectives
1. *Set Up Retail Sales Database*: Create a retail sales database and import the provided sales transaction dataset into SQL Server for analysis.
2. *Data Cleaning*: Check the dataset for missing, null, or incomplete values and remove invalid records to ensure accurate analysis.
3. *Exploratory Data Analysis (EDA)*: Perform basic analysis to understand the structure of the dataset, including total transactions, unique customers, product categories,         sales dates, and overall revenue.
4. *Customer Analysis*: Analyze customer purchasing behavior based on gender, age, spending patterns, and product category preferences.

# Project Structure

#1. Data Exploration and Cleaning
*Record Count*: Determine the total number of records in the dataset.
*Customer Count*: Find out how many unique customers are in the dataset.
*Category Count*: Identify all unique product categories in the dataset.
*Null Value Check*: Check for any null values in the dataset and delete records with missing data.

'''SQL select*
from [Retail Database]
where transactions_id is null or sale_date is null or sale_time is null or customer_id is null or gender is null or age is null	or category is null or quantiy is null or price_per_unit is null or cogs is null or total_sale is null'''


delete 
from [Retail Database]
where transactions_id is null
or sale_date is null or sale_time is null	or customer_id is null or gender is null or category is null or quantiy is null orprice_per_unit is null or cogs is null or total_sale is null

*Data Exploration*
Q1 how many sales are there 
select 
COUNT (transactions_id) as total_sales
from [Retail Database]

Q2 how many unique customers we have
select count(distinct(customer_id))
from [Retail Database]

Q3 how many categories we have
select distinct(category) as categories
from [Retail Database]

# Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:

*Q1  retrieve all columns for sales made on '2022-11-05:*
select* 
from [Retail Database]
where sale_date = '2022-11-05';

*Q2 retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:*
SELECT *
FROM [Retail Database]
WHERE category = 'clothing'
  AND quantiy >= 4
  AND FORMAT(sale_date, 'yyyy-MM') = '2023-01';

  *Q3 calculate the total sales (total_sale) for each category*
  select
  category,
  sum(total_sale) as total_sales
  FROM [Retail Database]
  group by category

  *Q4 find the average age of customers who purchased items from the 'Beauty' category*
  select
  category,
  avg(age) as average_age
  from [Retail Database]
 group by category
 having category='Beauty'

 *Q5 find all transactions where the total_sale is greater than 1000*
 select *
 from [Retail Database]
 where total_sale>1000

 *Q6 find the total number of transactions (transaction_id) made by each gender in each category*
 select 
 gender,
 category,
 COUNT(*) as total_transactions
 from [Retail Database]
 group by gender , category
 
 *Q7 calculate the average sale for each month. Find out best selling month in each year*
 select
 years,
 months,
 Avg_sales 
 from (
 select 
 year(sale_date) as years,
 month(sale_date) as months,
 avg(total_sale) as Avg_sales,
 rank()over(partition by year (sale_date) order by avg(total_sale) desc) as ranks
 from [Retail Database]
 group by year(sale_date),
 month(sale_date) 
 )t
 where ranks = 1

 *Q8 SQL query to find the top 5 customers based on the highest total sales*
 select top 5
 customer_id,
 sum( total_sale) as total_sale
 from [Retail Database]
 group by customer_id
 order by total_sale desc

 *Q9 find the number of unique customers who purchased items from each category*
 select 
 category,
 count(distinct(customer_id)) as unique_customers
 from [Retail Database]
 group by category

*Q10 create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)*

WITH hourly_sale AS
(
    SELECT
        CASE
            WHEN DATEPART(HOUR , sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shifts
    FROM [Retail Database]
)
SELECT
    shifts,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shifts;
