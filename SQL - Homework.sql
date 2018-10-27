#1a.
USE sakila;
SELECT first_name, last_name
FROM actor;

#1b.
SELECT CONCAT(first_name, ' ', last_name) AS 'Actor Name'
FROM actor;

#2a.
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

#2b.
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%GEN%';

#2c.
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

#2d.
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

#3a.
ALTER TABLE actor
ADD COLUMN description blob AFTER last_name;
SELECT * FROM actor;

#3b.
ALTER TABLE actor
DROP COLUMN description;
SELECT * FROM actor;

#4a.
SELECT last_name, COUNT(last_name) AS last_name_frequency
FROM actor
GROUP BY last_name
HAVING last_name_frequency >= 1;

#4b.
SELECT last_name, COUNT(last_name) AS last_name_frequency
FROM actor
GROUP BY last_name
HAVING last_name_frequency >= 2;

#4c.
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO'
AND last_name = 'WILLIAMS';
SELECT * FROM actor
WHERE first_name = 'GROUCHO';

#4d.
USE sakila;
UPDATE actor
SET first_name = CASE WHEN first_name = 'HARPO' THEN 'GROUCHO' ELSE 'TACO' END
WHERE actor_id = 172;
SELECT first_name FROM actor;

#5a.
SHOW CREATE TABLE address;

#6a.
SELECT s.first_name, s.last_name, a.address
FROM staff s
INNER JOIN address a ON (s.address_id = a.address_id);

#6b.
SELECT s.first_name, s.last_name, SUM(p.amount)
FROM staff s
INNER JOIN payment p ON (p.staff_id = s.staff_id)
WHERE MONTH(p.payment_date) = 08 AND YEAR(p.payment_date) = 2005
GROUP BY s.staff_id;

#6c.
SELECT f.title, COUNT(fa.actor_id) AS 'actors'
FROM film_actor fa
INNER JOIN film f ON (f.film_id = fa.film_id)
GROUP BY f.title
ORDER BY actors desc;

#6d.
SELECT title, COUNT(inventory_id) AS 'copies'
FROM film
INNER JOIN inventory USING (film_id)
WHERE title = 'Hunchback Impossible'
GROUP BY title;

#6e.
SELECT c.first_name, c.last_name, SUM(p.amount) AS 'payment_total'
FROM payment as p
INNER JOIN customer as c ON (p.customer_id = c.customer_id)
GROUP BY c.customer_id
ORDER BY c.last_name;

#7a.
SELECT title
FROM film
WHERE title LIKE '%K%'OR '%Q%'
AND language_id IN 
	(
    SELECT language_id
    FROM language
    WHERE name = 'ENGLISH'
    );

#7b.
SELECT first_name, last_name 
FROM actor
WHERE actor_id IN
	(
    SELECT actor_id
    FROM film_actor
    WHERE film_id = 
		(
        SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
        )
	);

#7c.
SELECT first_name, last_name, email, country
FROM customer cus
INNER JOIN address a
ON (cus.address_id = a.address_id)
INNER JOIN city cit
ON (a.city_id = cit.city_id)
INNER JOIN country ctr
ON (cit.country_id = ctr.country_id)
WHERE ctr.country = 'canada';

#7d.
SELECT title from film f
JOIN film_category fc on (f.film_id = fc.film_id)
JOIN category c on (fc.category_id = c.category_id);

#7e.
SELECT title, COUNT(f.film_id) AS 'Rented_Movies'
FROM  film f
JOIN inventory i ON (f.film_id = i.film_id)
JOIN rental r ON (i.inventory_id = r.inventory_id)
GROUP BY title ORDER BY Rented_Movies desc;

#7f.
SELECT s.store_id, SUM(p.amount) AS 'total_businesss'
FROM payment p
JOIN staff s ON (p.staff_id = s.staff_id)
GROUP BY store_id;

#7g.
SELECT store_id, city, country FROM store s
JOIN address a ON (s.address_id = a.address_id)
JOIN city c ON (a.city_id = c.city_id)
JOIN country cntry ON (c.country_id = cntry.country_id);

#7h
SELECT c.name AS 'Top Five', SUM(p.amount) AS 'Gross' 
FROM category c
JOIN film_category fc ON (c.category_id = fc.category_id)
JOIN inventory i ON (fc.film_id = i.film_id)
JOIN rental r ON (i.inventory_id = r.inventory_id)
JOIN payment p ON (r.rental_id = p.rental_id)
GROUP BY c.name ORDER BY Gross LIMIT 5;

#8a.
SELECT c.name AS 'Top Five', SUM(p.amount) AS 'Gross' 
FROM category c
JOIN film_category fc ON (c.category_id = fc.category_id)
JOIN inventory i ON (fc.film_id = i.film_id)
JOIN rental r ON (i.inventory_id = r.inventory_id)
JOIN payment p ON (r.rental_id = p.rental_id)
GROUP BY c.name ORDER BY Gross LIMIT 5;

#8b.
SELECT * FROM TopFive;

#8c.
DROP VIEW TopFive;
