delimiter //
create procedure DeleteOrderAndSales(in inOrderID int)
begin 
	delete from Sales
    where OrderID = inOrderID;
    
    delete from Orders
    where OrderID = inOrderID;
end //
delimiter ;

call DeleteOrderAndSales(5);