create database ExerciseDb2
use ExerciseDb2

create table Student
(SId int primary key,
SName nvarchar(50),
SEmail varchar(50),
SContact nvarchar(50) 
)

insert into Student values(01,'Harshal', 'harshal843@gmail.com','8889559943')
insert into Student values(02,'Harshal2', 'harshal43@gmail.com','6260865512')
insert into Student values(03,'Harshal3', 'harshal3@gmail.com','8290947343')
insert into Student values(04,'Harshal4', 'harshal@gmail.com','8889559963')
select * from Student

create table Fee
(SId int foreign key references Student(SId),
SFee decimal(5,2),
SMonth int,
SYear int,
primary key(SId,SMonth,SYear)
)

create table PayConfirmation
(SId int,Name varchar(50),
Email varchar(50),
Fee int,
PaidOnDate date
)

create trigger feePayConfirmation
on Fee
after insert 
as 
declare @id int
declare @StFees decimal(6,2)
declare @StName varchar(50)
declare @StEmail varchar(50)
select @id = SId from inserted
select @StFees = SFee from inserted
begin 
select @StName = @StName, @StEmail = SEMail from Student where SId = @id
insert into PayConfirmation values(@id, @StName, @StEmail,@StFees, GETDATE())
print 'PayConfirmation table is updated successfully'
end

insert into Fee values(1,45000.00,7, 2023)
insert into Fee values(2,48000.90,8, 2023)
insert into Fee values(3,35000.87,6, 2023)
insert into Fee values(4,25000.99,7, 2023)