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




