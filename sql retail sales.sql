--DATA CLEANING

/*select* 
from [Retail Database]
where transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	age is null
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or 
	cogs is null
	or
	total_sale is null


delete 
from [Retail Database]
where transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or 
	cogs is null
	or
	total_sale is null*/

--Data Exploration
--  Q1 how many sales are there 
/*select 
COUNT (transactions_id) as total_sales
from [Retail Database]

--how many unique customers we have
select count(distinct(customer_id))
from [Retail Database]

--how many categories we have
select distinct(category) as categories
from [Retail Database]*/

--DATA ANALYSIS AND BUSINESS PROBLEM
--Q1  retrieve all columns for sales made on '2022-11-05:
select* 
from [Retail Database]
where sale_date = '2022-11-05';

--q2 retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT *
FROM [Retail Database]
WHERE category = 'clothing'
  AND quantiy >= 4
  AND FORMAT(sale_date, 'yyyy-MM') = '2023-01';

  -- Q3 calculate the total sales (total_sale) for each category
  select
  category,
  sum(total_sale) as total_sales
  FROM [Retail Database]
  group by category

  --Q4 find the average age of customers who purchased items from the 'Beauty' category
  select
  category,
  avg(age) as average_age
  from [Retail Database]
 group by category
 having category='Beauty'

 --Q5 find all transactions where the total_sale is greater than 1000
 select *
 from [Retail Database]
 where total_sale>1000

 --Q6 find the total number of transactions (transaction_id) made by each gender in each category
 select 
 gender,
 category,
 COUNT(*) as total_transactions
 from [Retail Database]
 group by gender , category
 
 --Q7 calculate the average sale for each month. Find out best selling month in each year:
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

 -- SQL query to find the top 5 customers based on the highest total sales 
 select top 5
 customer_id,
 sum( total_sale) as total_sale
 from [Retail Database]
 group by customer_id
 order by total_sale desc

 --Q9 find the number of unique customers who purchased items from each category
 select 
 category,
 count(distinct(customer_id)) as unique_customers
 from [Retail Database]
 group by category

 --Q10 create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

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



	 



