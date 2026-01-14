
--1.query total price invoice groupby country 
select billingcountry,
		sum(Total) as Total_price
from invoices
group by billingcountry

--2.count purches of each track 
select T.trackid as track_id,
		T.Name as track_name,
        Sum(I.Quantity) as total_purches        
from tracks T join invoice_items I
on T.TrackId = I.TrackId
group by track_name
order by track_id;

--3.total spend of each customer 
select Cus.CustomerId as customer_id,
	   Cus.FirstName,
       Cus.LastName,
       sum(Inv.Total) as total_spending
from customers Cus join invoices Inv 
on Cus.CustomerId = Inv.CustomerId
group By customer_id


--4.employee dynamic chart
select Emp1.employeeid,
		Emp1.FirstName || ' ' ||  Emp1.LastName as employee_name,
        Emp1.Title,
        Emp2.FirstName || ' ' ||  Emp2.LastName as superior
from employees Emp1,employees Emp2
where Emp1.ReportsTo=Emp2.employeeid

