show databases;
use project_orders;
show tables;
select * from aisles;
describe aisles;
describe departments;
describe order_products_train;
describe orders;
describe products;
SELECT * FROM aisles;

SELECT * FROM departments;

SELECT * FROM products;

SELECT * FROM orders;

SELECT * FROM order_products_train;


describe order_products_train;


# Question 1: What are the Top 10 aisles with the highest number of products?

select a.aisle, count(*) as total_products from products p join  aisles a on p.aisle_id=a.aisle_id group by a.aisle
order by total_products desc  limit 10;

# Question 2: How many unique departments are there in the dataset?

select count(*) total_dept from departments;

# Question 3: What is the distribution of products across departments?

select d.department, count(*) as total_prod from products p join
departments d on  p.department_id=d.department_id group by d.department order by total_prod desc;

# Question 4: What are the Top 10 products with the highest reorder rates?






# Question 5 : How many unique users have placed orders in the dataset?

select count(distinct user_id) as total_users from orders;

# Question 6: What is the average number of days between orders for each user?

select  avg(days_since_prior_order) as average_day_bw_orders from orders;


# Question 7: What are the peak hours of order placement during the day?

select order_hour_of_day, count(*) as total_orders from orders group by order_hour_of_day 
order by total_orders desc;


# Question 8: How does order volume vary by day of the week?

select order_dow, count(*) as Total_order from orders
group by order_dow 
order by  Total_order desc;


# Question 9: What are the Top 10 Most Ordered Products?

select p.product_name, count(*) as total_order from order_products_train op join products p on p.product_id=op.product_id 
group by product_name order by total_order desc
limit 10;

# Question 10: How many users have placed orders in each department?

select d.department, count(distinct o.user_id) as Total_user from orders o
join order_products_train t on o.order_id=t.order_id
join products p on  t.product_id=p.product_id
join departments d on p.department_id=d.department_id
group by department order by total_user desc;


# Question 11: What is the average number of products per order?
#1
select avg(total_products) as avg_prod from (select o.order_id, count(*)  as total_products from products p join order_products_train t on p.product_id=t.product_id
join orders o on t.order_id=o.order_id
group by o.order_id order by total_products desc)
as order_sum;

#2
SELECT AVG(total_products) AS avg_products_per_order
FROM (
    SELECT
        order_id,
        COUNT(*) AS total_products
    FROM order_products_train
    GROUP BY order_id
) AS order_summary;



# Question 12: What are the most reordered products in each department?

SELECT
    d.department,
    p.product_name,
    SUM(op.reordered) AS reorder_count
FROM order_products_train op
JOIN products p
    ON op.product_id = p.product_id
JOIN departments d
    ON p.department_id = d.department_id
GROUP BY d.department, p.product_name;



# Question 13:

SELECT COUNT(*) AS products_reordered_more_than_once
FROM (
    SELECT
        product_id,
        SUM(reordered) AS reorder_count
    FROM order_products_train
    GROUP BY product_id
    HAVING SUM(reordered) > 1
) AS reordered_products;


# Question 14:  What is the average reorder rate by department?

select d.department,avg(reordered)*100 as reorder_rate from order_products_train t 
join products p on t.product_id=p.product_id
join departments d on p.department_id=d.department_id
group by d.department
order by reorder_rate desc;


# Question 15: Which users have the highest reorder ratio?

select o.user_id, round(avg(reordered)*100,2) as reorder_rate from order_products_train t
join orders o on t.order_id=o.order_id
group by o.user_id
order by reorder_rate desc
limit 10;

# Question 15: Which department has the highest number of orders?

select d.department, count(distinct order_id) total_order from order_products_train t 
join products p on p.product_id=t.product_id
join departments d on p.department_id=d.department_id
group by d.department
order by Total_order desc
limit 10;


# Question 16: What is the distribution of order sizes (number of products per order)?

SELECT
    order_id,
    COUNT(product_id) AS Order_Size
FROM order_products_train
GROUP BY order_id
order by Order_size desc
limit 20;


# Question 17: Which day of the week has the highest number of orders?

select case 
order_dow
when "0" then "SUNDAY"
when "1" then "MONDAY"
when '2' then "TUESDAY"
when '3' then "WEDNESDAY"
when '4' then "THURSDAY"
when '5' then "FRIDAY"
when '6' then "SATURDAY"
end as DAY_NAME,  count(*) as total_ord from orders
group by order_dow
order by total_ord desc;


# Question 18:Which users have placed the highest number of orders?

SELECT
    user_id,
    COUNT(*) AS total_orders
FROM orders
GROUP BY user_id
ORDER BY total_orders DESC
LIMIT 10;

# Question 19: What are the top 10 users with the highest number of orders?

select  count(order_id) as total_ord from orders
group by user_id
order by total_ord desc
limit 10;

# Question 20: What is the distribution of orders by hour of the day?

SELECT
    order_hour_of_day,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_hour_of_day
ORDER BY total_orders DESC
LIMIT 1;

