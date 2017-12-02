

CREATE PROCEDURE [dbo].[sp_DEL_truncate_all_tables_before_run]
	@truncate bit = 1
AS
begin
	if @truncate = 1
		begin
		truncate table [dbo].[Loan];
		truncate table [dbo].[Hist_Rate];
		truncate table [dbo].[History];
		truncate table [dbo].[Income];
		truncate table [dbo].[Mortgage];
		truncate table [dbo].[Rates];
		truncate table [dbo].[Securitization];
		truncate table [dbo].[Valuation];
		end
RETURN 0
end
