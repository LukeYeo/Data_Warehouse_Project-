CREATE OR ALTER PROCEDURE Bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY 
		PRINT 'Loading Bronze layer' 
		PRINT '======================================================================================================================================================' 
		SET @start_time = GETDATE();
		PRINT 'Loading Bronze.crm_cust_info ' 
		-- Bronze.crm_cust_info;
		TRUNCATE TABLE Bronze.crm_cust_info;
		BULK INSERT Bronze.crm_cust_info
		FROM 'C:\Users\Luke Yeo\Desktop\Database and SQL Projects\Building DataWarehouse (Data with Baraa)\Data Warehouse Project\datasets\source_crm\cust_info.csv'
		WITH (
		-- note for this , the data starts at the 2nd row ! , the 1st row is the header:
			FIRSTROW = 2,
		-- the values are seperated by ',':
			FIELDTERMINATOR = ',',
		-- to lock the data when its being transferred 
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		-- check insertion of data is correct , can do count() and other things if you want to be specific  . do note that the reader is not counted !! 
		SELECT * FROM Bronze.crm_cust_info;

		-- Bronze.crm_prd_info
		TRUNCATE TABLE Bronze.crm_prd_info;
		BULK INSERT Bronze.crm_prd_info
		FROM 'C:\Users\Luke Yeo\Desktop\Database and SQL Projects\Building DataWarehouse (Data with Baraa)\Data Warehouse Project\datasets\source_crm\prd_info.csv'
		WITH (
		-- note for this , the data starts at the 2nd row ! , the 1st row is the header:
			FIRSTROW = 2,
		-- the values are seperated by ',':
			FIELDTERMINATOR = ',',
		-- to lock the data when its being transferred 
			TABLOCK
		);

		-- check insertion of data is correct , can do count() and other things if you want to be specific  . do note that the reader is not counted !! 
		SELECT * FROM Bronze.crm_prd_info;

		-- Bronze.crm_sales_details
		TRUNCATE TABLE Bronze.crm_sales_details;
		BULK INSERT Bronze.crm_sales_details
		FROM 'C:\Users\Luke Yeo\Desktop\Database and SQL Projects\Building DataWarehouse (Data with Baraa)\Data Warehouse Project\datasets\source_crm\sales_details.csv'
		WITH (
		-- note for this , the data starts at the 2nd row ! , the 1st row is the header:
			FIRSTROW = 2,
		-- the values are seperated by ',':
			FIELDTERMINATOR = ',',
		-- to lock the data when its being transferred 
			TABLOCK
		);

		-- check insertion of data is correct , can do count() and other things if you want to be specific  . do note that the reader is not counted !! 
		SELECT * FROM Bronze.crm_sales_details;


		-- Bronze.erp_loc_a101
		TRUNCATE TABLE Bronze.erp_loc_a101;
		BULK INSERT Bronze.erp_loc_a101
		FROM 'C:\Users\Luke Yeo\Desktop\Database and SQL Projects\Building DataWarehouse (Data with Baraa)\Data Warehouse Project\datasets\source_erp\loc_a101.csv'
		WITH (
		-- note for this , the data starts at the 2nd row ! , the 1st row is the header:
			FIRSTROW = 2,
		-- the values are seperated by ',':
			FIELDTERMINATOR = ',',
		-- to lock the data when its being transferred 
			TABLOCK
		);

		-- check insertion of data is correct , can do count() and other things if you want to be specific  . do note that the reader is not counted !! 
		SELECT * FROM Bronze.erp_loc_a101;

		-- Bronze.erp_cust_az12
		TRUNCATE TABLE Bronze.erp_cust_az12;
		BULK INSERT Bronze.erp_cust_az12
		FROM 'C:\Users\Luke Yeo\Desktop\Database and SQL Projects\Building DataWarehouse (Data with Baraa)\Data Warehouse Project\datasets\source_erp\cust_az12.csv'
		WITH (
		-- note for this , the data starts at the 2nd row ! , the 1st row is the header:
			FIRSTROW = 2,
		-- the values are seperated by ',':
			FIELDTERMINATOR = ',',
		-- to lock the data when its being transferred 
			TABLOCK
		);

		-- check insertion of data is correct , can do count() and other things if you want to be specific  . do note that the reader is not counted !! 
		SELECT * FROM Bronze.erp_cust_az12;

		-- Bronze.erp_px_cat_g1v2
		TRUNCATE TABLE Bronze.erp_px_cat_g1v2;
		BULK INSERT Bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Luke Yeo\Desktop\Database and SQL Projects\Building DataWarehouse (Data with Baraa)\Data Warehouse Project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
		-- note for this , the data starts at the 2nd row ! , the 1st row is the header:
			FIRSTROW = 2,
		-- the values are seperated by ',':
			FIELDTERMINATOR = ',',
		-- to lock the data when its being transferred 
			TABLOCK
		);

		-- check insertion of data is correct , can do count() and other things if you want to be specific  . do note that the reader is not counted !! 
		SELECT * FROM Bronze.erp_px_cat_g1v2;
	END TRY
	BEGIN CATCH
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR NUMBER' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR NUMBER' + CAST(ERROR_STATE() AS NVARCHAR);
	END CATCH
END

-- You can execute the this whole procedure by going to a new query and type:
-- PLEASE DO THIS EVERYIME YOU NEED TO LOAD IN DATA
-- EXEC Bronze.load_bronze