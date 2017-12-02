
---clean out duplicated data, before inserting again:

delete from [dbo].Securitization
where DATALENGTH(rtrim(M_LoanID))> 64;
go
exec [dbo].[sp_Insert_Scale_Up_Data_In_Table] 'Securitization',0, 399;
go
exec [dbo].[sp_Insert_Scale_Up_Data_In_Table] 'Securitization',399, 9;
go

delete from [dbo].Loan
where DATALENGTH(rtrim(M_LoanID))> 64;
go
exec [dbo].[sp_Insert_Scale_Up_Data_In_Table] 'Loan',0, 399;
go
exec [dbo].[sp_Insert_Scale_Up_Data_In_Table] 'Loan',399, 9;
go

delete from [dbo].Mortgage
where DATALENGTH(rtrim(M_LoanID))> 64;
go
exec [dbo].[sp_Insert_Scale_Up_Data_In_Table] 'Mortgage',0, 399;
go
exec [dbo].[sp_Insert_Scale_Up_Data_In_Table] 'Mortgage',399, 9;
go

delete from [dbo].Income
where DATALENGTH(rtrim(M_LoanID))> 64;
go
exec [dbo].[sp_Insert_Scale_Up_Data_In_Table] 'Income',0, 399;
go
exec [dbo].[sp_Insert_Scale_Up_Data_In_Table] 'Income',399, 9;
go

delete from [dbo].Rates
where DATALENGTH(rtrim(M_LoanID))> 64;
go
exec [dbo].[sp_Insert_Scale_Up_Data_In_Table] 'Rates',0, 399;
go
exec [dbo].[sp_Insert_Scale_Up_Data_In_Table] 'Rates',399, 9;
go

delete from [dbo].Valuation
where DATALENGTH(rtrim(M_LoanID))> 64;
go
exec [dbo].[sp_Insert_Scale_Up_Data_In_Table] 'Valuation',0, 399;
go
exec [dbo].[sp_Insert_Scale_Up_Data_In_Table] 'Valuation',399, 9;
go

delete from [dbo].History
where DATALENGTH(rtrim(M_LoanID))> 64;
go
exec [dbo].[sp_Insert_Scale_Up_Data_In_Table] 'History',0, 399;
go
exec [dbo].[sp_Insert_Scale_Up_Data_In_Table] 'History',399, 9;
go

delete from [dbo].Hist_Rate
where DATALENGTH(rtrim(M_LoanID))> 64;
go
exec [dbo].[sp_Insert_Scale_Up_Data_In_Table] 'Hist_Rate',0, 399;
go
exec [dbo].[sp_Insert_Scale_Up_Data_In_Table] 'Hist_Rate',399, 9;
go

/*
select	count(*),count(distinct Loan.M_LoanID)
FROM 	Loan 
JOIN 	Income ON Loan.M_LoanID = Income.M_LoanID
JOIN 	Mortgage ON Loan.M_LoanID = Mortgage.M_LoanID
JOIN 	Rates ON Loan.M_LoanID = Rates.M_LoanID
JOIN 	Securitization ON Loan.M_LoanID = Securitization.M_LoanID
JOIN 	Valuation ON Loan.M_LoanID = Valuation.M_LoanID
-- here the data will get duplicated
JOIN 	Hist_rate ON Loan.M_LoanID = Hist_rate.M_LoanID
join 	history	on loan.m_loanid = history.m_loanid
		and hist_rate.reportdate = history.reportdate ;

--- build indexes:
CREATE clustered INDEX i1 ON Loan (M_LoanID);  
CREATE clustered INDEX i2 ON Mortgage (M_LoanID);  
CREATE clustered INDEX i3 ON Income (M_LoanID);  
CREATE clustered INDEX i4 ON Rates (M_LoanID);  
CREATE clustered INDEX i5 ON Securitization (M_LoanID);  
CREATE clustered INDEX i6 ON Valuation (M_LoanID);  
CREATE nonclustered INDEX i5 ON Hist_rate (M_LoanID);  
CREATE nonclustered INDEX i6 ON hist_rate (M_LoanID);  
*/