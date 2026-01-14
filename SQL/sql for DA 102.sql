select * from customers
where firstname = 'Leonie';

--AND condition
select * from customers
where lower(country) = 'usa' and lower(state) = 'ca';

--OR condition
select * from customers
where lower(country) = 'usa' OR lower(state) = 'ca';

-- NOT condition 
select * from customers
where  not (country = 'USA' OR country = 'Canda');

-- IN operation 
SELECT firstname,lastname,country,city from customers
where country in ('Brazil','USA','Canada');

SELECT firstname,lastname,country,city from customers
where country not in ('Brazil','USA','Canada');

--between operation
select customerid,firstname,lastname,country from customers
where customerid BETWEEN 5 and 10;
--where customerid>=5 and <=10;

select firstname,lastname,country from invoices
where invoicedate between '2009-01-01 00:00:00' and '2009-01-31 20:00:00';

--null filter 
select * from customers
where company is NULL;

--pattern matching 
select firstname,lastname,country,email from customers
where email like '%@gmail.com';

select firstname,lastname,country,email from customers
where email not like '%@gmail.com';

select firstname,lastname,country,phone from customers
where phone  like '%99%';

select firstname,lastname,
	country,phone 
from customers
where firstname  like '__ra';
------------------------------------------------------------------

--missing value handling
select company,
		COALESCE(company,'End customer') as 'company clean'
from customers;

select company,
		COALESCE(company,'End customer') as 'company clean',
        case when company is null then 'End customer'
        else 'Corporate'
        end as 'Company clean2'
from customers;
------------------------------------------------------------------

--join data with where clause 
select artists.ArtistId,
	artists.name as 'artist name' ,
    albums.Title as 'album name'
from artists ,albums
where artists.ArtistId = albums.ArtistId;

select artists.ArtistId,
	artists.name as 'artist name' ,
    albums.Title as 'album name'
from artists 
join albums on  artists.ArtistId = albums.ArtistId;

select artists.ArtistId,
		artists.Name as 'artist name',
		albums.Title as 'albums name',
        tracks.Name as 'song name'
from artists,tracks,albums
where artists.ArtistId = albums.ArtistId and albums.AlbumId=tracks.AlbumId
Sand artists.ArtistId in (8,20,100);
------------------------------------------------------------------

-- aggregate function 

select round(AVG(milliseconds),2) as avg_mil,
	   sum(milliseconds) sum_mil,
       min(milliseconds) min_mil,
       max(milliseconds) max_mil,
       count (milliseconds) count_mil
from tracks;

--count distinct 
SELECT count (DISTINCT country),count(*) from customers;

--group by 
select count (*) as count_country,country from customers
group by country;

--count song devide by genre 
select count(tracks.Name) as song_count,genres.GenreId,genres.Name
from genres,tracks
where tracks.GenreId = genres.GenreId
group by genres.GenreId;

select genres.Name,COunt (*) as song_count 
from genres,tracks
where genres.GenreId=tracks.GenreId
group by genres.Name;

--Having (filter group used with group by use after group by)
select count(tracks.Name) as song_count,genres.GenreId,genres.Name
from genres,tracks
where tracks.GenreId = genres.GenreId
group by genres.GenreId
having count (*)>=100;

-- order by
-- aescending order
select genres.Name,count (*) from genres,tracks
where genres.GenreId = tracks.GenreId
group by genres.Name
ORDER by COUNT (*);

-- descending order 
select genres.Name,count (*) from genres,tracks
where genres.GenreId = tracks.GenreId
group by genres.Name
ORDER by COUNT (*) desc
limit 5;

select genres.name ,count (*)
from genres join tracks
on genres.GenreId = tracks.GenreId
group by genres.Name
ORDER by COUNT (*) desc
limit 5;
