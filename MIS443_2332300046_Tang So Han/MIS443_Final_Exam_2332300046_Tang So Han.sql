/*
===============================================================================
MIS 443 - FINAL EXAM - SQL SKELETON
Database Management System: PostgreSQL
Duration: 90 minutes | Total: 100 marks

STUDENT ID : 2332300046
FULL NAME  : TANG SO HAN
GITHUB URL : https://github.com/hants1825-sys/MIS443-Final-Exam-2332300046
DATE:27/08/2026
===============================================================================
*/


/*
QUESTION 1 - DATABASE SETUP (10 marks)

(a) Load the database (5 marks)
Create a PostgreSQL database using your full name in lowercase, without spaces
or Vietnamese diacritics. Connect to it and execute the provided file:
MIS443_Customer_Insights_PostgreSQL.sql

Confirm that country, customers, orders, products, and baskets are available
in the public schema.
*/
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN ('country', 'customers', 'orders', 'products', 'baskets')
ORDER BY table_name;

/*
Expected rows:
baskets
country
customers
orders
products
*/
(b) Create the student table (5 marks)
Create public.students with:
- student_id: exactly 10 characters and primary key;
- full_name: required;
- email: required and unique.

Insert your actual information and display the inserted record.
*/

-- Question 1(b): Create public.students.
-- Your answer here
create table students (
student_id varchar(10) primary key, 
full_name varchar(50) not null, 
email varchar(50) unique not null);

-- Question 1(b): Insert your actual information.
-- Your answer here
insert into students (student_id, full_name, email) value
('2332300046','Tang So Han','han.tang.bbs23@eiu.edu.vn');

-- Question 1(b): Display the inserted record.
-- Your answer here

-- Expected result: one row containing the student's actual information.
/*
QUESTION 2 - CUSTOMER PROFILE (10 marks)

The Marketing Manager wants to understand customers who permit marketing
emails. Calculate their average age, name the result average_age, and round it
to two decimal places.
*/

-- Your answer here
SELECT ROUND(AVG(age), 2) AS average_age
FROM customers;

-- Expected result: 37.00
/*
QUESTION 3 - CUSTOMER AND CHANNEL ACTIVITY (20 marks)

(a) Sales-channel activity (10 marks)
	The Sales Manager wants to compare retail and online channel usage. Calculate
	the number of orders for each sales_channel. Name the result total_orders and
	sort it from highest to lowest.
*/

-- Your answer here
SELECT 
    sales_channel,
    COUNT(order_id) AS total_orders
FROM 
    orders
GROUP BY 
    sales_channel
ORDER BY 
    total_orders DESC;
/*
Expected rows:
retail | 5
online | 3
*/

/*
(b) Repeat customers (10 marks)
The Customer Relationship Manager wants to identify customers who placed more
than one order. Display customer_id, age, and total_orders. Sort by total_orders
descending and then customer_id ascending.
*/

-- Your answer here

 
/*
Expected rows:
customer_id 1 | age 23 | 2 orders
customer_id 3 | age 32 | 2 orders
*/

/*
QUESTION 4 - ORDER AND COUNTRY ANALYSIS (20 marks)

(a) Order-monitoring report (10 marks)
Create an order report showing order_id, date_shop, sales_channel, customer age
as customer_age, and country_name. Sort by the newest order date and then by
order_id.
*/

-- Your answer here
SELECT 
    order_id,
    date_shop,
    sales_channel,
    age AS customer_age,
    country_name
FROM 
    orders
ORDER BY 
    date_shop DESC,
    order_id ASC;



/*
Expected rows:
8 | 2023-02-11 | online | 32 | China
7 | 2023-02-05 | retail | 28 | UK
6 | 2023-02-02 | online | 49 | UK
5 | 2023-01-28 | retail | 23 | China
3 | 2023-01-25 | retail | 26 | USA
4 | 2023-01-25 | online | 32 | UK
2 | 2023-01-20 | retail | 25 | UK
1 | 2023-01-16 | retail | 23 | UK
*/

/*
(b) Country performance (10 marks)
Calculate the number of orders for each country, including countries with no
orders. Display country_name and total_orders. Sort by total_orders descending
and then country_name alphabetically.
*/

-- Your answer here
SELECT 
    c.country_name, 
    COUNT(o.order_id) AS total_orders
FROM 
    country c
LEFT JOIN 
    orders o ON c.country_id = o.country_id
GROUP BY 
    c.country_name
ORDER BY 
    total_orders DESC, 
    c.country_name ASC;



/*
Expected rows:
UK    | 5
China | 2
USA   | 1
*/


/*
QUESTION 5 - PRODUCT AND REVENUE ANALYSIS (20 marks)

(a) Category performance (10 marks)
For each product category, calculate total_quantity and total_revenue. Revenue
equals price multiplied by quantity. Round revenue to two decimal places and
sort from highest to lowest revenue.
*/

-- Your answer here
SELECT 
    category,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(price * quantity), 2) AS total_revenue
FROM 
    products
GROUP BY 
    category
ORDER BY 
    total_revenue DESC;


/*
Expected rows:
vitamins | 7 | 66.93
sports   | 3 | 37.47
food     | 6 | 25.74
*/

/*
(b) High-value orders (10 marks)
Calculate the total value of each order and return only orders worth more than
20.00. Display order_id and total_order_value, rounded to two decimal places.
Sort from highest to lowest value.
*/

-- Your answer here


/*
Expected rows:
order 1 | 34.47
order 5 | 22.98
*/

/*
QUESTION 6 - ADVANCED BUSINESS ANALYSIS (20 marks)

(a) Customer purchase recency (10 marks)
For every customer who permits marketing emails, display customer_id, age, and
their latest order date as latest_order_date. Include eligible customers with
no orders and sort by customer_id.
*/

-- Your answer here
SELECT 
    order_id, 
    ROUND(SUM(quantity * price_per_unit), 2) AS total_order_value
FROM 
    order_items
GROUP BY 
    order_id
HAVING 
    SUM(quantity * price_per_unit) > 20.00
ORDER BY 
    total_order_value DESC;


/*
Expected rows:
customer 4 | age 25 | 2023-01-20
customer 5 | age 49 | 2023-02-02
customer 8 | age 37 | NULL
*/


/*
(b) Customer activity ranking (5 marks)
Rank all customers by their number of orders. Customers with equal totals must
receive the same rank without ranking gaps. Include customers with no orders.
Display customer_id, age, total_orders, and activity_rank. Do not use a CTE.
*/

-- Your answer here
SELECT 
    c.customer_id,
    c.age,
    COUNT(o.order_id) AS total_orders,
    DENSE_RANK() OVER (ORDER BY COUNT(o.order_id) DESC) AS activity_rank
FROM 
    customers c
LEFT JOIN 
    orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, 
    c.age
ORDER BY 
    activity_rank ASC;


/*
Expected ranking:
Rank 1: customers 1 and 3 with 2 orders
Rank 2: customers 2, 4, 5, and 6 with 1 order
Rank 3: customers 7 and 8 with 0 orders
*/

/*
(c) Channel performance using a CTE (5 marks)
Use a CTE to calculate each order's total value. Then summarise performance by
sales_channel. Display sales_channel, total_orders, total_revenue, and
average_order_value. Round monetary values to two decimal places and sort by
total_revenue descending.
*/

-- Your answer here




/*
Expected rows:
retail | 5 | 83.81 | 16.76
online | 3 | 46.33 | 15.44
*/

-- END OF EXAM
