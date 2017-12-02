﻿USE [test_loans]
GO

/****** Object: Table [dbo].[Valuation] Script Date: 11/29/2017 12:58:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE [dbo].[Valuation];


GO
CREATE TABLE [dbo].[Valuation] (
    [M_PoolID]                        NVARCHAR (255)   NULL,
    [M_LoanID]                        NVARCHAR (255)   NULL,
    [OriginalPropertyValue]           DECIMAL (28, 10) NULL,
    [PropertyValuationDate]           DATETIME         NULL,
    [OriginalLTV]                     DECIMAL (28, 10) NULL,
    [OriginalLTFV]                    DECIMAL (28, 10) NULL,
    [OriginalForeclosureValue]        DECIMAL (28, 10) NULL,
    [IndexedLTFV]                     DECIMAL (28, 10) NULL,
    [CurrentForeclosureValue]         DECIMAL (28, 10) NULL,
    [CurrentPropertyValue]            DECIMAL (28, 10) NULL,
    [CurrentNetPropertyValue]         DECIMAL (28, 10) NULL,
    [ForeclosureResidualDebtEstimate] DECIMAL (28, 10) NULL,
    [LoanLossEstimate]                DECIMAL (28, 10) NULL,
    [LoanPrice]                       DECIMAL (28, 10) NULL,
    [MASTER_Id]                       VARCHAR (100)    NULL
);


