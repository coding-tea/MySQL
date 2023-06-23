#create database
create database all_sql;
use all_sql;

#create tables
create table auteur (
	auteur_id int primary key auto_increment,
    first_name varchar(20),
    last_name varchar(20)
);

create table books (
	isbn varchar(20) primary key,
    title varchar(100),
    auteur_id int,
    foreign key (auteur_id) references auteur(auteur)
);

create table sales (
	id_sale int primary key auto_increment,
    data_sale date default now(),
    isbn varchar(20),
    foreign key (isbn) references books(isbn)
);

#add column to the sales table
alter table sales add price float;

#insert some data
insert into auteur values ('coding', 'tea');
insert into books values ('12125452', 'Ihana', 1);
insert into sales (isbn) values ('12125452');

#procedure auteurs
delimiter $$
drop procedure if exists auteurs;
create procedure auteurs(in id int)
begin 
	select * from auteur where auteur_id = id;
end$$
delimiter ;

#call the procedure
call auteurs(1);

#procedure that tshow books not sold
delimiter $$
drop procedure if exists books_not_sold;
create procedure books_not_sold()
begin 
	select * from books where isbn not in (select isbn from sales);
end$$
delimiter ;

#call books_not_sold procedure
call books_not_sold();

#function that show total price based on book isbn
delimiter $$
drop function if exists total;
create function total(book_isbn varchar)
returns float
reads sql data
begin 
	declare total float;
    set total = (select sum(price) from sales where isbn = book_isbn);
    return total;
end$$
delimiter ;

#call the total function 
select total('12125452');

#trigger that update table auteur after each sales insert
#add a column in the auteur table 
alter table auteur add number_books_on_sales int;

#the trigger 
delimiter $$
create trigger sales_after_insert
after insert 
on sales
for each row
begin
	update auteur 
    set number_books_on_sales = number_books_on_sales + 1 
    where auteur_id = (select auteur_id from books where isbn = new.isbn);
end$$
delimiter ; 