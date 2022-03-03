-- Day 1 SQL QUERY ASSIGNMENT


-- QUESTION 1 - How many actors are there with the last name "Wahlberg"?
select count(last_name)  
from actor
where last_name = 'Wahlberg';
-- There are two actors with the last name Wahlberg 

-- QUESTION 2 - How many payments were made between $3.99 and $5.99?
select count(amount)
from payment
where amount between 3.99 and 5.99;
-- There were 5,563 payments between $3.99 and $5.99.

-- QUESTION 3 - What film does the store have the most of? (search in inventory)
select store_id, film_id, count(film_id)
from inventory
group by store_id, film_id
order by count(film_id) desc;
-- Store 1 has the biggest inventory of film_id 200 - Deciever Betrayed, and Store 2 has the biggest inventory of film_285 - English Bulworth

-- QUESTION 4 - How many customers have the last name 'Williams'?
select count(last_name)
from customer
where last_name = 'Williams';
-- There is only one customer with the last name 'Williams'

-- QUESTION 5 - What store employee (get the id) sold the most rentals?
select staff_id, count(rental_id)
from rental
group by staff_id;
-- staff_id#1 sold the most rentals with 8,040 units compared to staff_id#2's 8,004 units sold

-- QUESTION 6 - How many different district names are there?
select count(distinct district)
from address 
-- There are 378 different district names

-- QUESTION 7 - What film has the most actors in it? (use film_actor table and get film_id)
select film_id, count(actor_id)
from film_actor
group by film_id 
order by count(actor_id) desc;
-- The film 'Lambs Cincinatti', with the film_id of 508, has the most actors in it with a count of 16.

-- QUESTION 8 - From store_id1, how many customers have a last name ending with 'es'? (use customer table)
-- customer_id, store_id, first_name, last_name, email, address_id
select store_id, count(customer_id)
from customer
where store_id = 1 and last_name like '%es'
group by  store_id
order by count(customer_id);
-- There are 13 people from store_id #1 with a last names ending in 'es'.

-- QUESTION 9 - How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 250 for customers with ids between 380 and 430? (use group by and having > 250)
-- categories: payment_id , customer_id, staff_id, rental_id, amount, payment_date
select amount, count (payment_id)
from payment
where customer_id between 380 and 430
group by amount
order by count (payment_id);
-- There are three payment groups with more than 250 rentals and customers with ids between 380 and 430.
-- These three groups are 4.99, 0.99, and 2.99

-- QUESTION 10 - Within the film table, how many rating categories are there? And what rating has the most movies total?
select rating, count(rating)
from film 
group by rating
order by count(rating);
-- There are 5 categories for movie ratings and PG-13 has the most movies in this category.