CREATE TABLE [dbo].[DimValuation] (
    [ValuationID]                    INT              IDENTITY (1, 1) NOT NULL,
    [M_LoanID]                       VARCHAR (100)    NOT NULL,
    [OriginalLTV]                    DECIMAL (28, 10) NULL,
    [IndexedLTFV]                    DECIMAL (28, 10) NULL,
    [distr_OriginationPropertyValue] VARCHAR (50)     NULL,
    [distr_IndexedLTFV]              VARCHAR (50)     NULL,
    PRIMARY KEY CLUSTERED ([ValuationID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_DimValuation]
    ON [dbo].[DimValuation]([M_LoanID] ASC);

