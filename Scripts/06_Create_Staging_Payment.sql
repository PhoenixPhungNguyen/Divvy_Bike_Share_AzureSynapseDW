----------------------------------------
-- 5. Drop staging_payment if it already exists
----------------------------------------
IF OBJECT_ID('dbo.staging_payment') IS NOT NULL
    DROP EXTERNAL TABLE dbo.staging_payment;
GO

----------------------------------------
-- 6. Create staging_payment pointing directly to the CSV file inside raw container
----------------------------------------
CREATE EXTERNAL TABLE dbo.staging_payment
(
    payment_id INT,
    payment_date DATE,
    amount DECIMAL(10,2),
    account_number INT
)
WITH (
    LOCATION = 'public.payment.csv',
    DATA_SOURCE = MySource,
    FILE_FORMAT = SynapseDelimitedTextFormat
);
GO
