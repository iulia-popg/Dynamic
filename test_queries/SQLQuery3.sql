SELECT --count(*)
		--Hist_rate.ReportDate,
		--LoanOriginationDate,
		--LTI ,
		--BorrowerBirthDate, 
		--EmploymentStatus,
		--IndexedDTI,
		--OriginalLTV,
		--IndexedLTFV
		--min(DATALENGTH(Loan.M_LoanID)),
		--max(DATALENGTH(Loan.M_LoanID))
		count(*)
FROM 	Loan --- sau credit?
--where --DATALENGTH(rtrim(Loan.M_LoanID))= 66
--M_LoanID = '53d2fa5a49839907b84db0233a53d91f2'
JOIN 	Income ON Loan.M_LoanID = Income.M_LoanID
--JOIN 	Mortgage ON Loan.M_LoanID = Mortgage.M_LoanID
--JOIN 	Rates ON Loan.M_LoanID = Rates.M_LoanID
--JOIN 	Securitization ON Loan.M_LoanID = Securitization.M_LoanID
--JOIN 	Valuation ON Loan.M_LoanID = Valuation.M_LoanID
---- here the data will get duplicated
--JOIN 	Hist_rate ON Loan.M_LoanID = Hist_rate.M_LoanID
--left join 	history	on loan.m_loanid = history.m_loanid
--		and hist_rate.reportdate = history.reportdate 

--delete from Loan where DATALENGTH(rtrim(Loan.M_LoanID))> 64