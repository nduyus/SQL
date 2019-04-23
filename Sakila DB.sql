use sakila;

select first_name, last_name
from actor;

select concat(first_name, " ", last_name) as "Actor Name"
from actor;

select actor_id, first_name, last_name
from actor
where first_name="Joe";

select *
from actor
where last_name like "%GEN%";

select actor_id, last_name, first_name, last_update
from actor
where last_name like "%LI%";

select country_id, country
from country
where country in ("Afghanistan", "Bangladesh", "China");

alter table actor add description blob;

alter table actor drop column description;

select last_name, count(*) as "Count"
from actor
group by last_name;

select last_name, count(*) as "Count"
from actor
group by last_name
having Count>=2;

update actor set first_name = "HARPO" where first_name = "GROUCHO" and last_name = "WILLIAMS";

update actor set first_name = "GROUCHO" where first_name = "HARPO" and last_name = "WILLIAMS";

describe sakila.address;

show
create table address;

select s.first_name, s.last_name, a.address
from staff s left join address a on s.address_id = a.address_id;

select s.first_name, s.last_name, sum(p.amount) as Total
from staff s left join payment p on s.staff_id=p.staff_id
where payment_date like "2005-08%"
group by s.first_name, s.last_name;

select f.title, count(fa.actor_id) as "Number of Actors"
from film f inner join film_actor fa on f.film_id=fa.film_id
group by f.title;

select count(film_id) as "Number of Copies"
from inventory
where film_id in
	(select film_id
from film
where title="Hunchback Impossible");

select c.first_name, c.last_name, sum(p.amount) as "Total Payment"
from customer c left join payment p on c.customer_id=p.customer_id
group by c.first_name, c.last_name
order by c.last_name asc;

select title
from film
where title like "K%" or title like "Q%" and language_id in
	(select language_id
	from language
	where name="English");

select first_name, last_name
from actor
where actor_id in
(
	select actor_id
from film_actor
where film_id in
	(select film_id
from film
where title="Alone Trip")
);

select first_name, last_name, email
from customer c inner join address a on c.address_id=a.address_id
	inner join city ct on a.city_id=ct.city_id
	inner join country cntr on ct.country_id=cntr.country_id
where cntr.country="Canada";

select title
from film
where film_id in
(
	select film_id
from film_category
where category_id in
    (
		select category_id
from category
where name="Family"
    )
);

select r.rental_date, f.title
from rental r
	join inventory i on r.inventory_id=i.inventory_id
	join film f on i.film_id=f.film_id
order by r.rental_date desc;

select s.store_id, sum(p.amount) as Revenue
from payment p
	join staff s on p.staff_id=s.staff_id
group by s.store_id;

select s.store_id, c.city, cntr.country
from store s
	join address a on s.address_id=a.address_id
	join city c on a.city_id=c.city_id
	join country cntr on c.country_id=cntr.country_id
group by s.store_id;

select c.name as Genres, sum(p.amount) as Revenue
from payment p
	join rental r on p.rental_id=r.rental_id
	join inventory i on r.inventory_id=i.inventory_id
	join film_category fc on i.film_id=fc.film_id
	join category c on fc.category_id=c.category_id
group by Genres
order by Revenue desc
limit 5;

create view v_top_5_genres
as
select c.name as Genres, sum(p.amount) as Revenue
from payment p
	join rental r on p.rental_id=r.rental_id
	join inventory i on r.inventory_id=i.inventory_id
	join film_category fc on i.film_id=fc.film_id
	join category c on fc.category_id=c.category_id
group by Genres
order by Revenue desc
limit 5;

select * from v_top_5_genres;

drop view v_top_5_genres;