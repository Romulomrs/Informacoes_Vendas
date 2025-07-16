SELECT
	   c.CustomerKey as CustomerKey,

      --,[CustomerAlternateKey]
      --,[Title]
      c.firstname as [FirstName],
      --,[MiddleName]
      c.lastname as [LastName],
	  c.firstname + ' ' + LastName as [Full Name],
/*    ,[NameStyle]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Suffix]
*/
      case c.gender when 'M' then 'Male' when 'F' then 'Female' end as [Gender],
/*      ,[EmailAddress]
      ,[YearlyIncome]
      ,[TotalChildren]
      ,[NumberChildrenAtHome]
      ,[EnglishEducation]
      ,[SpanishEducation]
      ,[FrenchEducation]
      ,[EnglishOccupation]
      ,[SpanishOccupation]
      ,[FrenchOccupation]
      ,[HouseOwnerFlag]
      ,[NumberCarsOwned]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[Phone]
*/
      c.datefirstpurchase as [DateFirstPurchase],
      --,[CommuteDistance]
	  g.city as [Customer City]
  FROM [AdventureWorksDW2019].[dbo].[DimCustomer] as c
  left join AdventureWorksDW2019.dbo.dimgeography as g on g.GeographyKey = c.GeographyKey
  order by CustomerKey asc
