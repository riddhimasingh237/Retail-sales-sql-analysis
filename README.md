# Retail-sales-sql-analysis

# Project Overview 
This project focuses on analyzing retail sales transaction data using SQL to understand customer purchasing behavior, overall sales performance, product category trends, and time-based sales patterns. The aim of the project is to transform raw retail transaction data into meaningful business insights that can help retailers make informed decisions related to inventory management, customer targeting, sales strategy, and product performance.

# Project Objectives
1. **Set Up Retail Sales Database**: Create a retail sales database and import the provided sales transaction dataset into SQL Server for analysis.
2. **Data Cleaning**: Check the dataset for missing, null, or incomplete values and remove invalid records to ensure accurate analysis.
3. **Exploratory Data Analysis (EDA)**: Perform basic analysis to understand the structure of the dataset, including total transactions, unique customers, product categories,sales dates, and overall revenue.
4. **Customer Analysis**: Analyze customer purchasing behavior based on gender, age, spending patterns, and product category preferences.

# Project Structure

# Data Exploration and Cleaning

**1. Record Count**: Determine the total number of records in the dataset.
**2. Customer Count**: Find out how many unique customers are in the dataset.
**3. Category Count**: Identify all unique product categories in the dataset.
**4. Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
select*
from [Retail Database]
where transactions_id is null or sale_date is null or sale_time is null or customer_id is null or gender is null or age is null	or category is null or quantiy is null or price_per_unit is null or cogs is null or total_sale is null
```

```sql
delete 
from [Retail Database]
where transactions_id is null
or sale_date is null or sale_time is null	or customer_id is null or gender is null or category is null or quantiy is null orprice_per_unit is null or cogs is null or total_sale is null
```

**Data Exploration**

**Q1 how many sales are there**
 ```sql
 SELECT *
 FROM retail_sales
 WHERE sale_date = '2022-11-05';
 ```

**Q2 how many unique customers we have**
 ```sql
select count(distinct(customer_id))
 from [Retail Database]
```

**Q3 how many categories we have**
```sql
select distinct(category) as categories
from [Retail Database]
```

# Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:

**Q1  retrieve all columns for sales made on '2022-11-05:**
```sql
select* 
from [Retail Database]
where sale_date = '2022-11-05';
```

**Q2 retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:**
```sql
SELECT *
FROM [Retail Database]
WHERE category = 'clothing'
  AND quantiy >= 4
  AND FORMAT(sale_date, 'yyyy-MM') = '2023-01';
```

 **Q3 calculate the total sales (total_sale) for each category**
  ```sql
select
  category,
  sum(total_sale) as total_sales
  FROM [Retail Database]
  group by category
```

  **Q4 find the average age of customers who purchased items from the 'Beauty' category**
  ```sql
select*
  category,
  avg(age) as average_age
  from [Retail Database]
 group by category
 having category='Beauty'
```

 **Q5 find all transactions where the total_sale is greater than 1000**
 ```sql
select *
 from [Retail Database]
 where total_sale>1000
```

 **Q6 find the total number of transactions (transaction_id) made by each gender in each category**
 ```sql
select 
 gender,
 category,
 COUNT(*) as total_transactions
 from [Retail Database]
 group by gender , category
```
 
 **Q7 calculate the average sale for each month. Find out best selling month in each year**
```sql
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
```

**Q8 SQL query to find the top 5 customers based on the highest total sales**
 ```sql
select top 5
 customer_id,
 sum( total_sale) as total_sale
 from [Retail Database]
 group by customer_id
 order by total_sale desc
```

 **Q9 find the number of unique customers who purchased items from each category**
 ```sql
select 
 category,
 count(distinct(customer_id)) as unique_customers
 from [Retail Database]
 group by category
```

**Q10 create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**

```sql
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
```

## Key Findings

* The retail sales dataset was successfully cleaned by identifying and removing records with missing or null values, ensuring reliable analysis.
* The analysis revealed the total number of sales transactions, unique customers, and product categories available in the dataset.
* Product categories showed different levels of sales performance, helping identify categories that generated higher revenue and attracted more customer purchases.
* High-value transactions were identified to understand purchases with total sales above a specified amount.
* Customer purchasing behavior varied across gender and age groups, indicating that different customer segments may have different product preferences.
* The analysis identified the average age of customers purchasing products from each category, which can support targeted marketing strategies.
* Monthly sales analysis helped identify the best-performing months in each year based on sales performance.
* The top customers were identified based on their total spending, highlighting customers who contribute significantly to overall revenue.
* Sales activity differed across Morning, Afternoon, and Evening shifts, providing insights into peak purchasing hours.
* The project demonstrates that SQL can be used to convert raw retail transaction data into useful business insights for improving customer targeting, inventory planning, and sales strategy.

