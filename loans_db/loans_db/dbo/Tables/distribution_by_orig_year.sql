CREATE TABLE [dbo].[distribution_by_orig_year] (
    [ReportDate]                     DATETIME        NULL,
    [distr_OriginationPropertyValue] VARCHAR (15)    NULL,
    [wa_OriginalPrincipalBalance]    DECIMAL (38, 6) NULL,
    [wa_DTI]                         DECIMAL (38, 6) NULL,
    [wa_LTI]                         DECIMAL (38, 6) NULL,
    [wa_TotalIncome]                 DECIMAL (38, 6) NULL,
    [wa_IndexedDTI]                  DECIMAL (38, 6) NULL,
    [wa_IndexedLTI]                  DECIMAL (38, 6) NULL,
    [wa_IndexedTotalIncome]          DECIMAL (38, 6) NULL,
    [wa_CurrentInterestRate]         DECIMAL (38, 6) NULL,
    [wa_OriginalLTV]                 DECIMAL (38, 6) NULL,
    [wa_OriginalLTFV]                DECIMAL (38, 6) NULL,
    [wa_OriginalForeclosureValue]    DECIMAL (38, 6) NULL,
    [wa_IndexedLTFV]                 DECIMAL (38, 6) NULL
);

