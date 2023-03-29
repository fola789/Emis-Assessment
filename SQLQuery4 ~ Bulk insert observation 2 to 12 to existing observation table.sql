SELECT TOP 0 *
INTO #temp_observation
FROM [emis].[dbo].[observation]
GO

DECLARE @i INT = 2 -- Set the starting number of the CSV file
DECLARE @filename VARCHAR(100)
WHILE @i <= 12 -- Set the ending number of the CSV file
BEGIN
    SET @filename = 'C:\Users\Fola\Documents\Projects\EMIS\exa-data-analyst-assessment-main\Emis-Assessment\data\observation\observation_' + CAST(@i AS VARCHAR(2)) + '.csv'
	EXEC('BULK INSERT #temp_observation FROM ''' + @filename + ''' WITH (FIELDTERMINATOR = '','', ROWTERMINATOR = ''0x0a'')')
	SET @i = @i + 1
END

INSERT INTO [emis].[dbo].[observation]
SELECT * FROM #temp_observation
DROP TABLE #temp_observation