----------------------------------------
-- 4. Drop staging_trip if it already exists
----------------------------------------
IF OBJECT_ID('dbo.staging_trip') IS NOT NULL
    DROP EXTERNAL TABLE dbo.staging_trip;
GO

----------------------------------------
-- 5. Create staging_trip pointing to CSV folder
----------------------------------------
CREATE EXTERNAL TABLE dbo.staging_trip
(
    trip_id VARCHAR(50),
    rideable_type VARCHAR(20),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_id VARCHAR(50),
    end_station_id VARCHAR(50),
    member_id INT
)
WITH (
    LOCATION = 'public.trip.csv',   -- folder containing CSV files
    DATA_SOURCE = MySource,
    FILE_FORMAT = SynapseDelimitedTextFormat
);
GO
