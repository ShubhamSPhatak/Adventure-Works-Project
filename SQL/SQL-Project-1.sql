create database sql_project;
use sql_project;
create table salesperson(
snum int unsigned,
sname varchar(40),
city varchar(40),
comm decimal(3,2));
insert into salesperson values
(1001,'Peel','London',0.12),
(1002,'Serres','San Jose',0.13),
(1003,'Axelrod','New York',0.10),
(1004,'Motika','London',0.11),
(1007,'Rafin','Barcelona',0.15);

select * from salesperson;

create table cust(
cnum int unsigned,
cname varchar(40),
city varchar(40),
rating int unsigned,
snum int unsigned);
insert into cust values
(2001,'Hoffman','London',100,1001),
(2002,'Giovanne','Rome',200,1003),
(2003,'Liu','San Jose',300,1002),
(2004,'Grass','Berlin',100,1002),
(2006,'Clemens','London',300,1007),
(2007,'Pereia','Rome',100,1004),
(2008,'James','London',200,1007);

select * from cust;

create table orders_table(
onum int unsigned,
amt decimal(6,2),
odate DATE,
cnum int unsigned,
snum int unsigned);
insert into orders_table values
(3001,18.69,'1994-10-03',2008,1007),
(3002,1900.10,'1994-10-03',2007,1004),
(3003,767.19,'1994-10-03',2001,1001),
(3005,5160.45,'1994-10-03',2003,1002),
(3006,1098.16,'1994-10-04',2008,1007),
(3007,757.75,'1994-10-05',2004,1002),
(3008,4723.00,'1994-10-05',2006,1001),
(3009,1713.23,'1994-10-04',2002,1003),
(3010,1309.95,'1994-10-06',2004,1002),
(3011,9891.88,'1994-10-06',2006,1001);

select * from orders_table;

-- QUSETION 4
select salesperson.sname AS "SalesPerson",
cust.cname AS "CustomerName",cust.city AS "City"
from salesperson,cust
WHERE salesperson.city=cust.city
order by city;

-- QUESTION 5
select salesperson.sname AS "SalesPerson", cust.cname AS "CustomerName"
from salesperson,cust
WHERE salesperson.snum=cust.snum;

-- QUSETION 6
select orders_table.onum AS "OrderNumber",cust.cname AS "CustomerName",salesperson.sname AS "Salesperson"
from orders_table,cust,salesperson 
WHERE cust.city<>salesperson.city
AND orders_table.cnum=cust.cnum
AND orders_table.snum=salesperson.snum;

-- QUESTION 7
select orders_table.onum AS "OrderNumber",cust.cname AS "CustomerName"
from orders_table,cust
WHERE orders_table.cnum=cust.cnum;

-- QUESTION 8
select m.cname,n.cname,m.rating
from cust m, cust n
where m.rating=n.rating
AND m.cname<n.cname;
select * from cust order by rating;

-- QUSETION 9
Select c.cname AS "CustomerName",c.snum,s.sname
from cust c,salesperson s
where s.snum IN 
 (select snum 
  from cust
  group by snum
  having count(snum) >1);    
                
-- QUESTION 10
SELECT m.sname,n.sname,m.city
FROM salesperson m,salesperson n
WHERE m.city=n.city
  AND m.sname<n.sname;

-- QUESTION 11
SELECT * FROM orders_table
WHERE snum =
    (SELECT DISTINCT snum
     FROM orders_table 
     WHERE cnum =2008);

-- QUESTION 12
SELECT * FROM orders_table
WHERE amt>
    (SELECT  AVG(amt) 
     FROM orders_table
     WHERE odate ='1994-10-04');
          
-- QUESTION 13
SELECT * FROM orders_table
WHERE snum IN
    (SELECT snum 
     FROM salesperson
     WHERE city='London'); 
     
-- QUESTION 14
Select * from cust 
where cnum >
      ( select snum+1000
        from salesperson
        where sname ='Serres');    
        
-- QUESTION 15
Select count(cnum) AS "No Of Customers"
from cust
where rating > 
	 ( select avg(rating)
	   from cust
	   where cust.city ='Berlin');
       
-- QUESTION 16
SELECT sname AS "SalesPerson Name",cname AS "Customer Name"
FROM salesperson
JOIN cust USING (snum);    
