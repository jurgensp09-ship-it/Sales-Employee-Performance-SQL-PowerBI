With [Customer_Buyer] as (
SELECT
    [CustomerID]
    ,count([SalesOrderID]) as [Total_Orders]
,case
    when count([SalesOrderID]) > 10 then 'Frequent Buyer'
    when count([SalesOrderID]) > 1 then 'Occasional Buyer'
    else 'One-Time Buyer'
end as [Customer_Buyer_Tiers]
    
FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]
group by [CustomerID]
)
select
    [Customer_Buyer_Tiers]
    ,count([CustomerID]) as [Total_Customers]
from [Customer_Buyer]
group by [Customer_Buyer_Tiers]
order by [Total_Customers] desc
