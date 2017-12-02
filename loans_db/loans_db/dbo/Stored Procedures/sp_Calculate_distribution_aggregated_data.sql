
CREATE PROCEDURE [dbo].[sp_Calculate_distribution_aggregated_data]
	--C. weigthed avg based on CurrentPrincipalBalance
AS
begin

SELECT 	History.ReportDate,
		Loan.M_LoanID,
		CurrentPrincipalBalance/sum(CurrentPrincipalBalance) over (partition by History.ReportDate) as weight,
		Year(LoanOriginationDate) As orig_year,
		CurrentPrincipalBalance/sum(CurrentPrincipalBalance) over (partition by History.ReportDate, Year(LoanOriginationDate)) as weight_orig_year,
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
		CurrentPrincipalBalance/sum(CurrentPrincipalBalance) over (partition by History.ReportDate, 
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
		end) as weight_orig_property,
		CASE 
		when IndexedLTFV <= 10 then '0. <= 10'
		when IndexedLTFV > 10 and IndexedLTFV < 50 then '1. (10-50]'
		when IndexedLTFV > 50 and IndexedLTFV < 100 then '2. (50-100]'
		when IndexedLTFV > 100 and IndexedLTFV < 150 then '3. (100-150]'
		when IndexedLTFV > 150 and IndexedLTFV < 200 then '4. (100-150]'
		end as distr_IndexedLTFV,
		CurrentPrincipalBalance/sum(CurrentPrincipalBalance) over (partition by History.ReportDate, 
		CASE 
		when IndexedLTFV <= 10 then '0. <= 10'
		when IndexedLTFV > 10 and IndexedLTFV < 50 then '1. (10-50]'
		when IndexedLTFV > 50 and IndexedLTFV < 100 then '2. (50-100]'
		when IndexedLTFV > 100 and IndexedLTFV < 150 then '3. (100-150]'
		when IndexedLTFV > 150 and IndexedLTFV < 200 then '4. (100-150]'
		end) As weight_idxltfv,
		Loan.OriginalPrincipalBalance, 
		Income.DTI,
		Income.LTI,
		Income.TotalIncome,
		Income.IndexedDTI,
		Income.IndexedLTI,
		Income.IndexedTotalIncome ,
		Hist_Rate.CurrentInterestRate ,
		Valuation.OriginalLTV,
		Valuation.OriginalLTFV ,
		Valuation.OriginalForeclosureValue ,
		Valuation.IndexedLTFV
INTO 	#weights_by_distribution
FROM 	History
JOIN	Loan ON Loan.M_LoanID = History.M_LoanID
JOIN 	Income ON Loan.M_LoanID = Income.M_LoanID
JOIN 	Valuation ON Loan.M_LoanID = Valuation.M_LoanID
JOIN	Hist_Rate ON Loan.M_LoanID = Hist_Rate.M_LoanID
		AND History.ReportDate = Hist_Rate.ReportDate;

---- 1st distribution set by LoanOriginationDate (year):
drop table if exists dbo.distribution_by_orig_year;

select	ReportDate,
		distr_OriginationPropertyValue,
		SUM(OriginalPrincipalBalance * weight_orig_year) As wa_OriginalPrincipalBalance, 
		SUM(DTI * weight_orig_year) As wa_DTI,
		SUM(LTI * weight_orig_year) As wa_LTI,
		SUM(TotalIncome * weight_orig_year) As wa_TotalIncome,
		SUM(IndexedDTI * weight_orig_year) As wa_IndexedDTI,
		SUM(IndexedLTI * weight_orig_year) As wa_IndexedLTI,
		SUM(IndexedTotalIncome * weight_orig_year) As wa_IndexedTotalIncome ,
		SUM(CurrentInterestRate * weight_orig_year) As wa_CurrentInterestRate,
		SUM(OriginalLTV * weight_orig_year) As wa_OriginalLTV,
		SUM(OriginalLTFV * weight_orig_year) As wa_OriginalLTFV,
		SUM(OriginalForeclosureValue * weight_orig_year) As wa_OriginalForeclosureValue,
		SUM(IndexedLTFV * weight_orig_year) As wa_IndexedLTFV
INTO	dbo.distribution_by_orig_year
from	#weights_by_distribution
GROUP BY ReportDate,
		distr_OriginationPropertyValue;

---- 2nd distribution set by OriginalPropertyValue:
drop table if exists dbo.distribution_by_orig_prop_value;

select	ReportDate,
		orig_year,
		SUM(OriginalPrincipalBalance * weight_orig_property) As wa_OriginalPrincipalBalance, 
		SUM(DTI * weight_orig_property) As wa_DTI,
		SUM(LTI * weight_orig_property) As wa_LTI,
		SUM(TotalIncome * weight_orig_property) As wa_TotalIncome,
		SUM(IndexedDTI * weight_orig_property) As wa_IndexedDTI,
		SUM(IndexedLTI * weight_orig_property) As wa_IndexedLTI,
		SUM(IndexedTotalIncome * weight_orig_property) As wa_IndexedTotalIncome ,
		SUM(CurrentInterestRate * weight_orig_property) As wa_CurrentInterestRate,
		SUM(OriginalLTV * weight_orig_property) As wa_OriginalLTV,
		SUM(OriginalLTFV * weight_orig_property) As wa_OriginalLTFV,
		SUM(OriginalForeclosureValue * weight_orig_property) As wa_OriginalForeclosureValue,
		SUM(IndexedLTFV * weight_orig_property) As wa_IndexedLTFV
INTO	dbo.distribution_by_orig_prop_value
from	#weights_by_distribution
GROUP BY ReportDate,
		orig_year;

---- 3nd distribution set by Indexed LTFV:
drop table if exists dbo.distribution_by_idx_ltfv;

select	ReportDate,
		distr_IndexedLTFV,
		SUM(OriginalPrincipalBalance * weight_idxltfv) As wa_OriginalPrincipalBalance, 
		SUM(DTI * weight_idxltfv) As wa_DTI,
		SUM(LTI * weight_idxltfv) As wa_LTI,
		SUM(TotalIncome * weight_idxltfv) As wa_TotalIncome,
		SUM(IndexedDTI * weight_idxltfv) As wa_IndexedDTI,
		SUM(IndexedLTI * weight_idxltfv) As wa_IndexedLTI,
		SUM(IndexedTotalIncome * weight_idxltfv) As wa_IndexedTotalIncome ,
		SUM(CurrentInterestRate * weight_idxltfv) As wa_CurrentInterestRate,
		SUM(OriginalLTV * weight_idxltfv) As wa_OriginalLTV,
		SUM(OriginalLTFV * weight_idxltfv) As wa_OriginalLTFV,
		SUM(OriginalForeclosureValue * weight_idxltfv) As wa_OriginalForeclosureValue,
		SUM(IndexedLTFV * weight_idxltfv) As wa_IndexedLTFV
INTO	dbo.distribution_by_idx_ltfv
from	#weights_by_distribution
GROUP BY ReportDate,
		distr_IndexedLTFV;

end