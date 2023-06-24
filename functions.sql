use all_sql;

#function tha treturn value of an column
delimiter $$
drop function if exists getAuteurName;
create function getAuteurName(id int)
returns varchar
reads sql data
begin
	declare auteurName varchar(20);
    select first_name into auteurName where auteur_id = id;
end$$
delimiter ;

select getAuteurName(1);


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