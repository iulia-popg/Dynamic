CREATE TABLE [dbo].[Loan] (
    [MASTER_Id]                VARCHAR (100)    NULL,
    [M_PoolID]                 NVARCHAR (255)   NULL,
    [M_LoanID]                 NVARCHAR (255)   NULL,
    [M_BorrowerID]             NVARCHAR (255)   NULL,
    [ClassType]                TINYINT          NULL,
    [OriginalPrincipalBalance] DECIMAL (28, 10) NULL,
    [LoanOriginationDate]      DATETIME         NULL,
    [MaturityDate]             DATETIME         NULL,
    [TermToMaturity]           INT              NULL,
    [Guarantee]                TINYINT          NULL,
    [LoanTypeIndicator]        TINYINT          NULL,
    [Sector]                   NVARCHAR (255)   NULL
);

