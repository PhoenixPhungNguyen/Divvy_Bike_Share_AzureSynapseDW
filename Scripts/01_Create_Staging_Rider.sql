-----------------------------
-- 5. Drop staging_rider if it already exists
-----------------------------
IF OBJECT_ID('dbo.staging_rider') IS NOT NULL
    DROP EXTERNAL TABLE dbo.staging_rider;
GO

-----------------------------
-- 6. Create staging_rider pointing directly to the CSV file inside raw container
-----------------------------
CREATE EXTERNAL TABLE dbo.staging_rider
(
    rider_id INT,
    first VARCHAR(100) COLLATE Latin1_General_100_CI_AS_SC_UTF8,
    last VARCHAR(100) COLLATE Latin1_General_100_CI_AS_SC_UTF8,
    address VARCHAR(200) COLLATE Latin1_General_100_CI_AS_SC_UTF8,
    birthday DATE,
    account_start_date DATE,
    account_end_date DATE,
    member BIT
)
WITH (
    LOCATION = 'public.rider.csv',   -- direct CSV file
    DATA_SOURCE = MySource,
    FILE_FORMAT = SynapseDelimitedTextFormat
);
GO

