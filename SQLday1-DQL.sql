-- comment: "--"
-- Hello SQL World! A comment is written with two dashes
-- today we're looking @ DQL aka select statements!

-- commands are set up into families
-- The hello world of SQL queries: select all from a table
select *  
from actor;
-- select <columns> (* represents columns)
-- from <tablename>; (; means end query)

-- what if I only want first and last name
select first_name, last_name
from actor;

-- the WHERE clause
-- the where clause lets us filter our results by a condition 
select first_name, last_name
from actor
where first_name = 'Nick';

-- LIKE with a WHERE
select first_name, last_name 
from actor
where first_name like 'Nick';

-- wildcards for use with like 
-- _ and %
-- % represents any number of any letter
-- _ represents a single instance of any letter 
select first_name, last_name 
from actor a 
where first_name like 'N__';

select first_name, last_name 
from actor
where first_name like 'J%';

select first_name, last_name 
from actor
where first_name like 'J____%';


-- Comparison operators:
-- = and like shown above
-- greater than >
-- less than <
-- greater or equal >=
-- less than or equal <=
-- not equal <>

-- explore data with SELECT ALL query 
select *
from payment;

select customer_id, amount
from payment 
where amount > 2;

select customer_id, amount
from payment 
where amount > 7;

-- using 'and' to combine conditionals just like python
select customer_id, amount
from payment 
where amount between 2 and 7;

-- OR operator
select customer_id, amount
from payment 
where amount > 2 or amount <7;


-- Order by lets us sort the results of our query
-- what are our most expensive payment?

select customer_id, amount 
from payment
order by amount; -- (desc for descending, default is ascending)

-- order of our clauses matters
-- select <columns>
-- from <table>
-- where <conditional>
-- order by <column>;
-- cheapest payment that wasnt free
select customer_id, amount
from payment
where amount <> 0;
order by amount;

-- SQL Aggregations -> SUM(), AVG(), COUNT(), MIN(), MAX()

-- How much did this company make from 0.99 payments?
-- slow way: select all and count rows 

select *
from payment
where amount = 0.99;
-- 2690 $0.99 - note that my query result did not contain this info, I counted the rows

-- let's use aggregates
-- COUNT (<column) will give us the number of results in the column matching the query
select count(amount)
from payment 
where amount = 0.99;


-- How much did this company make from 0.99 payments?
select sum(amount)
from payment
where amount = 0.99;
-- we made $2663.10 from 0.99 payments 

-- What payment amount made the most money?
-- I want the sum of the amount for each amount separately
-- but U want it in one query 
-- Enter the GROUP BY clause
-- the GROUP BY clause is used in conjunction with aggregates in order to modify the behavior of the aggretgate group rows
-- which payment amount did we have the most transactions of
select amount, count(amount), sum(amount)
from payment
group by amount
order by sum(amount) desc;

select amount, count(amount), sum(amount)
from payment
group by amount
order by count(amount) desc;

select count (payment_id)
from payment
where amount = 0;

-- display sums of amount that different customers are spending
-- when selecting both a non-aggregate column and an aggregate function 
-- the non-aggregate column must appear in a groupby
select customer_id, sum (amount)
from payment
group by customer_id
order by sum(amount) desc;
-- which customer spent the most?
-- customer_id 1 spent $16,794.4

-- MAX() AND MIN() aggregates are very straightforward
-- what's the most expensive single payment?
select max (amount)
from payment;
-- $565.98

-- I can use where clause with max or min()
-- or with any other aggregate
-- whats the most expensive payment under $500?
select max(amount)
from payment
where amount < 500;
-- $305.93

select customer_id, amount, sum(amount)
from payment
group by customer_id, amount
order by customer_id;

select customer_id, amount, sum(amount)
from payment
where customer_id = 8
group by customer_id, amount
order by customer_id;


-- clauses we've talked about so far (in the order they must appear):
-- select <columns> <aggregates>
-- from <table>
-- where <conditional>
-- group by <columns>
-- order by <column>

-- where allows us to modify/filter the results of the select 
-- specifically with our normal columns

-- we have another clause that allows us to similarly filter the results of an aggregate 
-- Having lets us apply a conditional filtering an aggregate 
-- where is to selecting a normal column like having is to an aggregate 
-- a having clause would appear directly after a group by
-- order of clauses if using everything:
-- select <columns> <aggregates>
-- from table 
-- where conditional 
-- group by columns
-- having conditional 
-- order by column

--which customers paid more than $5000?
select customer_id , sum(amount)
from payment
group by customer_id 
having sum(amount) >= 5000
order by sum(amount);
-- only two customers paid more than $5000 -> customer_id 6 and customer_id 1

-- who are those customers?
-- i can take those customer_ids and go find the associated info from the customer table!
select*
from customer
where customer_id = 1 or customer_id = 6;
-- Mary Smith and Jennifer Davis are our two best customers 

-- this afternoon we'll start looking at how we could combine those two queries into a single query


--PM NOTES
-- primary key - attribute of combination of attributes that uniquely identify one and only one 

select customer.customer_id, payment_id, amount first_name, last_name
from customer
join payment
on customer.customer_id = payment.customer_id;

select *
from film_actor





-- do we have any customers without an id or havent made any payments 
select customer.customer_id, payment_id, first_name, last_name
from customer
full join payment
on customer.customer_id = payment.customer_id 
where payment.customer_id is null or payment_id is null;
-- 0 results means fully joined - no customer has made 0 zero payments

select * from payment;