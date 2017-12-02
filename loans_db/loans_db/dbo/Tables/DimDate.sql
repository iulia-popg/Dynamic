CREATE TABLE [dbo].[DimDate] (
    [DateKey]   INT      NOT NULL,
    [DateValue] DATETIME NULL,
    [year]      INT      NULL,
    PRIMARY KEY CLUSTERED ([DateKey] ASC)
);

