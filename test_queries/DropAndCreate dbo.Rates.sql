USE [test_loans]
GO

/****** Object: Table [dbo].[Rates] Script Date: 11/29/2017 2:35:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE [dbo].[Rates];


GO
CREATE TABLE [dbo].[Rates] (
    [M_PoolID]               NVARCHAR (255) NULL,
    [M_LoanID]               NVARCHAR (255) NULL,
    [ReversionaryDate]       DATETIME       NULL,
    [InterestStartDate]      DATETIME       NULL,
    [RemainingFixedRateTerm] INT        NULL,
    [PrincipalStartDate]     DATETIME       NULL,
    [OriginalFixedRateTerm]  INT        NULL,
    [MASTER_Id]              VARCHAR (100)  NULL
);


