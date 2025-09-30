
CREATE TABLE sales (
  "customer_id" VARCHAR(1),
  "order_date" DATE,
  "product_id" INTEGER
);


INSERT INTO sales
  ("customer_id", "order_date", "product_id")
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3')

CREATE TABLE menu (
  "product_id" INTEGER,
  "product_name" VARCHAR(5),
  "price" INTEGER
)

INSERT INTO menu
  ("product_id", "product_name", "price")
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12')
  

CREATE TABLE members (
  "customer_id" VARCHAR(1),
  "join_date" DATE
)

INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');

  select * from dannys_diner.menu;
 
 select * from dannys_diner.members;
  select * from dannys_diner.sales;


-- 1. What is the total amount each customer spent at the restaurant?
SELECT s.customer_id, SUM(m.price) AS total_spent
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id;

--2. How many days has each customer visited the restaurant?
select customer_id, count(distinct order_date) as visit_days
from sales
group by customer_id
order by customer_id;    


select sales.customer_id, count(distinct(sales.order_date)) 
from sales
group by customer_id
order by count desc;

select * from dannys_diner.sales;

-- 3. What was the first item from the menu purchased by each customer?

select * from dannys_diner.menu;
select * from dannys_diner.members;
select * from dannys_diner.sales;

select distinct sales.customer_id, min(sales.order_date), menu.product_name
from menu
left join sales
on menu.product_id = sales.product_id
group by  sales.product_id, menu.product_name,  sales.customer_id
order by sales.customer_id;

select distinct sales.product_id, menu.product_name, sales.order_date, sales.customer_id
from sales
left join menu
on menu.product_id = sales.product_id
order by order_date;

-- 3. What was the first item from the menu purchased by each customer?
select distinct m.product_name,s.customer_id, s.order_date
from sales s
join menu m on s.product_id = m.product_id
where (s.customer_id, s.order_date) in (        
    select customer_id, min(order_date)
    from sales
    group by customer_id
)
order by s.customer_id; 

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
select * from dannys_diner.menu;
select * from dannys_diner.members;
select * from dannys_diner.sales;

select m.product_name, m.product_id, count(s.product_id) as total_purchases
from dannys_diner.sales s
left join menu m
on m.product_id = s.product_id
group by m.product_id, m.product_name
order by total_purchases DESC
limit 1;

--5. Which item was the most popular for each customer?
select * from dannys_diner.menu;
select * from dannys_diner.members;
select * from dannys_diner.sales;


select s.customer_id, 
      count(s.product_id) as total_purchases, 
      s.product_id, 
      m.product_name 
from sales s 
left join menu m 
on s.product_id = m.product_id
group by  s.customer_id, s.product_id, m.product_name
--order by total_purchases desc;
order by customer_id;

--5. Which item was the most popular for each customer?
select customer_id, product_id, product_name, total_purchases from (
    select s.customer_id, 
           count(s.product_id) as total_purchases, 
           s.product_id, 
           m.product_name,
           row_number() over (partition by s.customer_id order by count(s.product_id) desc) as rn
    from sales s 
    left join menu m 
    on s.product_id = m.product_id
    group by  s.customer_id, s.product_id, m.product_name
) t
where rn = 1
order by customer_id;

create database xyz;
use xyz;
create table xyz.employees(
  id int, 
  emp_name varchar(20), 
  salary int
)

INSERT INTO xyz.employees
(id,emp_name,salary)
values 
(1,'adam', 25000),
(2,'bob', 30000),
(3,'casey', 40000);

create SCHEMA xyz;
set search_path = xyz;

describe xyz.employees;

select * from xyz.employees;