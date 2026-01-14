select 
	A.ArtistId,
    A.name artist_name,
    B.Title album_name
from artists as A,albums as B
where A.ArtistId=B.ArtistId and A.Name like 'C%';
-------------------------------------------------------------

--where to inner join
select 
	A.artistId,
    A.name artist_name,
    B.title albums_name,
    C.Name track_name
from artists A
join albums B on A.ArtistId=B.ArtistId
join tracks C on B.AlbumId = C.AlbumId
where A.Name like 'O%';

select 
	count (*) Olodum_song
from artists A
join albums B on A.ArtistId=B.ArtistId
join tracks C on B.AlbumId = C.AlbumId
where A.Name = 'Olodum';
-------------------------------------------------------------

-- cross join (cartesian)
create table ranks
(rank text) ;

create TABLE suits
(suit text);

insert into ranks 
VALUES ('2'),('3'),('4'),('5'),('6'),('7'),('8'),('9'),('10'),
		('J'),('Q'),('K'),('A');
        
insert into suits
values ('Spade'),('Heart'),('Club'),('Diamond');

select * from suits;
select * from ranks;

select * from ranks,suits
order by suit;

select * from ranks cross join suits order by 1;
-------------------------------------------------------------

--self join 
create table employee_2
(id int PRIMARY key ,
name text,
level text,
manager_id int);

insert into employee_2
VALUES (1,'David','CEO',NULL),
(2,'John','SVP',1),
(3,'Marry','VP',2),
(4,'Scott','Manager',3),
(5,'Louise','Senior',4),
(6,'Lisa','Senior',4),
(7,'Joe','Junior',5),
(8,'Anna','Junior',6);

select * from employee_2;

select e1.name staff,
		e1.level staff_level,
        e2.name manager,
        e2.level manager_level,
        e1.name || ' reported to ' || e2.name as comment
from employee_2 as e1,employee_2 as e2
WHERE e1.manager_id=e2.id;
-------------------------------------------------------------

-- intersect and except 
create table book_shop(
id int,
name text,
public_year int);

create table favorite_books(
id int,
author text,
reviews real);

INSERT into book_shop
values (1,'the secret door',2002),
(2,'Avatar',2019),
(3,'my universe,my heart',2025),
(4,'trap of heart',2012),
(5,'the last orchestra',1998);

INSERT into favorite_books
values (1,'J.K',10023),
(2,'James Cameron',197042),
(4,'wasiss',10204);

select * from book_shop;
select * from favorite_books;
--intersect 
select id from book_shop
INTERSECT select id from favorite_books;

--except 
select id from book_shop
EXCEPT SELECT id from favorite_books;
-------------------------------------------------------------

--union 
create table book_shop2(
id int,
name text,
public_year int); 

INSERT into book_shop2
values (4,'trap of heart',2012);
/*
(6,'the secret door',2002),
(7,'Avatar way of water',2022),
(8,'what is this love',2024);
*/
select * from book_shop;
select * from book_shop2;
--union
select * from book_shop
UNION SELECT * from book_shop2;

--union all 
select * from book_shop
union all SELECT * from book_shop2;
-------------------------------------------------------------

--sub quesries 
select * from tracks;

select * from tracks 
order by milliseconds desc limit 1;

select * from tracks where milliseconds=5286953;


select * from tracks
where milliseconds = (select max(milliseconds) from tracks);

select firstname,lastname,country 
from 
(select * from customers
where country = 'USA');