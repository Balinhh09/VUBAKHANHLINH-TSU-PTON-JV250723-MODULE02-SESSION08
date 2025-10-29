-- GetCustomerByPhone: Tạo một thủ tục nhận tham số IN là số điện thoại
-- để tìm kiếm và trả về thông tin chi tiết của khách hàng.
delimiter $$
create procedure GetCustomerByPhone (in Phone_Number varchar(15))
begin 
	select CustomerID, 
		   FullName, 
           DateOfBirth, 
           Address,
           PhoneNumber,
           Email,
           BranchID
    from Customers
    where PhoneNumber = Phone_Number;
end $$
delimiter ;

-- GetTotalBalance: Tạo một thủ tục nhận tham số IN là CustomerID và sử dụng
-- tham số OUT để trả về tổng số dư của tất cả tài khoản của khách hàng đó.
delimiter $$
create procedure GetTotalBalance (in p_CustomerID int,
								  out p_TotalBalance decimal(15,2))
begin
	select sum(Balance) into p_TotalBalance
	from Accounts 
    where CustomerID = p_CustomerID;
end $$
delimiter ;

-- IncreaseEmployeeSalary: Tạo một thủ tục sử dụng tham số INOUT 
-- để nhập mức lương hiện tại và trả về mức lương đã được tăng 10%.
-- Thủ tục cũng nhận tham số IN là EmployeeID để cập nhật mức lương mới
-- vào bảng Employees.
delimiter $$
create procedure IncreaseEmployeeSalary(in p_EmployeeID int,
										inout io_CurrentSalary decimal(10,2))
begin 
	declare increase_rate decimal(3,2) default 0.1;
    declare new_salary decimal(10,2);
    
    set new_salary = io_CurrentSalary * (1 + increase_rate);
    
    update Employees
    set Salary = new_salary
    where EmployeeID = p_EmployeeID;
    
    set io_CurrentSalary = new_salary;
end $$
delimiter ;

-- Gọi GetCustomerByPhone: Sử dụng CALL với số điện thoại '0901234567'
-- để xem thông tin khách hàng.
call GetCustomerByPhone('0901234567');

-- Gọi GetTotalBalance: Dùng CALL với CustomerID = 1 và một biến
-- session (@total_balance) để nhận giá trị trả về. Sau đó, sử dụng
-- SELECT @total_balance; để hiển thị kết quả.
set @total_balance = 0;
call GetTotalBalance(1,@total_balance);

select @total_balance as TotalCustomerBalance;
    
-- Gọi IncreaseEmployeeSalary: Truy vấn mức lương hiện tại của nhân viên
-- có EmployeeID = 4 và gán vào một biến session. Sau đó, dùng CALL
-- để thực thi thủ tục với biến đó và hiển thị mức lương mới.
set @newSalary = '15000000.00';
call IncreaseEmployeeSalary(4,@newSalary);

select @newSalary as NewSalary;

-- Sử dụng DROP PROCEDURE IF EXISTS để xóa tất cả các thủ tục đã tạo,
-- đảm bảo rằng mã nguồn có thể chạy lại mà không gặp lỗi.
DROP PROCEDURE IF EXISTS GetCustomerByPhone;
DROP PROCEDURE IF EXISTS GetTotalBalance;
DROP PROCEDURE IF EXISTS IncreaseEmployeeSalary;