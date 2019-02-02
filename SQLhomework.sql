# 1a
select first_name, last_name from actor;

# 1b
SELECT CONCAT(first_name, ',', last_name) AS Actor_name
FROM  customer;

#2a
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'Joe';

#2b
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%GEN%';

#2c
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%LI%'
order by 2,1 ;

#2d
SELECT c.country_id, c.country FROM country c
WHERE c.country IN ('Afghanistan', 'Bangladesh', 'China');

#3a
ALTER TABLE actor
ADD description BLOB;

#3b
alter table actor drop description;

#4a
select last_name, count(*) as LastNameCount from actor    
group by 1
order by 2 desc;

#4b
select last_name, count(*) as LastNameCount from actor  
group by 1
having count(*) > 1
order by 2 desc;

#4c
update actor set first_name = 'HARPO'
where first_name = 'groucho' and last_name = 'williams' ;

#4d
update actor set first_name = 'GROUCHO'
where first_name = 'HARPO' and last_name = 'WILLIAMS' ;

#5a
#show create table 

#6a
select s.first_name, s.last_name, a.address, a.district, a.postal_code
from staff s join address a on s.address_id = a.address_id;

#6b
select staff.first_name, staff.last_name, sum(payment.amount)
from staff join payment on staff.staff_id = payment.staff_id
group by 1,2;

#6c
select film.title, count(film_actor.actor_id) as 'Number of Actors'
from film inner join film_actor on film.film_id = film_actor.film_id
group by 1 
;

#6d
select film.title, count(*)
from film join inventory on film.film_id = inventory.film_id
where film.title = 'Hunchback Impossible' ;

#6e
select c.first_name, c.last_name, sum(p.amount)
from payment p join customer c on p.customer_id = c.customer_id
group by 1
order by 2 asc ;

#7a
select t.* from (
select film.title, language.name as language
from film join language on film.language_id = language.language_id
where (film.title like 'Q%' OR film.title like 'K%') 
) as t
where language like 'Eng%'
;

#7b
select t.* from (
select actor.first_name, actor.last_name, film.title as Movie_Title
from actor 
join film_actor on film_actor.actor_id = actor.actor_id
join film on film.film_id = film_actor.film_id
where film.film_id = 17
) as t
where t.Movie_Title = 'Alone Trip';

#7c
select c.first_name, c.last_name, c.email, country.country
from customer c
join address a on c.address_id = a.address_id
join city on city.city_id = a.city_id
join country on country.country_id = city.country_id
where country.country_id = 20
group by 1 order by 2 desc ;

#7d
select film.title, film.rating, category.name
from film
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
where category.category_id = 3
group by 1 order by 1 asc ;

#7e
select film.title, count(payment.rental_id) as 'number of rentals'
from film 
join inventory on film.film_id = inventory.film_id
join rental on rental.inventory_id = inventory.inventory_id
join payment on payment.rental_id = rental.rental_id
group by 1
order by 2 desc ;

#7f
select store.store_id, concat('$', format(sum(payment.amount), 2)) as 'Store Revenue'
from store
join staff on store.store_id = staff.store_id
join payment on payment.staff_id = staff.staff_id
group by 1
order by 2 desc ;

#7g
select store.store_id, city.city, country.country
from store
join address on store.address_id = address.address_id
join city on city.city_id = address.city_id
join country on country.country_id = city.country_id
group by 1
order by 1 desc ;

#7h
select category.name as 'Genre', concat('$', format(sum(payment.amount), 2)) as 'Movie Revenue'
from category
join film_category on category.category_id = film_category.category_id
join inventory on film_category.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
join payment on payment.rental_id = rental.rental_id
group by 1
order by 2 desc 
limit 5;

#8a
create or replace view `Genre_Revenue` as 
select category.name as 'Genre', concat('$', format(sum(payment.amount), 2)) as 'Movie Revenue'
from category
join film_category on category.category_id = film_category.category_id
join inventory on film_category.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
join payment on payment.rental_id = rental.rental_id
group by 1
order by 2 desc 
limit 5;

#8b
select * from genre_revenue ;

#8c
drop view genre_revenue ;