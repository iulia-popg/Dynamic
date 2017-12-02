USE [test_loans]
GO

exec [dbo].[sp_Insert_Scale_Up_Data_In_Table] 'Loan',400,10

SELECT	@return_value as 'Return Value'

GO

