-- source CRM 
-- Following naming_conventions rule

-- This is to make it there if you put in a mistake when creating the table (the variable type or even name) , suppose to put before: for any/all table 
IF OBJECT_ID('Bronze.crm_cust_info', 'U') IS NOT NULL 
	DROP TABLE Bronze.crm_cust_info;

CREATE TABLE Bronze.crm_cust_info (
-- note: the name is followed with the dataset file given when open (1st line)
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_material_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_created_date DATE
);
-- Check that it has been created at the 'Tables' tab under Data Warehouse 

IF OBJECT_ID('Bronze.crm_prd_info', 'U') IS NOT NULL 
	DROP TABLE Bronze.crm_prd_info;
CREATE TABLE Bronze.crm_prd_info (
	prd_id INT,
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt DATETIME,
	prd_end_dt DATETIME
);

IF OBJECT_ID('Bronze.crm_sales_details', 'U') IS NOT NULL 
	DROP TABLE Bronze.crm_sales_details;
CREATE TABLE Bronze.crm_sales_details (
	 sls_ord_num NVARCHAR(50),
	 sls_prd_key NVARCHAR(50),
	 sls_cus_id INT,
	 sls_order_dt INT, 
	 sls_ship_dt INT,
	 sls_due_dt INT,
	 sls_sales INT,
	 sls_quantity INT,
	 sls_price INT
);

IF OBJECT_ID('Bronze.erp_loc_a101', 'U') IS NOT NULL 
	DROP TABLE Bronze.erp_loc_a101;
CREATE TABLE Bronze.erp_loc_a101(
	cid NVARCHAR(50),
	cntry NVARCHAR(50)
);

IF OBJECT_ID('Bronze.erp_cust_az12', 'U') IS NOT NULL 
	DROP TABLE Bronze.erp_cust_az12;
CREATE TABLE BRONZE.erp_cust_az12(
	cid NVARCHAR(50),
	bdate DATE,
	gen NVARCHAR(50)
); 

IF OBJECT_ID('Bronze.erp_px_cat_g1v2', 'U') IS NOT NULL 
	DROP TABLE Bronze.erp_px_cat_g1v2;
CREATE TABLE Bronze.erp_px_cat_g1v2(
	id NVARCHAR(50),
	cat NVARCHAR(50),
	subcat NVARCHAR(50),
	maintenance NVARCHAR(50)
);