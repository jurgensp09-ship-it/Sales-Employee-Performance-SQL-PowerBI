with [Monthly_sales] as (
select 
	DATEFROMPARTS(year([orderdate]),month([orderdate]),1) as [Order_Month]
	,round(sum([TotalDue]),2) as [Total Sales]
from [Sales].[SalesOrderHeader]
group by DATEFROMPARTS(year([orderdate]),month([orderdate]),1)
)
select
	[Order_Month]
	,[Total Sales]
	,sum([Total Sales]) over (order by [Order_Month]) as [Cumulative_Sales]
from
	[Monthly_sales]
order by [Order_Month];