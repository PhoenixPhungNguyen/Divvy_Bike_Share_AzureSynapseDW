-----------------------------
-- 7. Drop dim_rider if it already exists
-----------------------------
IF OBJECT_ID('dbo.dim_rider') IS NOT NULL
    DROP EXTERNAL TABLE dbo.dim_rider;
GO

-----------------------------
-- 8. Create dim_rider using CETAS from staging_rider
-----------------------------
CREATE EXTERNAL TABLE dbo.dim_rider
WITH (
    LOCATION = 'dim/rider/',       -- folder inside processed to store output files
    DATA_SOURCE = ProcessedData,
    FILE_FORMAT = SynapseDelimitedTextFormat
)
AS
SELECT
    ROW_NUMBER() OVER (ORDER BY rider_id) AS rider_sk,
    TRY_CAST(rider_id AS INT) AS rider_id,
    CAST(first AS VARCHAR(100)) COLLATE Latin1_General_100_CI_AS_SC_UTF8 AS first,
    CAST(last AS VARCHAR(100)) COLLATE Latin1_General_100_CI_AS_SC_UTF8 AS last,
    CAST(address AS VARCHAR(200)) COLLATE Latin1_General_100_CI_AS_SC_UTF8 AS address,
    TRY_CAST(birthday AS DATE) AS birthday,
    TRY_CAST(account_start_date AS DATE) AS account_start_date,
    TRY_CAST(account_end_date AS DATE) AS account_end_date,
    CASE WHEN member = 1 THEN 'Member' ELSE 'Non-Member' END AS member_status
FROM dbo.staging_rider;
GO