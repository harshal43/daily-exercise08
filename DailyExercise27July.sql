create database ExerciseDb1
use ExerciseDb1

create table products
(Pid int primary key identity(1000,1),
PName nvarchar(50) not null,
Pprice int,
PTax as Pprice *0.1 persisted,
PCompany nvarchar(50) check
(PCompany in('Samsung','Apple','Redmi','HTC','RealMe')),
PQty int check(PQty>=1) default 1
)

insert into products values
('s23',53000,'Samsung',3),
('s22',23000,'Samsung',6),
('s22 fe',28000,'Samsung',2),
('Iphone 13',63000,'Apple',7),
('Iphone 14',153000,'Apple',3),
('Note 8',13000,'Redmi',13),
('Note 9',17000,'Redmi',15),
('htc 1',24000,'HTC',9),
('htc 2',23000,'HTC',1),
('RealMe 1',43000,'RealMe',4)

create proc usp_display
with encryption
as 
begin
select p.PId, p.PName, p.PTax as 'Price with Tax', p.PCompany, p.PQty *(p.PPrice + p.PTax) as 'Total Price' from Products p
end
exec usp_display

create proc usp_totalTax 
@Cname varchar(50),
@tax int output
with encryption
as 
begin
select @tax = sum(p.PTax) from Products p where p.PCompany = @Cname
end

declare @tTax int
exec usp_totalTax 'Samsung', @tTax out
print @tTax