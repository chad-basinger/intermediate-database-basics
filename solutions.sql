--1.
select * from invoice i
JOIN invoice_line il ON i.invoice_id = il.invoice_id
where unit_price > .99

--2.
select invoice_date, first_name, last_name, total from invoice i
JOIN customer c on c.customer_id = i.customer_id

--3.
select c.first_name, c.last_name, e.first_name AS "sup ref first name", e.last_name as "sup ref last name" from customer c
JOIN employee e on c.support_rep_id = e.employee_id


--4.
select al.title, art.name from album al
JOIN artist art on art.artist_id = al.artist_id


--5.
select pt.track_id from playlist_track pt
JOIN playlist p on p.playlist_id = pt.playlist_id
WHERE p.name = 'Music'

--6.
SELECT t.name
FROM track t
JOIN playlist_track pt ON pt.track_id = t.track_id
WHERE pt.playlist_id = 5;

--7.
select t.name, p.name from track t
JOIN playlist_track pt on t.track_id = pt.track_id
JOIN playlist p on p.playlist_id = pt.playlist_id

--8.

select t.name, a.title from track t
JOIN album a on t.album_id = a.album_id
JOIN genre g on g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk'


--BLACK DIAMOND
select t.name, g.name, al.title, art.name from track t
JOIN genre g on t.genre_id = g.genre_id
JOIN album al on al.album_id = t.album_id
JOIN artist art on art.artist_id = al.artist_id
JOIN playlist_track pt on pt.track_id = t.track_id
JOIN playlist p on p.playlist_id = pt.playlist_id
WHERE p.name = 'Music'




--PRACTICE NESTED QUERIES
--1
select * from invoice
where invoice_id IN(select invoice_id from invoice_line where unit_price > .99)

--2
select * from playlist_track
 where playlist_id IN(select playlist_id from playlist where name ='Music')

--3
select track.name from track
where track_id in (select track_id from playlist_track where playlist_id = 5)

--4
select * from track 
where genre_id in(select genre_id from genre where name = 'Comedy')

--5
select * from track 
where album_id in(select album_id from album where name = 'Fireball') 


--6
select * from track
where album_id 
in(select album_id from album where artist_id in
   (select artist_id from artist where name = 'Queen')
   )



--UPDATING ROWS
--1
update customer
set fax = null
where fax IS NOT NULL

--2
update customer
set company = 'Self'
where company is null


--3
update customer
set last_name = 'Thompson'
where first_name = 'Julia' AND last_name = 'Barnett'


--4
update customer 
set support_rep_id = 4
where email = 'luisrojas@yahoo.cl'

--5
update track
set composer = 'The darkness around us'
where genre_id = 3 AND composer IS NULL



-- GROUP BY
--1
select g.name, COUNT(*) from track
JOIN genre g on g.genre_id = track.genre_id
GROUP BY track.genre_id, g.name

--2
select g.name, COUNT(*) from track
JOIN genre g on g.genre_id = track.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY track.genre_id, g.name


--3
select art.name, count(*) from artist art
JOIN album al on al.artist_id = art.artist_id
GROUP BY art.name


--USE DISTINCT
--1
select distinct composer from track

--2
select distinct billing_postal_code from invoice

--3
select distinct company from customer



--DELETE ROWS

--1
--N/A

--2
DELETE FROM practice_delete
where type = 'bronze';

--3
DELETE FROM practice_delete
where type = 'silver';

--4
DELETE FROM practice_delete
where value = 150;



--eCOMMERCE simulation NO HINTS
create table users (
  userid serial primary key,
  name varchar(255),
  email varchar(255)
  )
  
 create table products(
   product_id serial primary key,
   name varchar(255),
   price money
   )
   
 create table orders (
   order_id serial primary key,
   product_id integer references products(product_id),
   quantity integer
   )
   
 insert into users (name, email)
 values
 ('chad', 'chad@mail.com'),
 ('Ben', 'Ben@mail.com'),
 ('marco', 'marco@mail.com'),
 ('Polo', 'Polo@mail.com')
 
 select * from users
 
 insert into products (name, price)
 values
 ('Bag of potatoes', 2.99),
 ('Ribeye Steak', 8.99),
 ('Salmon', 6.99),
 ('Hot Dogs', 4.99)
 
 insert into orders (product_id, quantity)
 values
 (1, 3),
  (1, 2),
  (2, 8),
  (3, 1),
  (4, 5)
  
  select * from products
  where product_id in(select product_id from orders where order_id = 1)
  
  select * from orders
  
  select SUM(p.price * o.quantity) from orders o
  JOIN products p on p.product_id = o.product_id
  WHERE order_id = 3;
  
  
  alter table orders
  add userid integer references users(userid)
  
  select * from orders
  
  update orders
  set userid = 2
  where order_id = 5;
  
  select * from orders
  where userid = 4;
  
  select u.name, count(*) from orders o
  JOIN users u on u.userid = o.userid
  GROUP BY u.name
  


  --BLACK DIAMOND
  select u.name, SUM(p.price * o.quantity) from orders o
  JOIN products p on p.product_id = o.product_id
  JOIN users u on u.userid = o.userid
  GROUP BY u.name



