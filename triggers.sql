

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