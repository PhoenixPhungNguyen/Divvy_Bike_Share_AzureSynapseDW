--0.Create Database
IF DB_ID('RawDataDB') IS NULL
BEGIN
    CREATE DATABASE RawDataDB;
END
GO

-- 1. Select the database
USE RawDataDB;
GO

-----------------------------
-- 2. Create External Data Source pointing to the raw container
-----------------------------
IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'MySource')
CREATE EXTERNAL DATA SOURCE MySource
WITH (
    LOCATION = 'abfss://raw@phoenixnguyensa.dfs.core.windows.net'
);
GO

-----------------------------
-- 3. Create External File Format for CSV (following Synapse guideline)
-----------------------------
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat')
CREATE EXTERNAL FILE FORMAT SynapseDelimitedTextFormat
WITH (
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS (
        FIELD_TERMINATOR = ',',
        STRING_DELIMITER = '"',
        USE_TYPE_DEFAULT = FALSE
    )
);
GO

-----------------------------
-- 4. Create External Data Source for the processed folder
-----------------------------
IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'ProcessedData')
CREATE EXTERNAL DATA SOURCE ProcessedData
WITH (
    LOCATION = 'https://phoenixnguyensa.dfs.core.windows.net/processed'
);
GO