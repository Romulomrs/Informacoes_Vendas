SELECT  [ProductKey]
      ,[OrderDateKey]
      ,[DueDateKey]
      ,[ShipDateKey]
      ,[CustomerKey]
/*
      ,[PromotionKey]
      ,[CurrencyKey]
      ,[SalesTerritoryKey]
*/
      ,[SalesOrderNumber]
/*    ,[SalesOrderLineNumber]
      ,[RevisionNumber]
      ,[OrderQuantity]
      ,[UnitPrice]
      ,[ExtendedAmount]
      ,[UnitPriceDiscountPct]
      ,[DiscountAmount]
      ,[ProductStandardCost]
      ,[TotalProductCost]
*/
    ,[SalesAmount] as [Sales Amount]
/*      ,[TaxAmt]
      ,[Freight]
      ,[CarrierTrackingNumber]
      ,[CustomerPONumber]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
 */
  FROM [AdventureWorksDW2019].[dbo].[FactInternetSales]

WHERE OrderDateKey >= (YEAR(GETDATE()) - 2) * 10000 + 101
 
  ORDER BY
  OrderDateKey ASC