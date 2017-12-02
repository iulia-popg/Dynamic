create table dbo.DimDate (
[DateKey] INT primary key, 
DateValue DATETIME,
year int
);

WITH mycte AS
(
  SELECT CAST('1931-01-01' AS DATETIME) DateValue
  UNION ALL
  SELECT  DateValue + 1
  FROM    mycte   
  WHERE   DateValue + 1 < '2018-12-31'
)
insert into dbo.DimDate
SELECT  CONVERT (char(8),DateValue,112) as DateKey,
		DateValue,
		year(DateValue) as year		
FROM    mycte
OPTION (MAXRECURSION 0);

--select MIN(LoanOriginationDate) from Loan; --1997-07-10 12:00:00.000
--select MIN(BorrowerBirthDate) from Income; --1931-12-12 12:00:00.000

Create table DimIncome
(
IncomeID int primary key identity,
M_LoanID --varchar(10) not null,
BorrowerBirthDate --varchar(50),
EmploymentStatus --varchar(20)
IndexedDTI 
)

select	M_LoanID,
		LTI,
		BorrowerBirthDate,  --- and datekey
		EmploymentStatus,
		IndexedDTI
from	Income