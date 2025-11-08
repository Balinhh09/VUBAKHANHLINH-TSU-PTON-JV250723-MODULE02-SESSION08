use SalesDB;

delimiter //
create procedure GetCustomerTotalRevenue(in inCustomerID int,
											inStartDate date,
                                            inEndDate date)
begin
	declare TotalRevenue decimal(10,2);
    
	select sum(OD.Quantity * OD.UnitPrice) into TotalRevenue
    from OrderDetails OD
    join Orders O on O.OrderID = OD.OrderID
    join Customers C on O.CustomerID = C.CustomerID
    where O.OrderDate between inStartDate and inEndDate;
    
    select TotalRevenue as CustomerTotalRevenue;
end //
delimiter ;

call GetCustomerTotalRevenue(1,'2023-11-01','2025-11-01');