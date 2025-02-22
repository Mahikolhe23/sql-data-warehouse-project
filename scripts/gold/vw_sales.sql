USE Datawarehouse
GO

CREATE OR ALTER VIEW gold.fact_sales 
AS 
SELECT 
    sd.sls_ord_num AS order_number,
    pr.products_key AS product_key,
    cr.customer_id AS customer_key,
    sd.sls_order_dt AS order_date,
    sd.sls_ship_dt AS ship_date,
    sd.sls_due_dt AS due_date, 
    sd.sls_sales AS sale_amount,
    sd.sls_quantity AS quantity,
    sd.sls_price AS price
    FROM silver.crm_sales_details sd
    LEFT JOIN gold.dim_products pr ON sd.sls_prd_key = pr.product_key
    LEFT JOIN gold.dim_customers cr ON sd.sls_cust_id = cr.customer_id

