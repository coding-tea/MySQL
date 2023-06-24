use all_sql;

#procedure that use cursor for showing auteur with total revenu
delimiter $$
drop procedure if exists auteur_info;
create procedure auteur_info()
begin
    declare auteurId int;
    declare total float;
    declare cursor curs for select auteur_id from auteur;
    declare break bool default false;
    declare exit handler for not found set break = true;
    open curs;
    while break = false do
        fetch curs into auteurId;
        set total = (
            select sum(price) from sales s, books b, auteur a 
            where a.auteur_id = b.auteur_id 
            and b.isbn = s.isbn
            and a.auteur_id = auteurId
        );
        select concat(auteurId, total);
    end while;
    close curs;
end$$
delimiter ;