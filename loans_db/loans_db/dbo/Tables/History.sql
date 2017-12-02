CREATE TABLE [dbo].[History] (
    [M_PoolID]                NVARCHAR (255)   NULL,
    [M_LoanID]                NVARCHAR (255)   NULL,
    [ReportDate]              DATETIME         NULL,
    [CurrentPrincipalBalance] DECIMAL (28, 10) NULL,
    [CurrentLTV]              DECIMAL (28, 10) NULL,
    [LoanAge]                 TINYINT          NULL,
    [CurrentPropertyVal]      DECIMAL (28, 10) NULL,
    [Savings]                 DECIMAL (28, 10) NULL,
    [CurrentIndexedLTV]       DECIMAL (28, 10) NULL,
    [DelinquencyStatus]       NVARCHAR (255)   NULL,
    [BorrowerExposure]        DECIMAL (28, 10) NULL,
    [NoBorrowers]             TINYINT          NULL,
    [HISTORY_Id]              NUMERIC (20)     NULL
);

