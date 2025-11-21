-----------------------------
-- 7. Drop fact_payment if it already exists
-----------------------------
IF OBJECT_ID('dbo.fact_payment') IS NOT NULL
    DROP EXTERNAL TABLE dbo.fact_payment;
GO

-----------------------------
-- 8. Create fact_payment using CTAS from staging_payment
-----------------------------
CREATE EXTERNAL TABLE dbo.fact_payment
WITH (
    LOCATION = 'fact/payment/',
    DATA_SOURCE = ProcessedData,
    FILE_FORMAT = SynapseDelimitedTextFormat
)
AS
SELECT
    p.payment_id,
    d.date_sk,
    r.rider_sk,
    CAST(p.amount AS FLOAT) AS amount
FROM dbo.staging_payment p
LEFT JOIN dbo.dim_date d
    ON p.payment_date = d.date
LEFT JOIN dbo.dim_rider r
    ON p.account_number = r.rider_id;   -- account_number = rider_id
GO