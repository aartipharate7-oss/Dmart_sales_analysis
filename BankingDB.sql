-- ---------------------------------------------------
-- LAB 1 
-- -----------------------------------------------

create database BankingDB;

use BankingDB;

create table customers (
CustomerID int primary key, 
Firstname Varchar  (50),
Lastname varchar (50),
Email varchar (100),
Phone varchar (15), 
AccountCreations date 
);

describe Customers;

-- --------------------------------------------------
-- LAB 2 
-- ---------------------------------------------------

CREATE TABLE Accounts (
    AccountID INT,
    AccountType VARCHAR(20),
    Balance DECIMAL(10,2)
);

CREATE TABLE Transactions (
    TransactionID INT,
    TransactionDate DATE,
    Amount DECIMAL(10,2),
    TransactionType VARCHAR(20)
);

CREATE TABLE Branches (
    BranchID INT,
    BranchName VARCHAR(100),
    BranchAddress VARCHAR(200),
    BranchPhone VARCHAR(15)
);

CREATE TABLE AccountBranches ( 
		AssignmentDate DATE
);

CREATE TABLE Loans (
    LoanID INT,
    LoanAmount DECIMAL(10,2),
    InterestRate DECIMAL(5,2),
    StartDate DATE,
    EndDate DATE
);

-- added dateofbirth column to customers table
ALTER TABLE Customers ADD COLUMN  DateOfBirth DATE;
describe customers;

-- modify existing column 
alter table Customers modify phone varchar (20);

--  Constraints can also be added using ALTER to enforce business rules.
-- Adding a minimum balance rule to the Accounts table.
alter table Accounts add constraint chk_MinBalance
check (Balance >= 1000);

show create table accounts;

-- use  drop for deleting the table AccountBranches 
drop table AccountBranches;

-- Apply constraint for banking data

-- Apply pk to customers id

-- add customerID column in accounts table 
alter table Accounts add customerID int;

-- Connect Customers and Accounts table using FK
alter table Accounts 
add constraint fk_Accounts_Customers
foreign key(CustomerID)
references Customers(CustomerID);

-- apply not null to firstname ccolumn in Customers table 
alter table Customers modify FirstName varchar(50) Not Null;

-- apply unique constraint to get unique customer email
alter table Customers
 add constraint uq_Email unique (Email);
 
 -- Activity 
 
-- Accounts → Connect with Branches
-- Add a foreign key on BranchID that references Branches(BranchID).
alter table Branches add primary key(BranchID);
alter table Accounts add BranchID int;
ALTER TABLE Accounts
ADD CONSTRAINT FK_Accounts_Branches
FOREIGN KEY (BranchID)
REFERENCES Branches(BranchID);

-- Transactions → Connect with Accounts
-- Add a foreign key on AccountID that references Accounts(AccountID).
alter table Accounts add primary key(AccountID);
alter table Transactions add AccountID int;
ALTER TABLE Transactions
ADD CONSTRAINT FK_Transactions_Accounts
FOREIGN KEY (AccountID)
REFERENCES Accounts(AccountID);

-- Loans → Connect with Customers
--  a foreign key on CustomerID that references Customers(CustomerID).
-- Add a foreign key on AccountID that references Accounts(AccountID).
alter table Loans add CustomerID int;
ALTER TABLE Loans
ADD CONSTRAINT FK_Loans_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

-- ------------------------------------------------------------------------
-- LAB - 3
-- -------------------------------------------------------------------------

# TASK 1 : Insert Banking Records

-- Insert Records into Customers Table
Insert into customers(
customerID, FirstName, LastName, Email, Phone, DateofBirth)
values
(101,'Rahul','Sharma','rahul@gmail.com','9876543210','1998-04-15');

-- Insert Records into Accounts
Insert into Accounts
(AccountID, CustomerID, AccountType, Balance)
value
(201,101,'Saving',25000);

-- Insert 4 Records into Customers Table
INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone, DateOfBirth)
VALUES
(102, 'Priya', 'Patil', 'priya@gmail.com', '9988776655', '2000-09-20'),
(103, 'Amit', 'Patel', 'amit.patel@gmail.com', '9876500001', '1995-06-18'),
(104, 'Sneha', 'Joshi', 'sneha.joshi@gmail.com', '9876500002', '1997-09-12'),
(105, 'Rohan', 'Kulkarni', 'rohan.k@gmail.com', '9876500003', '1993-11-25');

-- Insert 4 Records into Accounts Table
INSERT INTO Accounts
(AccountID, CustomerID, AccountType, Balance)
VALUES
(202, 102, 'Current', 40000),
(203, 103, 'Savings', 35000),
(204, 104, 'Current', 60000),
(205, 105, 'Savings', 45000);

-- Insert 5 Records into Transactions Table
INSERT INTO Transactions
(TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES
(301, 201, '2025-05-10', 5000, 'Deposit'),
(302, 202, '2025-05-11', 2500, 'Withdraw'),
(303, 203, '2025-05-12', 10000, 'Deposit'),
(304, 204, '2025-05-13', 3000, 'Withdraw'),
(305, 205, '2025-05-14', 7000, 'Deposit');

-- Insert 5 Records into Branches Table
INSERT INTO Branches
(BranchID, BranchName, BranchAddress, BranchPhone)
VALUES
(1, 'Mumbai Branch', 'Andheri, Mumbai', '0221111111'),
(2, 'Pune Branch', 'Shivaji Nagar, Pune', '0202222222'),
(3, 'Nashik Branch', 'College Road, Nashik', '0253222222'),
(4, 'Nagpur Branch', 'Sitabuldi, Nagpur', '0712333333'),
(5, 'Navi Mumbai Branch', 'Vashi, Navi Mumbai', '0224444444');

-- Insert 5 Records into Loans Table
INSERT INTO Loans
(LoanID, LoanAmount, InterestRate, StartDate, EndDate, CustomerID)
VALUES
(301, 500000, 8.50, '2025-01-15', '2030-01-15', 101),
(302, 300000, 9.25, '2025-02-10', '2028-02-10', 102),
(303, 750000, 8.75, '2025-03-20', '2032-03-20', 103),
(304, 250000, 10.00, '2025-04-05', '2029-04-05', 104),
(305, 1000000, 7.95, '2025-05-12', '2035-05-12', 105);

# TASK 2 : Update Existing Banking Records

-- Update Customers Phone Number 
SET SQL_SAFE_UPDATES=0

UPDATE Customers
SET Phone='9999999999'
WHERE CustomerID=101;

select* from customers where CustomerID = 101;

-- Update Customer Email
UPDATE Customers
SET Email='rahul.sharma@gmail.com'
WHERE CustomerID=101;

SELECT * FROM Customers WHERE CustomerID = 101;

-- Activity 
-- 1. Modify the balance of AccountID 201 to 30000
update Accounts SET Balance = 3000
where Acccount_id= 201;

-- 2.Verify all updated records using SELECT queries.
select * from Accounts where Account_id = 201;

# Task 3: Delete Banking Records and Verify Data
-- Delet Transcation Records 
Delete from Transactions where TransactionID = 302;
select* from Transactions;

-- Delete Account Records 
Delete from Accounts where AccountID = 202;
select * from Accounts;

-- --------------------------------------------
-- LAB 4
-- -------------------------------------------

# Task 1: Review Customer Banking Information
 
 -- View complete Customer Information
 select* from Customers;

-- View only required Customers Details
select FirstName, LastName, Email, Phone from Customers;

-- Activty :
-- Retrieve only the following details from the Accounts table: AccountID, AccountType, and Balance.
select AccountID, AccountType,Balance from Accounts;

# Task 2: Investigate Specific Customer Transactions

-- 1. Retrieve Customers with Savings Accounts
select* from Accounts Where AccountType  = 'Savings';

-- 2.Retrieve Accounts with Balance Greater Than 25000
select* from Accounts where Balance > 25000;

-- 3.Retrieve Transactions Between Specific Amounts
select* from Transactions where Amount Between 5000 and 20000;

-- 4.Retrive Records for Selected Customers
select* from customers where CustomerId IN (101,102,103);

-- 5.Search Customers Using Partial Name Matching 
select* from customers where FirstName like 'R%';

-- Activity 
-- Perform the following investigations:
-- 1. Retrieve all current account records
select* from Accounts ;
-- 2.Find accounts with balance less than 15000
select* from Accounts where balance< 15000;
-- 3.Display transactions between 1000 and 10000
select* from Transactions where amount between 1000 and 10000;
-- 4.Retrieve customer records for CustomerID 104 and 105
select* from customers where CustomerID in (104,105);
-- 5.Display customers whose last name starts with S
select* from customers where lastname like 's%';

# Task 3: Generate Banking Reports for Management

-- 1.Display Customers in Alphabetical Order
SELECT * from Customers 
order by FirstName ASC;

-- 2.Display Accounts with Highest balance first
SELECT * from  Accounts
order by Balance DESC;

-- 3.Retrive Unique Account Types
SELECT Distinct AccountType from Accounts;

-- 4.Display Top 3 Highest Balance Accounts
SELECT * from Accounts 
Order By Balance DESC Limit 3;

-- 5.Skip Initial Records While Viewing Transactions
select* from Transactions
Limit 5 Offset 2 ;

-- Activity 
-- Generate the following reports
-- 1.Display customers sorted by LastName
select* from customers 
Order By Lastname ASC;
-- 2.Retrieve top 5 transactions with highest amount
select* from Transactions 
order by Amount DESC limit 5;
-- 3.Display unique transaction types
select Distinct TransactionType from Transactions;
-- 4.Skip the first 3 transaction records and display the next 4 records
select* from Transactions 
Limit 4 offset 3 ;

# TASK : 4 Identify Missing Banking Information

-- 1. Find Customers Without Phone Numbers
SELECT * FROM Customers
WHERE Phone IS NULL;

-- 2. Find Customers Having Email Addressess
SELECT * FROM Customers
WHERE Email IS NOT NULL;

--  Activity
-- 1.Find customers without email addresses
select * from customers 
where email is Null;
-- 2.Display all accounts where balance information is available
select* from Accounts 
where balance IS NOT NULL;

# TASK 5 : Categorize Customer Accounts Based on Balance

-- 1. Categorize Accounts Using Balance
Select AccountID,
       Balance,
      case
          when Balance >= 50000 then'Premium Account'
          when Balance >= 25000 then 'Standard Account'
           else'Basic Account'
       end as  AccountCategory
from Accounts;

-- Acyivity 
-- Create a report that categorizes transactions as:
-- High Transaction
-- Medium Transaction
-- Low Transaction
-- based on transaction amount.

select* from Transactions;

select TransactionId,Amount,
		case 
            when amount >= 8000 then "High Trans"
            when amount >= 5000 then "Medium Trans"
            else "low Trans"
		end as " Amount Category"
from Transactions ;

# TASK 6 : Analyze Customer Transactions Using Window Functions

-- 1. Assign Rank Based on Account Balance
SELECT AccountID,Balance,
       RANK() OVER (ORDER BY Balance DESC) AS BalanceRank
FROM Accounts;

-- 2.Calculate Running Total of Transactions
SELECT TransactionID,
       Amount,
       SUM(Amount) OVER (ORDER BY TransactionDate) AS RunningTotal
FROM Transactions;

-- 3.Display Average Transaction Amount 
SELECT TransactionID,
       Amount,
       AVG(Amount) OVER () AS AverageTransaction
FROM Transactions;

--  Activity 
-- 1.Rank customers based on account balance
select* from Customers;
SELECT CustomerID,
       Account_balance,
     RANK() OVER (ORDER BY account_balance DESC) AS balance_rank
FROM customers
ORDER BY balance_rank;
-- 2.Generate running total for account balances
-- 3.Display maximum transaction amount using a window function


-- ------------------------------------------------------------------------------
-- LAB 5 :
-- ------------------------------------------------------------------------------

# TASK 1 : Search Customers Based on Name

-- 1.Search Customers Whose First Name Starts with “A”
select* from Customers where firstname like "A%";

-- 2. Search Customers Whose Email Contains “gmail”
select* from  Customers where email like "%gmail%";

-- 3. Search Customers Whose Last Name Ends with “kar”
select*  from Customers where lastname like "%kar";

-- Activity 
select* from customers;
-- 1. Display customers whose first name starts with R
select* from Customers where firstname like"R%";
-- 2.Find customers whose email contains yahoo
select* from Customers where email like "%yahoo";
-- 3.Display customers whose last name starts with P
select* from Customers where lastname like "P%";
-- 4.Search customers whose phone number ends with 99
select* from Customers where phone like "%99";

# TASK 2 : Filter Records for Selected Banking Categories

-- 1.Retrieve Records for Selected Account Types
select* from Accounts where AccountType in("savings","Current");

-- 2. Retrieve Transactions for Selected Transaction Types
select* from Transactions where TransactionType in ('Withdraw','Deposit');

-- 3.Retrieve Records for Selected Customers 
select* from Customers where CustomerID in (101,102,105);

-- Activity 
-- 1.Display accounts belonging to Salary and Savings account types
select* from Accounts where AccountType in ('Salary','Saving');
-- 2.Retrieve transactions for Payment and Deposit categories
select* from Transactions where TransactionType in ('Payment','Deposite');
-- 3.Display customer records for CustomerID 103 and 104
select* from Customers where CustomerID in (103,104);
-- 4.Retrieve selected account records using AccountID values
select* from Accounts where AccountID in (202,205,201);

# TASK 3 :Generate Sorted Banking Reports

-- 1. Display Customers in Ascending Order of Last Name
select* from Customers order by lastname ASC;

-- 2. Display Accounts with Highest Balance First
select* from Accounts order by balance DESC;

-- 3.Display Transactions Sorted by Transaction Date
select* from Transactions order by TransactionDate DESC;

-- Activity 
-- 1.Display customers sorted by FirstName
select * from Customers 
-- 2.Display accounts sorted by AccountType
-- 3. Display transactions sorted by Amount in descending order
-- 4.Display customers sorted by DateOfBirth

# TASK 4 : Control Result Size for Faster Review

-- 1. Display Only Top 5 Highest Balance Accounts
select * from Accounts  order by Balance DESC limit 5;

-- 2. Display First 3 Customer Records 
select* from Customers limit 3;

-- 3.Skip Initial Transaction Records While Viewing Data
select*  from Transactions limit 5 offset 2;

-- Activity 
-- 1.Display top 3 transactions with highest amount
select* from Transactions order by Amount DESC limit 3;
-- 2.Retrieve only 4 customer records
select * from Customers limit 4;
-- 3.Skip first 2 account records and display next 3 records
select* from Accounts limit 5 Offset 2;
-- 4. Display top 5 latest transactions
select* from Transactions order by TransactionDate DESC limit 5;

# TASK 5 : Build Customer Search Reports for Banking

-- 1. Display Savings Account Customers Sorted by Balance
select* from Accounts where AccountType-'Savings' order by Balance DESC;

-- 2.Search Customers Using Partial Name and Limit Results
select* from Customers where Firstname like 's%' limit 5;

-- 3.Display Selected Transactions in Sorted Order
select* from Transactions
 where TransactionType in ('Deposite','Withdraw')
order by TransactionDate DESC;


-- ----------------------------------------------------------------------
-- LAB 6 
-- ----------------------------------------------------------------------

-- Task 1 :Apply string, math, and date functions

-- 1.String Functions
-- a.Display customer Table
select* from Customers;
-- b.Display all customer FirstName in uppercase 
select FirstName, UPPER(FirstName) AS UpperCaseName from Customers;
-- c.Display all customer FirstName in lowercase.
Select FirstName, Lower(FirstName) AS LoweCaseName from Customers;
-- d.Find the total number of characters in each customer FirstName .
select firstname,length(firstname) AS newlength from Customers;
-- e. Display only the first three characters of customer FirstName .
select firstname, left(firstname,3) AS initialss from Customers;
-- f.Combine customer's FirstName with LastName.
select concat(firstname,'-',lastname) as FullName from ustomers;

-- 2.Math Functions
--  a.ROUND()
# Purpose: Rounds a decimal number to the nearest whole number.
# Syntax : ROUND(number)
SELECT ROUND(1256.75) AS Rounded_Value;
-- b. CEIL()
#Purpose: Returns the smallest integer greater than or equal to a number.
#Syntax : CEIL(number)
SELECT CEIL(1256.25) AS Ceiling_Value;
-- C. CEIL()
# Purpose: Returns the smallest integer greater than or equal to a number.
#Syntax :CEIL(number)
SELECT CEIL(1256.25) AS Ceiling_Value;
-- d.ABS()
#Purpose: Returns the absolute (positive) value of a number.
#Syntax :ABS(number)
SELECT ABS(-2500) AS Absolute_Value;
-- e. MOD()
#Purpose: Returns the remainder after dividing one number by another.
#Syntax :MOD(dividend, divisor)
SELECT MOD(25,4) AS Remainder;

-- 3.Date Functions
-- a.Display customer Table
select * from customers;
--  b.Display the current system date.
SELECT CURDATE(); 
-- c.Display the current system date and time.
SELECT NOW();
-- d.Display the Birth of year
SELECT CustomerID, YEAR(DateOfBirth) AS BirthYear FROM customers;
-- e.Display the Birth month.
SELECT CustomerID, MONTH(DateOfBirth) AS BirthMonth FROM customers;
-- f.Calculate the number of days since BirthDate.
SELECT CustomerID, DATEDIFF(CURDATE(),DateOfBirth) AS Days FROM customers;

-- 4. Comparison Functions
-- a.Categorize customers as Adult or Young based on their birth year.
SELECT FirstName,
	   DateOfBirth,
    IF(YEAR(DateOfBirth) <= 1995,
       'Adult',
       'Young') AS Category
FROM Customers;
-- b.Display 'Not Available' if a phone number is NULL.
SELECT FirstName,
    IFNULL(Phone, 'Not Available') AS PhoneNumber
FROM Customers;
--  c. Find the latest birth date.
SELECT GREATEST('2000-09-20','1995-06-18','1997-09-12','1993-11-25') AS LatestBirthDate;
-- d.Find the earliest birth date.
SELECT LEAST('2000-09-20','1995-06-18','1997-09-12','1993-11-25') AS EarliestBirthDate;
-- e.Compare two customer names.
SELECT FirstName, NULLIF(FirstName,'Priya') AS Result FROM Customers;

# Task 2: Analyze Overall Banking Performance

-- 1.Calculate the total balance maintained across all customer accounts.
select sum(balance) as Total_balance from Accounts;

-- 2. Calculate the average balance maintained across all customer accounts to understand the typical amount held by customers.
select Avg(balance) as Avg_Balance from Accounts;

-- 3. Identify the highest balance maintained in any customer account. 
select max(balance) AS  Account_Balance from Accounts;

-- 4. Identify the lowest balance maintained in any customer account.
select min(balance) as low_balance from Accounts;

-- 5. Determine the total number of customer accounts available in the system.
select count(*) As total_accounts from Accounts;

# TASK 3 : Analyze Account-wise Performance

/*1.The bank wants to calculate the total account balance for each AccountType by grouping the 
records based on AccountType and identify which account type is attracting the
 highest total deposits from customers.*/
 
 SELECT 
    AccountType,
    SUM(Balance) AS TotalBalance
FROM Accounts
GROUP BY AccountType

# TASK 4 : Identify High-Performing Categories

/*The bank management wants to identify only those account types whose total customer 
deposits exceed ₹25,000.*/

Select  
AccountType,
    SUM(Balance) AS TotalBalance
FROM Accounts
GROUP BY AccountType
HAVING SUM(Balance) > 25000;


-- ------------------------------------------------------------------------
-- LAB 7
--  ------------------------------------------------------------------

-- Task 1: Understanding OVER()

-- Task 2: Rank Customer Loans Using RANK()
select * from loans;

select LoanID,customerid,LoanAmount,
rank() over(order by LoanAmount desc) as 'Loan_Rank'
from loans;

-- Task 3: Rank Customer Loans Using DENSE_RANK()
select LoanID,CustomerID,LoanAmount,
Dense_rank() over(order by LoanAmount DESC) as 'Loan_densrank'
from Loans;

-- Task 4: Assign Row Numbers Using ROW_NUMBER()
select LoanID,CustomerID,LoanAmount,
row_number() over (order by LoanAmount DESC) as 'Row_Number'
from Loans;

-- Task 5: Understanding PARTITION BY
select LoanID,CustomerID,LoanAmount,
row_number() over (partition by CustomerId order by LoanAmount DESC ) as 'Row_Num'
from Loans;

-- Task 6: Calculate Running Total Using SUM() OVER()
select LoanID,CustomerID,LoanAmount,
sum(LoanAmount) 
over(order by LoanAmount DESC) as 'RunningNumber'
from Loans;

-- Task 7: Compare Previous Loan Records Using LAG()
select LoanID,CustomerID,LoanAmount,
Lag(LoanAmount) over(order by LoanAmount DESC) as 'Previous_Loan_Amt'
from Loans;

-- Task 8: Compare Next Loan Records Using LEAD()
select LoanID,CustomerID,LoanAmount,
lead(LoanAmount) 
over (order by LoanAmount DESC) as 'Next_Loan_Amount'
from Loans;

-- --------------------------------------------------------------------------------------------
-- LAB 8 
-- ----------------------------------------------------------------------------------------------

-- TASK 1 : Generate Accounts Transaction Reports
SELECT
    a.AccountID, a.AccountType, a.Balance,
    t.TransactionID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount
FROM Accounts a
INNER JOIN Transactions t
ON a.AccountID = t.AccountID;

-- TASK 2 : Display All Accounts Including Those Without Transactions
select 
   a.AccountID, a.AccountType, a.Balance,
   t.TransactionID,
   t.TransactionDate,
   t.TransactionType,
   t.Amount
from Accounts a
left join Transactions t
on a.AccountID = t.AccountID;	

-- Task 3: Generate Deposit Transaction Report
select 
   a.AccountID, a.AccountType, a.Balance,
   t.TransactionID,
   t.TransactionDate,
   t.TransactionType,
   t.Amount
from Accounts a
inner join transactions t
on a.AccountID = T.AccountID
where t.Transactiontype = 'Deposit' ;

-- Task 4: Generate High Balance Account Transaction Reports
select 
   a.AccountID, a.AccountType, a.Balance,
   t.TransactionID,
   t.TransactionDate,
   t.TransactionType,
   t.Amount
from Accounts a
inner join Transactions t
on a.AccountID = T.AccountID 
where a.Balance > 30000
order by a.Balance DESC;

-- ----------------------------------------------------------------
-- LAB 9
-- ----------------------------------------------------------------

-- Task 1: Identify Transactions Above the Average Transaction Amount
select avg(Amount) from Transactions;

select* from Transactions 
where Amount > 
(select avg(Amount) from Transactions);

-- Task 2: Identify Accounts with Above-Average Balance
select AccountID, Accounttype, Balance, CustomerID
from Accounts
where balance > 
(
select avg (balance)
from Accounts
)
order by  Balance DESC;


-- Task 3: Identify Deposit Accounts Using a Multi-Row Subquery
-- Fetch all account details from Account table where transaction type is deposit in transactions table

select AccountID From Transactions
where TransactionType = "Deposite";

select AccountID, Accounttype, Balance
from Accounts
where AccountID in
(
select AccountID
From Transactions
where TransactionType = "Deposite"
);

-- Task 4: Identify the Account with the Highest Balance
 select max(balance) from Accounts;
 
select AccountID, Accounttype, Balance, CustomerID
from Accounts
where Balance =
( select max(balance) from Accounts);


-- -------------------------------------------------------------------------------
-- LAB 10 
-- ----------------------------------------------------------------------------------

-- Task 1: Create a View for High-Balance Accounts
create view High_Balance_Account as 
select 
 AccountID,
 AccountType,
 Balance,
CustomerID
From Accounts 
Where Balance  > 30000;

-- Task 2: Retrieve Data Using the View
select * from High_Balance_Account;

-- Task 3: Modify the View to Include Transaction Details
Create or Replace View High_Balance_Account as 
select 
   a.AccountID, a.AccountType, a.Balance, a.CustomerID,
   t.TransactionID,
   t.TransactionDate,
   t.TransactionType,
   t.Amount
from Accounts a
inner join Transactions t 
on a.AccountID = t.AccountID 
Where a.Balance > 30000;

-- Task 4: Generate Banking Reports Using the View
select
 AccountID, 
 AccountType, 
 Balance, 
 CustomerID,
   TransactionID,
   TransactionDate,
   TransactionType,
   Amount
from High_Balance_Account
order by Balance DESC;

