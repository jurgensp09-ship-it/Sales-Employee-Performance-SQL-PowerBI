select
(select
	round(sum([TotalDue]),2) as [Total-Revenue]
from [Sales].[SalesOrderHeader]) as [Tot_Revenue]

,(select
	count(distinct[SalesOrderID]) as [Total_Orders]
from [Sales].[SalesOrderHeader]) as [Tot_Orders]

,(select
	count(distinct[CustomerID]) as [Total_Customers]
from [Sales].[SalesOrderHeader]) as [Tot_Customers]

,(select
	round(avg([TotalDue]),2) as [Average_Order]
from [Sales].[SalesOrderHeader]) as [AVG_per_Order]

,(SELECT top (1)
	PP.FirstName + ' '  + PP.LastName as [Sales_Rep]
FROM [AdventureWorks2019].[Sales].[SalesOrderHeader] SOH
  join [person].[person] PP
  on SOH.SalesPersonID = PP.BusinessEntityID
where SOH.SalesPersonID is not NULL
group by 
	SOH.SalesPersonID, PP.FirstName, PP.LastName
order by sum(SOH.[TotalDue]) desc) as [Top_Sales_Rep]