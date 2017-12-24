--Display the first and last names of all actors from the table `actor`. 
USE sakila;

SELECT first_name, last_name
FROM actor;

--Display the first and last name of each actor in a single column in 
--upper case letters. Name the column `Actor Name`. 

SELECT CONCAT(UPPER(first_name), " " , UPPER(last_name))  AS 'Actor Name' 
FROM actor;

--You need to find the ID number, first name, and last name of an actor,
 --of whom you know only the first name, "Joe." What is one query would 
-- you use to obtain this information?

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe'

--Find all actors whose last name contain the letters `GEN`:

SELECT last_name
FROM actor 
WHERE last_name LIKE '%gen%';

--Find all actors whose last names contain the letters `LI`. 
--This time, order the rows by last name and first name, in that order:

SELECT last_name, first_name
FROM actor
WHERE last_name LIKE '%li%' OR '%Li%'
GROUP BY last_name, first_name;

-- Using `IN`, display the `country_id` and `country` columns of the 
--following countries: Afghanistan, Bangladesh, and China:

SELECT * FROM country
WHERE country IN (
'Afghanistan' , 'Bangladesh', 'China');

-- Add a `middle_name` column to the table `actor`. Position it between 
--`first_name` and `last_name`. Hint: you will need to specify the data type.

ALTER TABLE actor
ADD  middle_name CHAR(30);

SELECT first_name, middle_name, last_name
FROM actor;

--You realize that some of these actors have tremendously long last names.
-- Change the data type of the `middle_name` column to `blobs`.

ALTER TABLE actor
MODIFY COLUMN middle_name blob;

ALTER TABLE actor
MODIFY COLUMN middle_name blob;

--Now delete the `middle_name` column.

ALTER TABLE actor
DROP COLUMN middle_name;


--List the last names of actors, as well as how many actors have
-- that last name.
SELECT last_name, COUNT(*) last_name
FROM actor
GROUP BY last_name;



--List last names of actors and the number of actors who have that 
--last name,but only for names that are shared by at least two
 --actors
SELECT last_name, COUNT(*) last_name
FROM actor
GROUP BY last_name 
HAVING COUNT(*) last_name >= 2;
ORDER BY COUNT(last_name) DESC;


 --Oh, no! The actor `HARPO WILLIAMS` was accidentally entered
 -- in the `actor` table as `GROUCHO WILLIAMS`, the name of 
 --Harpo's second cousin's husband's yoga teacher. 
 --Write a query to fix the record.

UPDATE actor 
SET first_name = "HARPO"
WHERE actor_id = 172; 


4d --Change back to 'Groucho'
UPDATE actor 
SET first_name = "GROUCHO"
WHERE actor_id = 172; 

--You cannot locate the schema of the
-- `address` table. Which query would you use 
--to re-create it

DESCRIBE sakila.address; 

--Use `JOIN` to display the first and last names, 
--as well as the address, of each staff member. 
--Use the tables `staff` and `address`:

SELECT first_name, last_name, address
FROM staff LEFT JOIN address
ON staff.address_id = address.address_id;


--Use `JOIN` to display the total amount rung up by each staff
-- member in August of 2005. Use tables `staff` and `payment`. 

SELECT staff.staff_id, staff.first_name, staff.last_name, payment.staff_id, payment.amount, payment.payment_date
FROM staff JOIN payment
ON staff.staff_id = payment.staff_id;

--List each film and the number of actors who are listed for that film.
-- Use tables `film_actor` and `film`. Use inner join.

SELECT film.film_id, film.title, COUNT(film_actor.actor_id), film_actor.film_id
FROM film INNER JOIN film_actor
ON film.film_id = film_actor.film_id;

--How many copies of the film `Hunchback Impossible` exist in the inventory system?

SELECT film.film_id, film.title, COUNT(inventory.film_id)
FROM inventory JOIN film
ON inventory.film_id = film.film_id
WHERE film.title LIKE "HUNCHBACK IMPOSSIBLE";

--Using the tables `payment` and `customer` and the `JOIN` command,
-- list the total paid by each customer. List the customers alphabetically by last name:

SELECT payment.customer_id, customer.first_name, customer.last_name, COUNT(payment.amount) AS "TOTAL AMOUNT PAID"
FROM payment JOIN customer
ON payment.customer_id = customer.customer_id
GROUP BY payment.customer_id
ORDER BY last_name ASC;

--The music of Queen and Kris Kristofferson have seen an unlikely resurgence.
-- As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity.
-- Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English. 

SELECT film.film_id, film.title, language.language_id
FROM film JOIN language
ON film.language_id = language.language_id
WHERE film.title LIKE "K%" OR "Q%";

--Use subqueries to display all actors who appear in the film `Alone Trip`.

SELECT first_name, last_name
FROM actor
WHERE actor_id IN(

SELECT actor_id
FROM film_actor
WHERE film_id IN(

SELECT film_id
FROM film
WHERE title = "ALONE TRIP"
)
);

--You want to run an email marketing campaign in Canada, for which you will need the
-- names and email addresses of all Canadian customers. Use joins to retrieve this information.
SELECT customer_list.name, customer_list.country, customer_list.ID, customer.email, customer.customer_id
FROM customer_list JOIN customer
ON customer_list.ID = customer.customer_id
WHERE country LIKE "CANADA";

--Sales have been lagging among young families, and you wish to target all family movies
-- for a promotion. Identify all movies categorized as famiy films.

SELECT film_category.film_id, category.category_id, film.title, category.name
FROM film_category 
	JOIN category
		ON film_category.category_id = category.category_id
	JOIN film
		ON film.film_id = film_category.film_id
        WHERE category.name  LIKE "Family"; 



--Display the most frequently rented movies in descending order.
film, inventory, rental

SELECT inventory.film_id, film.title, DISTINCT(rental.inventory_id)
FROM inventory
	JOIN rental
		ON inventory.inventory_id = rental.inventory_id
	JOIN film 
		ON inventory.film_id = film.film_id
		ORDER BY DISTINCT(rental.inventory_id) DESC;



--Write a query to display how much business, in dollars, each store brought in.
SELECT *
FROM sales_by_store;


--Write a query to display for each store its store ID, city, and country.


--List the top five genres in gross revenue in descending order.


