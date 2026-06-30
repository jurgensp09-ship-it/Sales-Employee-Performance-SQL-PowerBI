WITH Product_Sales AS (
    SELECT
        PP.Name AS Product_Name
        ,ISNULL(PC.Name, 'Uncategorised') AS Category_Name
        ,ROUND(SUM(SOD.LineTotal), 2) AS Total_Sales
    FROM [Sales].[SalesOrderHeader] SOH
        JOIN [Sales].[SalesOrderDetail] SOD
            ON SOH.SalesOrderID = SOD.SalesOrderID
        JOIN [Production].[Product] PP
            ON SOD.ProductID = PP.ProductID
        LEFT JOIN [Production].[ProductSubcategory] PSUB
            ON PP.ProductSubcategoryID = PSUB.ProductSubcategoryID
        LEFT JOIN [Production].[ProductCategory] PC
            ON PSUB.ProductCategoryID = PC.ProductCategoryID
    GROUP BY PP.Name, PC.Name
)
SELECT
    Category_Name
    ,Product_Name
    ,Total_Sales
    ,ROW_NUMBER() OVER (PARTITION BY Category_Name ORDER BY Total_Sales DESC) AS Rank_In_Category
FROM Product_Sales
ORDER BY Category_Name, Rank_In_Category;