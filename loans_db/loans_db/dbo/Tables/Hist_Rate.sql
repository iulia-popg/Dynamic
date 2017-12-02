CREATE TABLE [dbo].[Hist_Rate] (
    [M_PoolID]            NVARCHAR (255)   NULL,
    [M_LoanID]            NVARCHAR (255)   NULL,
    [ReportDate]          DATETIME         NULL,
    [CurrentRateType]     NVARCHAR (255)   NULL,
    [CurrentInterestRate] DECIMAL (28, 10) NULL,
    [CurrentDTI]          DECIMAL (28, 10) NULL,
    [CurrentLTFV]         DECIMAL (28, 10) NULL,
    [HISTORY_Id]          NUMERIC (20)     NULL
);

