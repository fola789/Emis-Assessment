SELECT 
    LEFT(["postcode"], PATINDEX('%[0-9]%', ["postcode"])-1) AS postcode_area, 
    COUNT(*) AS num_patients
FROM 
    [emis].[dbo].[patient]
WHERE 
    ["postcode"] LIKE '[A-Z]%[0-9]%'
GROUP BY 
    LEFT(["postcode"], PATINDEX('%[0-9]%', ["postcode"])-1)
ORDER BY 
    num_patients DESC