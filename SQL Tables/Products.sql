SELECT  p.[ProductKey]

      ,p.[ProductAlternateKey] as ProductItemCode
/*
      ,[ProductSubcategoryKey]
      ,[WeightUnitMeasureCode]
      ,[SizeUnitMeasureCode]
*/
      ,p.[EnglishProductName] as [Product Name]
	,ps.EnglishProductSubcategoryName as [Sub Category]
	,pc.EnglishProductCategoryName as [Product Category]

/*      ,[SpanishProductName]
      ,[FrenchProductName]
      ,[StandardCost]
      ,[FinishedGoodsFlag]
*/
      ,p.[Color] as [Product Color]
/*
      ,[SafetyStockLevel]
      ,[ReorderPoint]
      ,[ListPrice]
*/

      ,p.[Size] as [Product size]
/*    ,[SizeRange]
      ,[Weight]
      ,[DaysToManufacture]
*/
      ,p.[ProductLine] as [Product Line]
/*      ,[DealerPrice]
      ,[Class]
      ,[Style]
*/
      ,p.[ModelName] as [Product Model Name]
      --,[LargePhoto]
      ,p.[EnglishDescription] as [Product Description],
/*      ,[FrenchDescription]
      ,[ChineseDescription]
      ,[ArabicDescription]
      ,[HebrewDescription]
      ,[ThaiDescription]
      ,[GermanDescription]
      ,[JapaneseDescription]
      ,[TurkishDescription]
      ,[StartDate]
      ,[EndDate]
*/
      ISNULL(p.Status, 'Outdated') as  [ Product  Status]
  FROM [AdventureWorksDW2019].[dbo].[DimProduct] AS p
left join AdventureWorksDW2019.dbo.dimProductSubCategory as ps on ps.ProductSubCategoryKey = p.ProductSubCategoryKey
left join AdventureWorksDW2019.dbo.DimProductCategory as pc on ps.ProductCategoryKey = pc.ProductCategoryKey

order by p.ProductKey asc