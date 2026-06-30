SELECT
	SOH.SalesPersonID
	,PP.FirstName
	,PP.LastName
	,round(sum(SOH.TotalDue), 2) as [Total_Sales]
	,RANK() over (order by sum(SOH.TotalDue) desc) as [Sales_Rank]
	,DENSE_RANK() over (order by sum(SOH.TotalDue) desc) as [Sales_Dense_Rank]
FROM [AdventureWorks2019].[Sales].[SalesOrderHeader] SOH
  join [person].[person] PP
  on SOH.SalesPersonID = PP.BusinessEntityID
where SOH.SalesPersonID is not NULL
group by 
	SOH.SalesPersonID, PP.FirstName, PP.LastName
order by [Sales_Rank]

--the dataset had no tied revenues, but the query is built to handle ties correctly if they existed
--Conclusion - Linda Mitchell is the top Performing Sales REP