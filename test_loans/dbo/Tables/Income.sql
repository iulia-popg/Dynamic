CREATE TABLE [dbo].[Income] (
    [M_PoolID]                 NVARCHAR (255)   NULL,
    [M_LoanID]                 NVARCHAR (255)   NULL,
    [DTI]                      DECIMAL (28, 10) NULL,
    [LTI]                      DECIMAL (28, 10) NULL,
    [SelfCertification]        NVARCHAR (255)   NULL,
    [EmploymentStatus]         NVARCHAR (255)   NULL,
    [TotalIncome]              DECIMAL (28, 10) NULL,
    [BorrowerBirthDate]        DATETIME         NULL,
    [IndexedDTI]               DECIMAL (28, 10) NULL,
    [IndexedLTI]               DECIMAL (28, 10) NULL,
    [IndexedTotalIncome]       DECIMAL (28, 10) NULL,
    [MaxBorrowerIncome]        DECIMAL (28, 10) NULL,
    [BorrowerTotalIncome]      DECIMAL (28, 10) NULL,
    [LivingExpenses]           DECIMAL (28, 10) NULL,
    [CurrentInterestShock]     DECIMAL (28, 10) NULL,
    [MonthlyNetIncome]         DECIMAL (28, 10) NULL,
    [MonthlyMortgageInterest]  DECIMAL (28, 10) NULL,
    [MonthlyMortgagePrincipal] DECIMAL (28, 10) NULL,
    [MonthlyIncomeBuffer]      DECIMAL (28, 10) NULL,
    [MASTER_Id]                VARCHAR (100)    NULL
);

