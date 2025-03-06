USE Practise_db
GO

SELECT * FROM 
(
    SELECT *, ROW_NUMBER() OVER(PARTITION BY salary ORDER BY salary DESC) as rnk
FROM Emp 
) as e
WHERE e.rnk = 2

