SELECT 
    LEFT(["postcode"], PATINDEX('%[0-9]%', ["postcode"])-1) AS postcode_area, 
    COUNT(*) AS num_patients,
    SUM(CASE WHEN ["gender"] = 'Male' THEN 1 ELSE 0 END) AS male_patients,
    SUM(CASE WHEN ["gender"] = 'Female' THEN 1 ELSE 0 END) AS female_patients,
    CAST(SUM(CASE WHEN ["gender"] = 'Male' THEN 1 ELSE 0 END) AS FLOAT) / NULLIF(SUM(CASE WHEN ["gender"] = 'Female' THEN 1 ELSE 0 END), 0) AS gender_ratio
FROM 
    [emis].[dbo].[patient]
WHERE 
    ["postcode"] LIKE '[A-Z]%[0-9]%'
GROUP BY 
    LEFT(["postcode"], PATINDEX('%[0-9]%', ["postcode"])-1)
ORDER BY 
    num_patients DESC;