-----------------------------
-- 7. Drop dim_station if it already exists
-----------------------------
IF OBJECT_ID('dbo.dim_station') IS NOT NULL
    DROP EXTERNAL TABLE dbo.dim_station;
GO

-----------------------------
-- 8. Create dim_station using CETAS from staging_station
-----------------------------
CREATE EXTERNAL TABLE dbo.dim_station
WITH (
    LOCATION = 'dim/station/',       -- folder inside processed to store output files
    DATA_SOURCE = ProcessedData,
    FILE_FORMAT = SynapseDelimitedTextFormat
)
AS
SELECT
    ROW_NUMBER() OVER (ORDER BY station_id) AS station_sk,
    CAST(station_id AS VARCHAR(50)) COLLATE Latin1_General_100_CI_AS_SC_UTF8 AS station_id,
    CAST(name AS VARCHAR(150)) COLLATE Latin1_General_100_CI_AS_SC_UTF8 AS name,
    TRY_CAST(latitude AS FLOAT) AS latitude,
    TRY_CAST(longitude AS FLOAT) AS longitude
FROM dbo.staging_station;
GO