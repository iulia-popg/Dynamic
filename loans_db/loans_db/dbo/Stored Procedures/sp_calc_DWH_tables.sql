CREATE PROCEDURE [dbo].[sp_calc_DWH_tables]
	--C. values for chart and filters (data to be aggregated in OLAP cubes)
AS
begin

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

--select * from dbo.DimDate;
--select MIN(LoanOriginationDate) from Loan; --1997-07-10 12:00:00.000
--select MIN(BorrowerBirthDate) from Income; --1931-12-12 12:00:00.000

Create table dbo.DimIncome
(
IncomeID int primary key identity,
M_LoanID varchar(100) not null,
LTI decimal(28,10) null,
BorrowerBirthDate_key int,
EmploymentStatus nvarchar(255) null, --varchar(20)
IndexedDTI decimal(28,10) null
,INDEX IX_DimIncome NONCLUSTERED (M_LoanID)
);
insert into DimIncome (M_LoanID, LTI, BorrowerBirthDate_key, EmploymentStatus, IndexedDTI)
select	M_LoanID,
		LTI,
		CONVERT (char(8),BorrowerBirthDate,112) as BorrowerBirthDate_key,  --- and datekey
		EmploymentStatus,
		IndexedDTI
from	Income;

--select * from DimIncome;

Create table dbo.DimValuation
(
ValuationID int primary key identity,
M_LoanID varchar(100) not null,
OriginalLTV decimal(28,10) null,
IndexedLTFV decimal(28,10) null,
distr_OriginationPropertyValue varchar(50),
distr_IndexedLTFV varchar(50)
,INDEX IX_DimValuation NONCLUSTERED (M_LoanID)
);
insert into DimValuation (M_LoanID, OriginalLTV, IndexedLTFV, distr_OriginationPropertyValue, distr_IndexedLTFV)
select	M_LoanID,
		OriginalLTV,
		IndexedLTFV,  --- and datekey
		case --- min 74000, max 510000
		when OriginalPropertyValue <= 50000 then '0. <= 50k'
		when OriginalPropertyValue > 50000 and OriginalPropertyValue <= 75000 then '1. (50 - 75k]'
		when OriginalPropertyValue > 75000 and OriginalPropertyValue <= 100000 then '2. (75 - 100k]'
		when OriginalPropertyValue > 100000 and OriginalPropertyValue <= 150000 then '3. (100 - 150k]'
		when OriginalPropertyValue > 150000 and OriginalPropertyValue <= 200000 then '4. (150 - 200k]'
		when OriginalPropertyValue > 200000 and OriginalPropertyValue <= 300000 then '5. (200 - 300k]'
		when OriginalPropertyValue > 300000 and OriginalPropertyValue <= 400000 then '6. (300 - 400k]'
		when OriginalPropertyValue > 400000 and OriginalPropertyValue <= 500000 then '7. (400 - 500k]'
		when OriginalPropertyValue > 500000 then '8. (400 - 500k]'
		end As distr_OriginationPropertyValue,
		CASE 
		when IndexedLTFV <= 10 then '0. <= 10'
		when IndexedLTFV > 10 and IndexedLTFV < 50 then '1. (10-50]'
		when IndexedLTFV > 50 and IndexedLTFV < 100 then '2. (50-100]'
		when IndexedLTFV > 100 and IndexedLTFV < 150 then '3. (100-150]'
		when IndexedLTFV > 150 and IndexedLTFV < 200 then '4. (100-150]'
		end as distr_IndexedLTFV
from	Valuation;

create table dbo.DimHistory
(
HistID int primary key identity,
M_LoanID varchar(100) not null,
ReportDate_key int,
ReportDate datetime
,INDEX IX_DimHistory NONCLUSTERED (M_LoanID)
);
insert into DimHistory (M_LoanID, ReportDate_key, ReportDate)
SELECT 	M_LoanID,
		CONVERT (char(8),ReportDate,112) As ReportDate_key,
		ReportDate
FROM 	History;


create table dbo.FactLoan 
(
TransactionId bigint primary key identity,
ValuationID int,
IncomeID int,
HistID int,
LoanOriginationDate_key int,
OriginalPrincipalBalance decimal(28,10) null,
DTI decimal(28,10) null,
LTI decimal(28,10) null,
TotalIncome decimal(28,10) null,
IndexedDTI  decimal(28,10) null,
IndexedLTI  decimal(28,10) null,
IndexedTotalIncome  decimal(28,10) null,
CurrentInterestRate  decimal(28,10) null,
OriginalLTV  decimal(28,10) null,
OriginalLTFV  decimal(28,10) null,
OriginalForeclosureValue  decimal(28,10) null,
IndexedLTFV  decimal(28,10) null
);
insert into FactLoan (ValuationID ,
IncomeID,
HistID,
LoanOriginationDate_key,
OriginalPrincipalBalance,
DTI ,
LTI,
TotalIncome ,
IndexedDTI  ,
IndexedLTI  ,
IndexedTotalIncome  ,
CurrentInterestRate  ,
OriginalLTV  ,
OriginalLTFV  ,
OriginalForeclosureValue  ,
IndexedLTFV)
select 	ValuationID ,
		IncomeID,
		HistID,
		CONVERT (char(8),LoanOriginationDate,112) As LoanOriginationDate_key,
		OriginalPrincipalBalance,
		DTI ,
		LTI ,
		TotalIncome ,
		IndexedDTI  ,
		IndexedLTI  ,
		IndexedTotalIncome  ,
		CurrentInterestRate  ,
		OriginalLTV  ,
		OriginalLTFV  ,
		OriginalForeclosureValue  ,
		IndexedLTFV
FROM 	Loan
JOIN 	History ON Loan.M_LoanID = History.M_LoanID
JOIN 	Income ON Loan.M_LoanID = Income.M_LoanID
JOIN 	Valuation ON Loan.M_LoanID = Valuation.M_LoanID
JOIN	Hist_Rate ON Loan.M_LoanID = Hist_Rate.M_LoanID
		AND History.ReportDate = Hist_Rate.ReportDate
JOIN 	DimIncome ON Loan.M_LoanID = DimIncome.M_LoanID
JOIN 	DimValuation ON Loan.M_LoanID = DimValuation.M_LoanID
JOIN 	DimHistory ON Loan.M_LoanID = DimHistory.M_LoanID
		AND DimHistory.ReportDate = History.ReportDate;

END