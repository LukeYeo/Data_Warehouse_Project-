
/*
WARNING !!:

This script purpose is to create a new database and if there is an existing database , the old one will be dropped and creating a new one 
with the intended schema so all old data will be deleted too 
*/
-- Note , i did not use this method , instead i use the right click using the object explorer tab 

USE master;
GO 

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
Begin 
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
END; 
GO

Create DATABASE DataWarehouse;
GO
USE DataWarehouse;
GO

-- Create the bronze , silver , gold schema; 
Create SCHEMA Bronze; -- go to security and check if the schema is there after refreshing 
GO
Create SCHEMA Silver;
GO
Create SCHEMA Gold;
GO
--