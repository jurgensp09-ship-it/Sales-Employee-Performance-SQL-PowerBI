WITH Monthly_Sales AS (
    SELECT
        DATEFROMPARTS(YEAR([OrderDate]), MONTH([OrderDate]), 1) AS Order_Month
        ,ROUND(SUM([TotalDue]), 2) AS Total_Sales
    FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]
    GROUP BY
        DATEFROMPARTS(YEAR([OrderDate]), MONTH([OrderDate]), 1)
)
SELECT
    Order_Month
    ,Total_Sales
    ,LAG(Total_Sales, 1) OVER (ORDER BY Order_Month) AS Previous_Month_Sales
    ,ROUND(Total_Sales - LAG(Total_Sales, 1) OVER (ORDER BY Order_Month), 2) AS MoM_Change
    ,ROUND(
        (Total_Sales - LAG(Total_Sales, 1) OVER (ORDER BY Order_Month))
        / LAG(Total_Sales, 1) OVER (ORDER BY Order_Month) * 100
    , 2) AS MoM_Change_Pct
FROM Monthly_Sales
ORDER BY Order_Month;


--Data runs from May 2011 through June 2014 — 38 months of trading history
--Row 1 shows NULL for all LAG columns — correct and expected, no prior month exists
--You can see massive volatility in some months — July 2011 jumps 352% MoM, October 2013 drops 26% — that's genuinely interesting and worth highlighting
--Row 38 (June 2014) shows -99.09% — that's almost certainly an incomplete month in the dataset, a classic data quality observation worth noting in your write-up

--That -99.09% at the end is a great real-world analyst observation. 
--In your write-up note something like: "June 2014 shows a near-complete revenue drop of -99%, 
--likely indicating an incomplete month in the dataset rather than an actual business event — 
--a data quality flag that would be raised with stakeholders before including this month in any trend analysis."