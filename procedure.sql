use all_sql;

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
