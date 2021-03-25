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


--5
--6
