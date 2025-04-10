-- This is to create views for the Gold Layer . Do take note that for the Gold layer , we should also do testing 

IF OBJECT_ID('Gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW Gold.dim_customers;
GO

-- THIS VIEW IS FOR Gold CUSTOMERS 
CREATE VIEW Gold.dim_customers AS
SELECT
    ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key, -- surrogate key , is a new primary key for this specific view
														 -- use the Row_Number() function to make a surrogate key
	-- Remembr is a view and joinings , we will need to rename the columns
    ci.cst_id AS customer_id,
    ci.cst_key AS customer_number,
    ci.cst_firstname AS first_name,
    ci.cst_lastname  AS last_name,
    la.cntry AS country,
    ci.cst_material_status AS marital_status,
    CASE 
        WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr -- CRM is the primary source for gender so we use value from there 
        ELSE COALESCE(ca.gen, 'n/a')  			   -- Fallback to ERP data , 
												   -- this is because afterwards , we have 2 gender column in diff name and may have diff values
    END                                AS gender,
    ca.bdate                           AS birthdate,
    ci.cst_created_date                 AS create_date
FROM Silver.crm_cust_info ci
-- to know which table join , look at 'Relations of Tables and Info:' in document 
LEFT JOIN Silver.erp_cust_az12 ca -- always use left join , to ensure you are using the Master Table
    ON ci.cst_key = ca.cid
LEFT JOIN Silver.erp_loc_a101 la
    ON ci.cst_key = la.cid;
GO

-- THIS IS FOR Gold PRODUCTS
IF OBJECT_ID('Gold.dim_products', 'V') IS NOT NULL
    DROP VIEW Gold.dim_products;
GO

CREATE VIEW Gold.dim_products AS
SELECT
    ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key, -- Surrogate key
    pn.prd_id       AS product_id,
    pn.prd_key      AS product_number,
    pn.prd_nm       AS product_name,
    pn.cat_id       AS category_id,
    pc.cat          AS category,
    pc.subcat       AS subcategory,
    pc.maintenance  AS maintenance,
    pn.prd_cost     AS cost,
    pn.prd_line     AS product_line,
    pn.prd_start_dt AS start_date
FROM Silver.crm_prd_info pn
LEFT JOIN Silver.erp_px_cat_g1v2 pc
    ON pn.cat_id = pc.id
WHERE pn.prd_end_dt IS NULL; -- Filter out all historical data
GO

-- THIS VIEW IS FOR Gold SALES
IF OBJECT_ID('Gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW Gold.fact_sales;
GO

CREATE VIEW Gold.fact_sales AS
SELECT
    sd.sls_ord_num  AS order_number,
    pr.product_key  AS product_key,
    cu.customer_key AS customer_key,
    sd.sls_order_dt AS order_date,
    sd.sls_ship_dt  AS shipping_date,
    sd.sls_due_dt   AS due_date,
    sd.sls_sales    AS sales_amount,
    sd.sls_quantity AS quantity,
    sd.sls_price    AS price
FROM Silver.crm_sales_details sd
LEFT JOIN Gold.dim_products pr
    ON sd.sls_prd_key = pr.product_number
LEFT JOIN Gold.dim_customers cu
    ON sd.sls_cus_id = cu.customer_id;
GO