SELECT TOP 0 *
INTO #temp_medication
FROM medication
GO

DECLARE @i INT = 2 -- Set the starting number of the CSV file
DECLARE @filename VARCHAR(100)
WHILE @i <= 15 -- Set the ending number of the CSV file
BEGIN
    SET @filename = 'C:\Users\Fola\Documents\Projects\EMIS\exa-data-analyst-assessment-main\data\medication\medication_' + CAST(@i AS VARCHAR(2)) + '.csv'
    DECLARE @sql NVARCHAR(MAX) = N'BULK INSERT #temp_medication FROM ''' + @filename + N''' WITH (FIELDTERMINATOR = '','', ROWTERMINATOR = ''0x0a'')'
    EXEC(@sql)
    SET @i = @i + 1
END

INSERT INTO medication
SELECT * FROM #temp_medication
DROP TABLE #temp_medication