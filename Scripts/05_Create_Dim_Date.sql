-----------------------------
-- 6. Drop dim_date if it already exists
-----------------------------
IF OBJECT_ID('dbo.dim_date') IS NOT NULL
    DROP EXTERNAL TABLE dbo.dim_date;
GO
----------------------------------------
-- 6. Create dim_date directly using CETAS
----------------------------------------
CREATE EXTERNAL TABLE dbo.dim_date
WITH (
    LOCATION = 'dim/date/',
    DATA_SOURCE = ProcessedData,
    FILE_FORMAT = SynapseDelimitedTextFormat
)
AS
SELECT
    TRY_CAST(C1 AS INT) AS date_sk,
    TRY_CAST(C2 AS DATE) AS [date],
    TRY_CAST(C3 AS INT) AS [year],
    TRY_CAST(C4 AS INT) AS [quarter],
    TRY_CAST(C5 AS INT) AS [month],
    TRY_CAST(C6 AS INT) AS day_of_week,
    TRY_CAST(C7 AS INT) AS is_weekend
FROM
    OPENROWSET(
        BULK 'public.date.csv', --public.date.csv is created by Source/GenerateDimDate.py and copy into blobstorage 
        DATA_SOURCE = 'MySource',
        FORMAT = 'CSV',
        FIELDTERMINATOR = ',',
        STRING_DELIMITER = '"',
        FIRSTROW = 2,
        PARSER_VERSION = '2.0'
    ) AS rows;
GO
