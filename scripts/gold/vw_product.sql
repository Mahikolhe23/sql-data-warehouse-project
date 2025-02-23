USE Datawarehouse
GO

CREATE OR ALTER VIEW gold.dim_products
AS
SELECT 
    ROW_NUMBER() OVER(ORDER BY prd_id) AS products_key, 
    pn.prd_id AS product_id,
    pn.prd_key AS product_key,
    pn.prd_nm As product_number,
    pn.cat_id AS category_id,
    pc.cat AS category,
    pc.subcat AS subcategory,
    pc.maintenance AS maintenance,
    pn.prd_cost AS product_cost,
    pn.prd_line AS product_line,
    pn.prd_start_dt AS product_standard_cost
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc ON pn.cat_id = pc.id 
WHERE prd_end_dt IS NULL

