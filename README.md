# Data Warehouse Implementation with Medallion Architecture

## Overview
This project implements a **modern data warehouse** using SQL Server following the **Medallion Architecture** (Bronze-Silver-Gold layers). It demonstrates end-to-end ETL pipelines, data modeling with star schema, and SQL-based analytics for sales data from ERP & CRM systems.

### Key Features
- **3-Layer Architecture**:  
  - **Bronze**: Raw ingestion (source-system tables like `crm_cust_info`)  
  - **Silver**: Cleaned/standardized data with metadata columns  
  - **Gold**: Business-ready star schema (views like `dim_customer`, `fact_sales`)  
- **ETL Best Practices**: Bulk loading, error handling, stored procedures, and performance timing  
- **Data Quality Checks**: Null/duplicate detection, value standardization, business rule validation  
- **Dimensional Modeling**: Implemented fact & dimension tables for analytics  

---

## Credits & Attribution
- **Original Project Concept**: [Data With Baraa](https://datawithbaraa.substack.com/p/build-a-data-warehouse-from-scratch) by Baraa Khatib Salkini  
- **Notion Plan Reference**: [SQL Data Warehouse Project](https://thankful-pangolin-2ca.notion.site/SQL-Data-Warehouse-Project-16ed041640ef80489667cfe2f380b269) (Not owned by me)  
- **Implementation Guidance**: Followed walkthrough by Luke Yeo (MIT License)  

---

## Technical Highlights
### Data Architecture
| Layer       | Purpose                          | Example Tables/Views          |
|-------------|----------------------------------|-------------------------------|
| **Bronze**  | Raw CSV ingestion               | `erp_loc_a101`, `crm_prd_info`|
| **Silver**  | Data cleansing & standardization| `silver.crm_cust_info`        |
| **Gold**    | Star schema for analytics       | `dim_product`, `fact_sales`   |

### What I Learned
As a fresh graduate, this project helped me develop:  
- **ETL Pipeline Design**: From extraction (bulk inserts) to transformation (data quality rules)  
- **SQL Optimization**: Stored procedures with error handling (`TRY/CATCH`)  
- **Data Modeling**: Translating business needs into dimensional models  
- **Documentation**: Clear schema designs and naming conventions (e.g., `snake_case`)  

---

## Project Structure
DataWarehouse:
1) Bronze/ # Raw source tables (e.g., crm_sales_detail)
2) Silver/ # Cleaned tables with technical columns
3) Gold/ # Star schema views for reporting
4) Sripts/ # ETL SQL scripts
5) Documentation
---

## How to Reproduce
1. Download datasets from [Data With Baraa](https://datawithbaraa.substack.com)  
2. Execute SQL scripts in order:  
   - Bronze → Silver → Gold  
3. Connect Power BI to Gold layer views for analytics  

---

## Why This Matters for Job Hunting
This project showcases my ability to:  
✅ **Implement industry architectures** (Medallion, star schema)  
✅ **Solve real data issues** (e.g., marital → marital typo fix, negative sales validation)  
✅ **Bridge technical and business needs** via dimensional modeling  
✅ **Communicate clearly** with documentation and naming conventions  

---

*Note: This is my implementation of the original project concept.*  
**Connect with me:** [LinkedIn](https://linkedin.com/in/yourprofile) | [Portfolio](yourportfolio.link)  
