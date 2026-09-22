--SQL retail sales analysis - project_1

-- create table

create table retail_sales(
	transactions_id	int primary key,
	sale_date date,	
	sale_time time,	
	customer_id	int,
	gender varchar(15),	
	age	int,
	category varchar(20),	
	quantiy	int,
	price_per_unit float,	
	cogs float,	
	total_sale float
);

-- delete all null values from table

delete from retail_sales
where(
	transactions_id is null or
	sale_date is null or
	sale_time is null or
	customer_id is null or
	gender is null or
	age is null or
	category is null or
	quantity is null or
	price_per_unit is null or
	cogs is null or
	total_sale is null
);

-- data exploration

-- how many sales we have?

select count(total_sale) from retail_sales;

-- how many unique customers we have?

select count(distinct customer_id) unique_customer from retail_sales;

--how many unique categories we have?

select distinct category from retail_sales;

-- data analysis & business key problem and answers....

--Q1: Write a SQL query to retrieve all columns for sales made on '2022-11-05'

select*from retail_sales
where sale_date='2022-11-05';

--Q2: Write a SQL query to retrieve all transactions where the category is 'Clothing' 
--and the quantity sold is more than 3 in the month of Nov-2022?

select gender,age,category,quantity,sale_date
from retail_sales 
where (
	category='Clothing'
	and 
	to_char(sale_date, 'mm-yyyy')='11-2022'
	and
	quantity >= 3
)
order by 4 desc;

--Q3: Write a SQL query to calculate the total sales (total_sale) for each category?

select category,sum(total_sale) as total_sales,sum(quantity) as quantity,count(*) as total_order
from retail_sales
group by 1
order by 1;

--Q4: Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category?

select category, round(avg(age), 2) as avg_age 
from retail_sales
where category='Beauty'
group by 1;

--Q5: Write a SQL query to find all transactions where the total_sale is greater than 1000?

select customer_id,age,category,gender,total_sale
from retail_sales
where total_sale>=1000
order by 5 desc;

--Q6: Write a SQL query to find the total number of 
--transactions (transaction_id) made by each gender in each category?

select count(transactions_id) total_transaction , gender,category
from retail_sales
group by 2,3
order by 3;

--Q7: Write a SQL query to calculate the average sale for each month. Find out best selling month in each year?

select 
	year,month, round(avg_sales)
from (
select 
	extract(year from sale_date) as year,
	extract(month from sale_date) as month,
	avg(total_sale) as avg_sales,
	rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
from retail_sales
group by 1,2
) as t1
where rank=1;

--Q8: Write a SQL query to find the top 5 customers based on the highest total sales?

select
distinct customer_id,sum(total_sale)
from retail_sales
group by 1
order by 2 desc
limit 5;

--Q9: Write a SQL query to find the number of unique customers who purchased items from each category?

select
category, count(distinct customer_id) as unique_customer
from retail_sales
group by 1
order by 1;

--Q10: Write a SQL query to create each shift and number of orders 
--(Example Morning <12, Afternoon Between 12 & 17, Evening >17)

with hourly_sale as(
select *,
case
when extract(hour from sale_time)<12 then 'Morning'
when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as shift
from retail_sales
)
select shift, count(*) as total_order
from hourly_sale
group by shift




















