use sakila;
select * from actor;

#1a -------------------------------
select first_name , last_name 
from actor;

#1b -------------------------------
select Concat(first_name, ' ',last_name) as 'Actor Name' 
from actor;

#2a -------------------------------
select * from actor 
where first_name = "JOE";

#2b -------------------------------
select * from actor 
where last_name LIKE "%GEN%";

#2c -------------------------------
select last_name, first_name 
from actor 
where last_name LIKE "%LI%";

#2d -------------------------------
select country_id, country 
from country 
where country IN ('Afghanistan', 'Bangladesh', 'China');

#3a -------------------------------
alter table actor
add column description BLOB(225);

#3b -------------------------------
alter table actor drop column description;
select * from actor;

#4a -------------------------------
select distinct last_name, count(first_name) 
from actor
group by last_name;

#4b -------------------------------
select distinct last_name, count(first_name) 
from actor
group by last_name
having count(first_name)>1;

#4c -------------------------------
select * from actor
where first_name = "Groucho";
update actor
set first_name = "Harpo"
where actor_id = 172;

#4d -------------------------------
update actor set first_name = "Groucho" where first_name = "Harpo";

#5a -------------------------------
describe sakila.address;

#6a -------------------------------
select * from address;
select * from staff;
select s.first_name, s.last_name, a.address
from staff s left join address a on s.address_id = a.address_id;

#6b -------------------------------
# select s.first_name, s.last_name, p.amount, p.payment_date
# from staff s left join payment p on p.staff_id = s.staff_id
# where p.payment_date like "2005-08-%";
select s.first_name, s.last_name, sum(p.amount)
from staff s left join payment p on p.staff_id = s.staff_id
where p.payment_date like "2005-08-%"
group by last_name;

#6c -------------------------------
# select * from film_actor;
# select* from film;
select f.title, count(fa.actor_id) as actor_count
from film f inner join film_actor fa on f.film_id = fa.film_id
group by f.title;

#6d -------------------------------
select f.title, count(i.inventory_id) as copy_count
from inventory i inner join film f on f.film_id = i.film_id
where title = "Hunchback Impossible";

#6e -------------------------------
select c.last_name, c.first_name, sum(p.amount) as total_amount_paid
from customer c inner join payment p on c.customer_id = p.customer_id
group by c.last_name;

#7a -------------------------------
select f.title, l.name as "language"
from film f left join language l on f.language_id = l.language_id
where l.name = "English" and f.title like "K%" or f.title like "Q%";

#7b -------------------------------
select first_name, last_name
from actor
where actor_id 
	in (select actor_id from film_actor where film_id
		in (select film_id from film where title = "alone trip"));

#7c -------------------------------
select* from country;
select c.first_name, c.last_name, c.email, c.address_id, a.city_id, co.country
from customer c 
inner join address a 
	on c.address_id = a.address_id
inner join city ci
	on a.city_id = ci.city_id
inner join country co
	on ci.country_id = co.country_id
where country = "Canada";

#7d -------------------------------
select f.title, cat.name as Genre
from film f 
left join film_category fc 
	on f.film_id = fc.film_id
left join category cat
	on fc.category_id = cat.category_id
where cat.name = "Family";

#7e -------------------------------
select * from inventory;
select r.inventory_id, count(r.rental_date), f.title
from inventory i
left join film f 
	on f.film_id = i.film_id
left join rental r 
	on r.inventory_id = i.inventory_id
group by f.title
order by count(r.rental_date) desc;

#7f -------------------------------
select * from store;
select s.store_id, sum(p.amount)
from payment p
join staff s on p.staff_id = s.staff_id
group by store_id;

#7g -------------------------------
select store_id, city, country
from store s
left join address a on s.address_id = a.address_id
left join city c on a.city_id = c.city_id
left join country on c.country_id = country.country_id;

#7h -------------------------------
select c.name as Genre, SUM(p.amount) as Gross_Revenue
from category c
join film_category fc on c.category_id=fc.category_id
join inventory i on fc.film_id=i.film_id
join rental r on i.inventory_id=r.inventory_id
join payment p on r.rental_id=p.rental_id
group by c.name 
order by Gross_Revenue desc
limit 5;

#8a -------------------------------
create view TOP_FIVE_VIEW as
select c.name as Genre, SUM(p.amount) as Gross_Revenue
from category c
join film_category fc on c.category_id=fc.category_id
join inventory i on fc.film_id=i.film_id
join rental r on i.inventory_id=r.inventory_id
join payment p on r.rental_id=p.rental_id
group by c.name 
order by Gross_Revenue desc
limit 5;
select * from TOP_FIVE_VIEW;

#8b -------------------------------
select * from TOP_FIVE_VIEW;

#8c -------------------------------
drop view TOP_FIVE_VIEW;