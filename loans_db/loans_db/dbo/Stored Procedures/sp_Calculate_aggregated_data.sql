CREATE PROCEDURE [dbo].[sp_Calculate_aggregated_data]
	--B. weigthed avg based on CurrentPrincipalBalance
AS
begin

SELECT 	ReportDate,
		M_LoanID,
		CurrentPrincipalBalance/sum(CurrentPrincipalBalance) over (partition by ReportDate) as weight
INTO 	#weight_per_loan_date
FROM 	History;

SELECT  Hist_Rate.ReportDate,
		SUM(Loan.OriginalPrincipalBalance * #weight_per_loan_date.weight) As wa_OriginalPrincipalBalance,
		AVG(Loan.OriginalPrincipalBalance) As avg_OriginalPrincipalBalance,
		SUM(Income.DTI * #weight_per_loan_date.weight) As wa_dti,
		SUM(Income.LTI * #weight_per_loan_date.weight) As wa_lti,
		SUM(Income.TotalIncome * #weight_per_loan_date.weight) As wa_TotalIncome,
		SUM(Income.IndexedDTI * #weight_per_loan_date.weight) As wa_IndexedDTI,
		SUM(Income.IndexedLTI * #weight_per_loan_date.weight) As wa_IndexedLTI,
		SUM(Income.IndexedTotalIncome * #weight_per_loan_date.weight) As wa_IndexedTotalIncome,
		SUM(Hist_Rate.CurrentInterestRate * #weight_per_loan_date.weight) As wa_CurrentInterestRate,
		SUM(Valuation.OriginalLTV * #weight_per_loan_date.weight) As wa_OriginalLTV,
		SUM(Valuation.OriginalLTFV * #weight_per_loan_date.weight) As wa_OriginalLTFV,
		SUM(Valuation.OriginalForeclosureValue * #weight_per_loan_date.weight) As wa_OriginalForeclosureValue,
		SUM(Valuation.IndexedLTFV * #weight_per_loan_date.weight) As wa_IndexedLTFV--,
		--Year(LoanOriginationDate) As distr_OriginationYear--,
		--case --- min 74000, max 510000
		--when OriginalPropertyValue <= 50000 then '0. <= 50k'
		--when OriginalPropertyValue > 50000 and OriginalPropertyValue <= 75000 then '1. (50 - 75k]'
		--when OriginalPropertyValue > 75000 and OriginalPropertyValue <= 100000 then '2. (75 - 100k]'
		--when OriginalPropertyValue > 100000 and OriginalPropertyValue <= 150000 then '3. (100 - 150k]'
		--when OriginalPropertyValue > 150000 and OriginalPropertyValue <= 200000 then '4. (150 - 200k]'
		--when OriginalPropertyValue > 200000 and OriginalPropertyValue <= 300000 then '5. (200 - 300k]'
		--when OriginalPropertyValue > 300000 and OriginalPropertyValue <= 400000 then '6. (300 - 400k]'
		--when OriginalPropertyValue > 400000 and OriginalPropertyValue <= 500000 then '7. (400 - 500k]'
		--when OriginalPropertyValue > 500000 then '8. (400 - 500k]'
		--end As distr_OriginationPropertyValue
		--IndexedLTFV --- min 9, max 160
FROM 	Loan
JOIN 	#weight_per_loan_date ON Loan.M_LoanID = #weight_per_loan_date.M_LoanID
JOIN 	Income ON Loan.M_LoanID = Income.M_LoanID
JOIN 	Valuation ON Loan.M_LoanID = Valuation.M_LoanID
JOIN	Hist_Rate ON Loan.M_LoanID = Hist_Rate.M_LoanID
		AND #weight_per_loan_date.ReportDate = Hist_Rate.ReportDate
GROUP BY Hist_Rate.ReportDate; --,
		--Year(LoanOriginationDate),
		--case --- min 74000, max 510000
		--when OriginalPropertyValue <= 50000 then '0. <= 50k'
		--when OriginalPropertyValue > 50000 and OriginalPropertyValue <= 75000 then '1. (50 - 75k]'
		--when OriginalPropertyValue > 75000 and OriginalPropertyValue <= 100000 then '2. (75 - 100k]'
		--when OriginalPropertyValue > 100000 and OriginalPropertyValue <= 150000 then '3. (100 - 150k]'
		--when OriginalPropertyValue > 150000 and OriginalPropertyValue <= 200000 then '4. (150 - 200k]'
		--when OriginalPropertyValue > 200000 and OriginalPropertyValue <= 300000 then '5. (200 - 300k]'
		--when OriginalPropertyValue > 300000 and OriginalPropertyValue <= 400000 then '6. (300 - 400k]'
		--when OriginalPropertyValue > 400000 and OriginalPropertyValue <= 500000 then '7. (400 - 500k]'
		--when OriginalPropertyValue > 500000 then '8. (400 - 500k]'
		--end;

end