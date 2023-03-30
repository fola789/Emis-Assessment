SELECT TOP 0 *
INTO #temp_medication
FROM [emis].[dbo].[medication]
GO

DECLARE @i INT = 2 -- Set the starting number of the CSV file
DECLARE @filename VARCHAR(100)
WHILE @i <= 15 -- Set the ending number of the CSV file
BEGIN
    SET @filename = 'C:\Users\Fola\Documents\Projects\EMIS\exa-data-analyst-assessment-main\data\medication\medication_' + CAST(@i AS VARCHAR(2)) + '.csv'
	EXEC('BULK INSERT #temp_medication FROM ''' + @filename + ''' WITH (FIELDTERMINATOR = '','', ROWTERMINATOR = ''0x0a'')')
	SET @i = @i + 1
END

INSERT INTO [emis].[dbo].[medication]
SELECT * FROM #temp_medication
DROP TABLE #temp_medication