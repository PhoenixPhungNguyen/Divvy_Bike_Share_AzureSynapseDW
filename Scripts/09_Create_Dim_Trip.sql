
-----------------------------
-- 7. Drop fact_trip if it already exists
-----------------------------
IF OBJECT_ID('dbo.fact_trip') IS NOT NULL
    DROP EXTERNAL TABLE dbo.fact_trip;
GO

-----------------------------
-- 8. Create fact_trip using CTAS
-----------------------------
CREATE EXTERNAL TABLE dbo.fact_trip
WITH (
    LOCATION = 'fact/trip',
    DATA_SOURCE = ProcessedData,
    FILE_FORMAT = SynapseDelimitedTextFormat
)
AS
SELECT
    ROW_NUMBER() OVER (ORDER BY t.trip_id) AS trip_sk,
    t.trip_id,
    s_start.station_sk AS start_station,
    s_end.station_sk AS end_station,
    r.rider_sk,
    d.date_sk AS date_sk,
    t.started_at,
    t.ended_at,
    t.rideable_type
FROM dbo.staging_trip t
JOIN dbo.dim_rider r 
    ON t.member_id = r.rider_id
JOIN dbo.dim_station s_start 
    ON t.start_station_id = s_start.station_id
JOIN dbo.dim_station s_end 
    ON t.end_station_id = s_end.station_id
JOIN dbo.dim_date d 
    ON CAST(t.started_at AS DATE) = d.date;
GO