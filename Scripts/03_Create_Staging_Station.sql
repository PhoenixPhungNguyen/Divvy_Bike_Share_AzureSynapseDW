-----------------------------
-- 5. Drop staging_station if it already exists
-----------------------------
IF OBJECT_ID('dbo.staging_station') IS NOT NULL
    DROP EXTERNAL TABLE dbo.staging_station;
GO

-----------------------------
-- 6. Create staging_station pointing directly to the CSV file inside raw container
-----------------------------
CREATE EXTERNAL TABLE dbo.staging_station
(
    station_id VARCHAR(50) COLLATE Latin1_General_100_CI_AS_SC_UTF8,
    name VARCHAR(150) COLLATE Latin1_General_100_CI_AS_SC_UTF8,
    latitude FLOAT,
    longitude FLOAT
)
WITH (
    LOCATION = 'public.station.csv',   -- direct CSV file
    DATA_SOURCE = MySource,
    FILE_FORMAT = SynapseDelimitedTextFormat
);
GO