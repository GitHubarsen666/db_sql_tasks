ЧАСТИНА 1:

1.Запит:
SELECT film.title, film.length, category.name AS category
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id;

2.Запит:
SELECT film.title, lower(rental.rental_period) AS rental_start_date
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN customer ON rental.customer_id = customer.customer_id
WHERE customer.first_name = 'MARY' AND customer.last_name = 'SMITH';

3.Запит:
SELECT film.title, COUNT(rental.rental_id) AS rental_count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY rental_count DESC
LIMIT 5;

ЧАСТИНА 2:

1.Запит:
insert into city (city,country_id,last_update)
 values ('San Francisco',(select country_id from country where country='United States'),NOW());
insert into address (address,address2,district,city_id,postal_code,phone,last_update)
 values ('123 Main St','','District 1',(select city_id from city where city='San Francisco'),'1234','345-232',NOW());
insert into customer (store_id,first_name,last_name,email,address_id,activebool,create_date,last_update)
 values (1,'ALICE','COOPER','email@mail',(select address_id from address where address='123 Main St' limit 1),true,NOW(),NOW())

2.Запит:
UPDATE address
SET address = '456 Elm St', last_update = NOW()
WHERE address_id = (
    SELECT address_id 
    FROM address 
    WHERE address = '123 Main St' 
      AND city_id = (SELECT city_id FROM city WHERE city = 'San Francisco') 
      AND address_id = (
          SELECT address_id 
          FROM customer 
          WHERE first_name = 'ALICE' AND last_name = 'COOPER'
      )
);

3.Запит:
DELETE FROM customer
WHERE first_name = 'ALICE' AND last_name = 'COOPER';
