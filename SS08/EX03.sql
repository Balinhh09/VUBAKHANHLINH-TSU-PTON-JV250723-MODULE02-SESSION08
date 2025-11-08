delimiter //
create procedure UpdateOrderTotalAmount(in inOrderID int,
										   inNewTotalAmount decimal(10,2))
begin
	update Orders
    set TotalAmount = inNewTotalAmount
    where OrderID = inOrderID;
end //
delimiter ;

call UpdateOrderTotalAmount(3,280.00);
