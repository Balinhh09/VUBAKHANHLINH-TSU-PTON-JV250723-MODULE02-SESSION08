use SalesDB;

delimiter //
create procedure AddNewCustomer(in inFirstName varchar(50),
								   inLastName varchar(50),
								   inEmail varchar(100))
begin
	insert into Customers(CustomerName,Email) values
    (concat(inFirstName,' ',inLastName),inEmail);
end //
delimiter ;

call AddNewCustomer('Phạm','Thị H','H@gmail.com');

select *
from Customers;
