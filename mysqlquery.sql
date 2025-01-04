drop table if exists retail_Sales; -- delete existing tables
create table retail_Sales
(
transactions_id int primary key,
sale_date date,
sale_time time,	
customer_id	int,
gender varchar(15),
age	int,
category varchar(20),	
quantiy	float ,
price_per_unit float,
cogs float ,
total_sale float
)
-- Data Cleaning--

select * from retail_sales
limit 10
select count(*) from retail_sales

-- find null values in any of column --
select * from retail_sales
where price_per_unit is null

-- find null value in  whole table--
select * from retail_sales
where
transactions_id is null
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

--delete null value from table --

delete from retail_sales
where
transactions_id is null
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
 select * from retail_sales

--EDA Data exploration -- 

--How many sales we have --
select count(total_sale) from retail_sales
--How Many unique customer we have--
select count(distinct customer_id) from retail_sales
--how many unique category we have
select count(distinct category) from retail_sales
--how many unique category we have by name--
select distinct category from retail_sales

-- data Analysis or Business key Problem and Answer--

--1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * 
FROM retail_sales
WHERE sale_date=  '2022-11-05' and category = 'Beauty'
 
  
--2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4
	
--3. Write a SQL query to calculate the total sales (total_sale) for each category.:
select category , sum(total_sale) from retail_sales
group by category

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
 select round(Avg(age),2) from retail_sales
 where category = 'Beauty'
 group by category 

--5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
 select  total_sale from retail_sales
 where total_sale >1000
 
-- 6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select * from retail_sales
select gender, category  as c,count(transactions_id) as t from retail_sales
group by c, gender
order by t desc

--7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
--In this SQL query, there are two SELECT statements because the first one (the inner query or subquery) is used to calculate the ranking of the data, and the second one (the outer query) filters the results to show only the top-ranked rows (those with rank = 1). This is a common technique used when you want to perform calculations or apply window functions (like RANK()) and then filter or process those results further.

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year, --1
    EXTRACT(MONTH FROM sale_date) as month, --2
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1
--8 **Write a SQL query to find the top 5 customers based on the highest total sales **:

select * from retail_sales
select 
customer_id as c , 
sum(total_sale) as t
from retail_sales
group by c
order by  t desc
limit 5
-- 9 Write a SQL query to find the number of unique customers who purchased items from each category.:
select category, 
count( distinct customer_id) 
from retail_sales
group by category
--10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):


WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift







