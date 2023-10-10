-- create database exercise_01

select * from Customer
select * from Orders
select * from Items
select * from OrderDetails

create table Customer
(
	c_id int primary key not null identity,
	c_name nvarchar(50),
	c_email nvarchar(100),
	c_address nvarchar(100)
)

create table Book
(
	c_id int foreign key references Customer(c_id),
	Book_id int primary key not null,
	b_isbn int,
	Book_Title nvarchar(100),
	Book_Author nvarchar(100),
	Book_Genre nvarchar(100),
	Book_Price decimal(10,2)
)

create table Ebook
(
	Ebook_id int primary key not null,
	Ebook_isbn int,
	Ebook_Title nvarchar(100),
	Ebook_Author nvarchar(100),
	Ebook_Genre nvarchar(100),
	Ebook_Price decimal(10,2),
	c_id int foreign key references Cart(c_id),
	o_id int foreign key references Orders(o_id)
)

create table AudioBook
(
	c_id int foreign key references Customer(c_id),
	Abook_isbn int,
	Abook_id int primary key not null,
	Abook_Title nvarchar(100),
	Abook_Author nvarchar(100),
	Abook_Narrator nvarchar(50),
	Abook_Genre nvarchar(100),
	Abook_Price decimal(10,2),
	Cart_id int foreign key references Cart(c_id),
	o_id int foreign key references Orders(o_id)
)

create table Cart
(
	cart_id int primary key not null references Customer(c_id),
	cart_time date
)

---alter table Cart
---	add cart_id int primary key not null references Customer(c_id)



create table Orders
(
	o_id int primary key not null,
	o_date date,
	o_totalAm decimal(10, 2),
	o_shipAdd nvarchar(100),
	c_id int foreign key references Customer(c_id)
)


create table Review
(
	Rev_id int primary key not null,
	Rev_Rating int,
	Rev_Comment nvarchar(100),
	Rev_Date date,
	c_id int foreign key references Customer(c_id),
	item_id int foreign key references items(item_id)
	--Book_id int foreign key references Book(Book_id),
	--Ebook_id int foreign key references Ebook(Ebook_id)
)


---------------------------------------------------


select * from Items

create table Items
(
	item_id int primary key not null,
	item_isbn int,
	item_title nvarchar(100),
	item_author nvarchar(50),
	item_genre nvarchar(50),
	item_price decimal (10,2),
	item_type nvarchar(50)
	
)

create table OrderDetails
(
	o_id int references Orders(o_id) on DELETE CASCADE,
	item_id int references Items(item_id) on DELETE CASCADE,
	od_qty int,
	primary key (o_id, item_id)
)

update Items
set item_type = 'Book'
where item_type = 1

insert into Items
values(1, 1001, 'Lim Kyle','Python', 'Book', 'Education' ,500.00)
insert into Items
values(2, 1002, 'Buaya Crocs','DATADMS', 'AudioBook', 'Math', 100.00)
insert into Items
values(3, 1003, 'Andon ALcar','MySql', 'Ebook', 'Programming', 1100.00)
insert into Items
values(4, 1004, 'Genabio Jeyms','AppsDev2', 'Book', 'Web Design', 1500.00)
insert into Items
values(5, 1005, 'Dorado Vin Disiel','WebDev2', 'Book', 'Web Design 2', 800.00)
insert into Items
values(6, 1006, 'Androde John','Php', 'Ebook', 'DATABASE', 600.00)
insert into Items
values(7, 1007, 'Simon Riley','HCI', 'Audiobook', 'SATS', 2600.00)


select c.c_name as NAME, o.o_id as [DATE], o.o_totalAm as TOTAL, o.o_shipAdd as [ADDRESS]
from Customer c
left outer join Orders o on c.c_id = o.c_id

select o.o_id,
c.c_name,
i.item_title,
od.od_qty,
i.item_price,
od.od_qty * i.item_price as o_totalAm from OrderDetails od
inner join Orders o on o.o_id = od.o_id
inner join Items i on i.item_id = od.o_id
right outer join Customer c on c.c_id = o.o_id

----------------------------------------------------------------
----------------------------------------------------------------

select r.Rev_Rating, r.Rev_Comment, i.item_title, c.c_name from Review r
inner join Items i on i.item_id = r.item_id
inner join OrderDetails od on od.item_id = i.item_id
inner join Orders o on o.o_id = od.o_id
inner join Customer c on c.c_id = o.c_id

----------------------------------------------------------------
----------------------------------------------------------------

-- c_email

select 
c.c_name as [Customer Name],
c.c_email as [Customer Email],
ct.cart_id as [Cart ID],
o.o_id as [Order ID],
o.o_date as [Order Date],
o.o_shipAdd as [Order Address],
o.o_totalAm as [Order Total Amount],
ct.cart_time as [Cart Date]
from Customer c, Cart ct, Orders o



select * from Book b, AudioBook a, Ebook e
order by b.Book_Price, a.AudioBook, e.Ebook desc

select * from Book c
where c.c_name = 'J'

select * from Customer c
where c.c_address = 'Cebu City'

insert into Customer
(c_name, c_email, c_address)
values('Gian Carlo Cataraja', 'gccataraja@uc.edu.ph', 'Labangon, Cebu City')

insert into Customer
(c_name, c_email, c_address)
values('Jean Amora', null, 'Marigondon, Lapu-lapu City')

select * from Customer c
where c.c_email is null

--DELETE FROM Customer WHERE c_name = 'Jean Amora'; 

SELECT * FROM Customer WHERE c_name NOT LIKE 'J%';

select * from Customer c
where c.c_id < 5
order by c.c_id desc

select * from Book b, AudioBook a, Ebook e 
order by b.book_Price, a.AudioBook, e.Ebook desc

select * from AudioBook b
where b.book_Price >= 300

select * from Book b
where b.book_Price >= 300

select * from Book b
order by b.Book_Price desc

insert into Books
values(1,12345,'DBMS','John Doe','Education',850.00,1)

insert into Books
values(2,12346,'Data Structures II','Elmer Ty','Education',550.00,1,3)

insert into Customer
(c_name, c_address)
values('Karl Anthonies', 'Cebu City')

-------------------------------------------------------------------------

select count (c_address) as [Number of Customer], c_address
from Customer
Group by c_address
having count (c_address)

select sum (Book_Price)
from Book

select c.c_name, b.Book_Title, o.o_id
from Customer c
inner join Book b on c.c_id = b.c_id
inner join Orders o on b.o_id = o.o_id

select c.c_name, b.Book_Title
from Customer c
inner join Book b on c.c_id = b.c_id

select * from Customer c
left outer join Book b on c.c_id = b.o_id
---where b.Book_id is not null

update Customer
set c_email = 'Jeanamora@gmail.com'
where c_id = 7




