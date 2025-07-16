DECLARE @datelist TABLE (FullDate DATE);

WITH DateGenerator AS (
    SELECT CAST('2015-01-01' AS DATE) AS FullDate
    UNION ALL
    SELECT DATEADD(DAY, 1, FullDate)
    FROM DateGenerator
    WHERE FullDate < '2025-12-31'
)
INSERT INTO @datelist
SELECT FullDate FROM DateGenerator
OPTION (MAXRECURSION 0);

INSERT INTO [AdventureWorksDW2019].[dbo].[DimDate] (
    DateKey,
    FullDateAlternateKey,
    DayNumberOfWeek,
    EnglishDayNameOfWeek,
    SpanishDayNameOfWeek,
    FrenchDayNameOfWeek,
    DayNumberOfMonth,
    DayNumberOfYear,
    WeekNumberOfYear,
    EnglishMonthName,
    SpanishMonthName,
    FrenchMonthName,
    MonthNumberOfYear,
    CalendarQuarter,
    CalendarYear,
    CalendarSemester,
    FiscalQuarter,
    FiscalYear,
    FiscalSemester
)
SELECT
    CONVERT(INT, CONVERT(VARCHAR, dl.FullDate, 112)) AS DateKey,
    dl.FullDate AS FullDateAlternateKey,
    DATEPART(WEEKDAY, dl.FullDate) AS DayNumberOfWeek,
    DATENAME(WEEKDAY, dl.FullDate) AS EnglishDayNameOfWeek,
    CASE DATENAME(WEEKDAY, dl.FullDate)
        WHEN 'Monday' THEN 'Lunes'
        WHEN 'Tuesday' THEN 'Martes'
        WHEN 'Wednesday' THEN 'Miércoles'
        WHEN 'Thursday' THEN 'Jueves'
        WHEN 'Friday' THEN 'Viernes'
        WHEN 'Saturday' THEN 'Sábado'
        WHEN 'Sunday' THEN 'Domingo'
        ELSE 'Desconocido'
    END AS SpanishDayNameOfWeek,
    CASE DATENAME(WEEKDAY, dl.FullDate)
        WHEN 'Monday' THEN 'Lundi'
        WHEN 'Tuesday' THEN 'Mardi'
        WHEN 'Wednesday' THEN 'Mercredi'
        WHEN 'Thursday' THEN 'Jeudi'
        WHEN 'Friday' THEN 'Vendredi'
        WHEN 'Saturday' THEN 'Samedi'
        WHEN 'Sunday' THEN 'Dimanche'
        ELSE 'Inconnu'
    END AS FrenchDayNameOfWeek,
    DAY(dl.FullDate) AS DayNumberOfMonth,
    DATEPART(DAYOFYEAR, dl.FullDate) AS DayNumberOfYear,
    DATEPART(WEEK, dl.FullDate) AS WeekNumberOfYear,
    DATENAME(MONTH, dl.FullDate) AS EnglishMonthName,
    CASE DATENAME(MONTH, dl.FullDate)
        WHEN 'January' THEN 'Enero'
        WHEN 'February' THEN 'Febrero'
        WHEN 'March' THEN 'Marzo'
        WHEN 'April' THEN 'Abril'
        WHEN 'May' THEN 'Mayo'
        WHEN 'June' THEN 'Junio'
        WHEN 'July' THEN 'Julio'
        WHEN 'August' THEN 'Agosto'
        WHEN 'September' THEN 'Septiembre'
        WHEN 'October' THEN 'Octubre'
        WHEN 'November' THEN 'Noviembre'
        WHEN 'December' THEN 'Diciembre'
        ELSE 'Desconocido'
    END AS SpanishMonthName,
    CASE DATENAME(MONTH, dl.FullDate)
        WHEN 'January' THEN 'Janvier'
        WHEN 'February' THEN 'Février'
        WHEN 'March' THEN 'Mars'
        WHEN 'April' THEN 'Avril'
        WHEN 'May' THEN 'Mai'
        WHEN 'June' THEN 'Juin'
        WHEN 'July' THEN 'Juillet'
        WHEN 'August' THEN 'Août'
        WHEN 'September' THEN 'Septembre'
        WHEN 'October' THEN 'Octobre'
        WHEN 'November' THEN 'Novembre'
        WHEN 'December' THEN 'Décembre'
        ELSE 'Inconnu'
    END AS FrenchMonthName,
    MONTH(dl.FullDate) AS MonthNumberOfYear,
    DATEPART(QUARTER, dl.FullDate) AS CalendarQuarter,
    YEAR(dl.FullDate) AS CalendarYear,
    CASE
        WHEN DATEPART(QUARTER, dl.FullDate) IN (1, 2) THEN 1
        ELSE 2
    END AS CalendarSemester,
    CASE
        WHEN DATEPART(QUARTER, dl.FullDate) IN (1, 2) THEN 1
        ELSE 2
    END AS FiscalQuarter,
    CASE
        WHEN DATEPART(QUARTER, dl.FullDate) IN (1, 2) THEN YEAR(dl.FullDate) - 1
        ELSE YEAR(dl.FullDate)
    END AS FiscalYear,
    CASE
        WHEN DATEPART(QUARTER, dl.FullDate) IN (1, 2) THEN 2
        ELSE 1
    END AS FiscalSemester
FROM @datelist dl
LEFT JOIN [AdventureWorksDW2019].[dbo].[DimDate] dt
    ON dt.FullDateAlternateKey = dl.FullDate
WHERE dt.DateKey IS NULL;
