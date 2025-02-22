/*

==============================================================================
Create Database and schemas
==============================================================================
Script purpose:
    This script is use to create Datawarehouse DB and Schemas bronze, silver, gold

*/

BEGIN TRANSACTION;
GO

USE master;
GO

-- Drop and recreate Datawarehouse DB
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Datawarehouse')
BEGIN
    ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Datawarehouse;
END;
GO

-- Create DB Datawarehouse
CREATE DATABASE Datawarehouse;
GO

USE Datawarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO

COMMIT;
