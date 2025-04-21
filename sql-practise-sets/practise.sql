USE Practise_db
GO

SELECT * FROM 
(
    SELECT *, ROW_NUMBER() OVER(PARTITION BY salary ORDER BY salary DESC) as rnk
    FROM Emp 
) AS e
WHERE e.rnk = 2


WITH CTE AS (
    SELECT CAST('2025-01-01' AS DATE) AS Start_date
    UNION ALL 
    SELECT DATEADD(WEEK,1,Start_date) FROM CTE WHERE YEAR(Start_date) = 2025
)
SELECT * FROM CTE


