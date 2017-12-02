CREATE TABLE [dbo].[Rates] (
    [M_PoolID]               NVARCHAR (255) NULL,
    [M_LoanID]               NVARCHAR (255) NULL,
    [ReversionaryDate]       DATETIME       NULL,
    [InterestStartDate]      DATETIME       NULL,
    [RemainingFixedRateTerm] INT            NULL,
    [PrincipalStartDate]     DATETIME       NULL,
    [OriginalFixedRateTerm]  INT            NULL,
    [MASTER_Id]              VARCHAR (100)  NULL
);

