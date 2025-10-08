/*
Script Purpose: 
    This script creates a new database named 'DataWarehouse' after checking if already exists. If it exists, it will be droped and recreated. It sets up three 
    schemas whithin the database: bronze, silver, and gold.
*/
-------------------------------------------------------


USE master;
GO
-- delete and recreate the 'DataWarehouse' database 
IF EXISTS (SELECT 1 FROM sys.database WHERE name = 'DataWarehouse')
  BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMEDIATE;
    DROP DATABASE DataWarehouse;
  END;

GO

  -- Create Databese 'Data Warehouse'
  
CREATE DATABASE DataWarehouse;
GO
USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
