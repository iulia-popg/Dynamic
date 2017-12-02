CREATE TABLE [dbo].[DimIncome] (
    [IncomeID]              INT              IDENTITY (1, 1) NOT NULL,
    [M_LoanID]              VARCHAR (100)    NOT NULL,
    [LTI]                   DECIMAL (28, 10) NULL,
    [BorrowerBirthDate_key] INT              NULL,
    [EmploymentStatus]      NVARCHAR (255)   NULL,
    [IndexedDTI]            DECIMAL (28, 10) NULL,
    PRIMARY KEY CLUSTERED ([IncomeID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_DimIncome]
    ON [dbo].[DimIncome]([M_LoanID] ASC);

