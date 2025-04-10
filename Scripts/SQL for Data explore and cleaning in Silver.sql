-- Exploring and Cleaning of datasets 

-- CRM_CUST_INFO
SELECT * FROM Bronze.crm_cust_info; 
--check for null or duplicates in primary key
SELECT cst_id , COUNT(*) FROM Bronze.crm_cust_info GROUP BY cst_id HAVING COUNT(*) > 1 OR cst_id is NULL;

-- Check on the info of the result: 
SELECT * FROM Bronze.crm_cust_info WHERE cst_id = 29466;

-- have 3 different result ^ , see the date , there is each on different day , so we pick the highest one as it is the latest 
-- so what we can do is create a flagship for each cst_id 
-- because of DESC, we just need to look at those with flagship = 1 
SELECT *, ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_created_date DESC) as flag_last
FROM Bronze.crm_cust_info;

--Checking for unwanted sapces in string values 
--Expectation: no results
SELECT cst_firstname FROM Bronze.crm_cust_info WHERE cst_firstname != TRIM(cst_firstname); --check per column

SELECT cst_id, TRIM(cst_firstname) AS cst_firstname, TRIM(cst_lastname) AS cst_lastname, cst_material_status, cst_gndr, cst_created_date
FROM 
	(
	SELECT *, ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_created_date DESC) as flag_last
	FROM Bronze.crm_cust_info 
	WHERE cst_id IS NOT NULL
	)t --this t is to continue the query for WHERE
WHERE flag_last = 1; 

-- Checking for consistency
SELECT DISTINCT cst_gndr FROM Bronze.crm_cust_info;

-- Change F to Female , M to Male , Null to N/A
SELECT cst_id , cst_key, TRIM(cst_firstname) AS cst_firstname, TRIM(cst_lastname) AS cst_lastname, 
	CASE WHEN UPPER(TRIM(cst_material_status)) = 'S' THEN 'Single'
	WHEN UPPER(TRIM(cst_material_status)) = 'M' THEN 'Married'
	ELSE 'N/A'
	END cst_material_status,

	CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
	WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
	ELSE 'N/A'
	END cst_gndr, cst_created_date
FROM (
	SELECT *, ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_created_date DESC) as flag_last
	FROM Bronze.crm_cust_info 
	WHERE cst_id IS NOT NULL
	)t
WHERE flag_last = 1; 

-- CRM.PRD_INFO
SELECT * FROM Bronze.crm_prd_info;
--Check for Nulls or duplicates in Primary Key
SELECT prd_id, COUNT(*) FROM Bronze.crm_prd_info GROUP BY prd_id HAVING COUNT(*) >1 OR prd_id IS NULL;
-- result is "no column name" , so no duplicate

-- Substring for pred_key so that it isnt confusing : categoryID and ProductKey 
-- we need the '_' instead of '-' to ensure it stays consistant with crm_cust_info 
-- Change all short form to the entirely correct naming : M-> Mountain , ect  (usually, we ask someone else to get the name)
-- Null value for the prd_cost 
-- the start and end date is quite confusing to look at so lets fix it 
-- to ensure there is a order to each date as we go down the dataset (order by starting date) 
SELECT prd_id,
	REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id, -- category ID
	SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key,        -- product key
	prd_nm,
	ISNULL(prd_cost, 0) AS prd_cost, --replace null as 0 
	CASE 
		WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
		WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
		WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
		WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
		ELSE 'n/a'
		END AS prd_line, -- Map product line codes to descriptive values
		CAST(prd_start_dt AS DATE) AS prd_start_dt,
		CAST(
			LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) - 1 
			AS DATE
			) AS prd_end_dt -- Calculate end date as one day before the next start date
FROM bronze.crm_prd_info;

-- CRM_SALES_DETAILS

-- checking to ensure all the details are there 
SELECT sls_ord_num, sls_prd_key, sls_cus_id, sls_order_dt, 
	   sls_ship_dt, sls_due_dt, sls_sales, sls_quantity, sls_price
FROM Bronze.crm_sales_details
WHERE sls_prd_key NOT IN (SELECT prd_key FROM Silver.crm_prd_info);

-- Cleaning of the data
-- Changing the columns with dt (date) into actual date value/format than NVARCHAR or INT 
-- use math 2010|12|29 , 8 numbers
-- the sales , quantity and price are all connected to each other . so use basic math to check on if all of them match correctly
SELECT 
		sls_ord_num,
		sls_prd_key,
		sls_cus_id,
		CASE 
			WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL
			ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE) -- change to varchar than to date
		END AS sls_order_dt,
		CASE 
			WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) != 8 THEN NULL
			ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
		END AS sls_ship_dt,
		CASE 
			WHEN sls_due_dt = 0 OR LEN(sls_due_dt) != 8 THEN NULL
			ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
		END AS sls_due_dt,
		CASE 
		-- Recalculate sales if original value is missing or incorrect
			WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price) 
				THEN sls_quantity * ABS(sls_price)
			ELSE sls_sales
		END AS sls_sales, 
		sls_quantity, --DO NOT CHANGE QUANTITY 
		CASE 
		-- Derive price if original value is invalid
			WHEN sls_price IS NULL OR sls_price <= 0 
				THEN sls_sales / NULLIF(sls_quantity, 0)
			ELSE sls_price  
		END AS sls_price
FROM bronze.crm_sales_details;

-- ERP_CUST_AZ12

--
SELECT cid,bdate,gen FROM Bronze.erp_cust_az12;
SELECT * FROM [Silver].[crm_cust_info]; -- if this is empty , it is because i have not load a single data onto silver , we are still cleaning the data

-- cst_key has additional letters so transform it by extracting it using substring
-- 

SELECT
		CASE
			WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid)) -- Remove 'NAS' to connect to other keys 
			ELSE cid
		END AS cid, 
		CASE
			WHEN bdate > GETDATE() THEN NULL
			ELSE bdate
		END AS bdate, -- Set future birthdates to NULL
		CASE
			WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
			WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
			ELSE 'n/a'
		END AS gen -- Normalize gender values and handle unknown cases
FROM bronze.erp_cust_az12;

-- ERP_LOC_A101
-- There is a '-' sign , cid vs cst_key . need to standardize 
-- Chang shortforms to normal 
SELECT
	REPLACE(cid, '-', '') AS cid, 
	CASE
		WHEN TRIM(cntry) = 'DE' THEN 'Germany'
		WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
		WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
		ELSE TRIM(cntry)
		END AS cntry 
FROM bronze.erp_loc_a101;


--ERP_PX_AT_G1V2 (THERE IS NO DATA STUFF)
SELECT id,cat,subcat,maintenance FROM Bronze.erp_px_cat_g1v2;
-- Check for Unwanted space
SELECT * FROM Bronze.erp_px_cat_g1v2
WHERE cat!= TRIM(cat) OR subcat != TRIM(subcat) or maintenance != TRIM(maintenance);
-- Check for Consistency , no nulls ,ect 
SELECT DISTINCT maintenance FROM Bronze.erp_px_cat_g1v2; --change the column and test all out 