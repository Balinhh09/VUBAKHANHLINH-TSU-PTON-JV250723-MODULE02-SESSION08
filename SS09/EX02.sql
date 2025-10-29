-- Tạo Single-column Index
create index idx_phonenumber
on Customers(PhoneNumber);

explain analyze
select *
from Customers
where PhoneNumber = '0901234567';

-- Tạo Composite Index
create index idx_branchidsalary
on Employees(BranchID,Salary);

explain analyze
select *
from Employees
where BranchID = 3 and Salary = 10000000.00;

-- Tạo Unique Index
create unique index idx_accountidcustomerid
on Accounts(AccountID,CustomerID);

-- Hiển thị và xóa Index
show index from Customers;
show index from Employees;
show index from Accounts;

drop index idx_phonenumber on Customers;

create index idx_branchid_fk on Employees(BranchID);
alter table Employees drop index idx_branchidsalary;

drop index idx_accountidcustomerid on Accounts;

