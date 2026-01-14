select firstname,
		lastname,
        country,
        city,
        firstname || ' ' || lastname as fullname
from customers
limit 10;


select name,
		round(milliseconds/60000.0,2) as minute,
        round(bytes/(1024*1024.0),2) as mb
from tracks;

select company,
	case
        when company is not NULL then 'Corporate'
        else 'End customer'
        end as segment
from customers;

select country,
	case
        when country in ('Canada','USA') then 'America'
        when country in ('Belgium','France','Italy') then 'Europe'
        else 'Other'
        end as region
from customers;
 --cast(strftime('%Y',invoicedate) as int) as year
--work with date
select invoicedate,
	cast(strftime('%Y',invoicedate) as int) as year,
    strftime('%m',invoicedate) as month,
    strftime('%d',invoicedate) as day,
    strftime('%Y-%m',invoicedate) as Year_month
from invoices
where year = 2010;
--where year ='2010';

--Join
select * from artists
join albums on artists.ArtistId=albums.ArtistId
where artists.ArtistId=50;

select A.ArtistId,A.Name,B.ArtistId
from artists as A 
join albums as B
on A.ArtistId = B.ArtistId;

-- left join 
select  A.ArtistId,A.Name,B.ArtistId
from artists as A 
left join albums as B
on A.ArtistId = B.ArtistId;

-- right join 
select  A.ArtistId,A.Name,B.ArtistId
from artists as A 
right join albums as B
on A.ArtistId = B.ArtistId;


-- inner join 
select  A.ArtistId,A.Name,B.ArtistId
from artists as A 
INNER join albums as B
on A.ArtistId = B.ArtistId;

--join multiple albums
select A.ArtistId ,
		A.Name as artist_name,
        B.Title as album_name ,
        C.Name as track_name,
        C.Composer
from artists as A
join albums as B
on A.ArtistId=B.ArtistId
join tracks as C
on B.AlbumId = C.AlbumId;

--random
select name,Random() from tracks
order by random() DESC
limit 10;

select name from tracks
order by random() DESC
limit 10;

