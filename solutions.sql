-- Select data base
use sql_join_multiple;

-- 1. Write a query to display for each store its store ID, city, and country
select 
    store.store_id,
    table_country.country,
    table_city.city,
from store
join table_address
    on store.address_id = table_address.address_id
join table_city
    on table_city.city_id = table_address.city_id
join country
    on table_country.country_id = table_city.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
select 
    store.store_id,
    sum(payment.amount) as "total revenue"
from store
join customer
    on store.store_id = customer.store_id
join payment
    on customer.customer_id = payment.customer_id
group by store.store_id;

-- 3. What is the average running time of films by category?
select 
    category.name,
    avg(film.length)
from film
join film_category
    on film.film_id = film_category.film_id
join category
    on film_category.category_id = category.category_id
group by category.name;

-- 4. Which film categories are longest? (top 5)
select 
    category.name,
    avg(film.length)
from film
join film_category
    on film.film_id = film_category.film_id
join category
    on film_category.category_id = category.category_id
group by category.name
order by avg(film.length) desc
limit 5;

-- 5. Display the most frequently rented movies in descending order.
select 
    film.title,
    count(rental.rental_id) as "times rented"
from film
join inventory
    on film.film_id = inventory.film_id
join rental
    on inventory.inventory_id = rental.inventory_id
group by film.title
order by count(rental.rental_id) desc
limit 50;

-- 6. List the top five genres in gross revenue in descending order.
select 
    category.name,
    sum(payment.amount) as "gross revenues"
from category
join film_category
    on category.category_id = film_category.category_id
join inventory
    on film_category.film_id = inventory.film_id
join rental
    on inventory.inventory_id = rental.inventory_id
join payment
    on rental.rental_id = payment.rental_id
group by category.name
order by sum(payment.amount) desc
limit 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
select 
    case when exists(
        select 1
        from film
        join inventory
            on film.film_id = inventory.film_id
        where inventory.store_id = 1 and film.title = 'Academy Dinosaur')
    then 'Yes'
    else 'No'
    end as is_available;

