CREATE TABLE [dbo].[Securitization] (
    [M_PoolID]               NVARCHAR (255)   NULL,
    [M_LoanID]               NVARCHAR (255)   NULL,
    [LifetimeBasePD]         DECIMAL (28, 10) NULL,
    [LifetimeBasePDOverride] DECIMAL (28, 10) NULL,
    [Multiple_NEW]           DECIMAL (28, 10) NULL,
    [LifetimeBasePPOverride] DECIMAL (28, 10) NULL,
    [MASTER_Id]              VARCHAR (100)    NULL
);

