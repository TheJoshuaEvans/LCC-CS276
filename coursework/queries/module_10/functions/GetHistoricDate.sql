USE [RealTimeWW2];

/*
  Takes the current date and a starting year, and returns a matching historic date. Leap years
  are ignored, so any time a leap day would be returned, the previous day is returned instead
*/
DROP FUNCTION IF EXISTS GetHistoricDate;
GO
CREATE FUNCTION GetHistoricDate(@CurrentDate DATE, @StartYear INT) RETURNS DATE AS
BEGIN
  DECLARE @CurrentYear INT = DATEPART(YEAR, @CurrentDAte);
  DECLARE @CurrentMonth INT = DATEPART(MONTH, @CurrentDAte);
  DECLARE @CurrentDay INT = DATEPART(DAY, @CurrentDAte);

  -- If the input date is a leap day, make it the previous day
  IF @CurrentMonth = 2 AND @CurrentDay = 29 BEGIN
    SET @CurrentDay = 28;
  END;

  DECLARE @HistoricDate DATE = DATEFROMPARTS(
    1939 + (@CurrentYear - @StartYear), @CurrentMonth, @CurrentDay
  );
  RETURN @HistoricDate;
END;
GO

GO
PRINT 'Should get the first historical date with current date and start year';
DECLARE @GetHistoricDateResult DATE = dbo.GetHistoricDate('2024-09-01', 2024)
DECLARE @ExpectedDate DATE = '1939-09-01';
IF NOT (@GetHistoricDateResult = '1939-09-01') BEGIN
  DECLARE @Msg VARCHAR(255) = 'Expected 1939-09-01, got ' + CAST(@GetHistoricDateResult AS CHAR(10));
  THROW 1337000, @Msg, 1;
END;

GO
PRINT 'Should get a later historical date with current date and start year';
DECLARE @GetHistoricDateResult DATE = dbo.GetHistoricDate('2026-06-29', 2023)
IF NOT (@GetHistoricDateResult = '1942-06-29') BEGIN
  DECLARE @Msg VARCHAR(255) = 'Expected 1942-06-29, got ' + CAST(@GetHistoricDateResult AS CHAR(10));
  THROW 1337000, @Msg, 1;
END;

GO
PRINT 'Should get previous day with a matching leap day';
DECLARE @GetHistoricDateResult DATE = dbo.GetHistoricDate('2024-02-29', 2023)
IF NOT (@GetHistoricDateResult = '1940-02-28') BEGIN
  DECLARE @Msg VARCHAR(255) = 'Expected 1940-02-28, got ' + CAST(@GetHistoricDateResult AS CHAR(10));
  THROW 1337000, @Msg, 1;
END;
