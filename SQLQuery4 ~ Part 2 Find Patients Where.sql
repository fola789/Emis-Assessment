SELECT 
	DISTINCT p.*
FROM 
	[emis].[dbo].[patient] p 
	INNER JOIN [emis].[dbo].[observation] o ON p.["registration_guid"] = o.["registration_guid"]
	INNER JOIN [emis].[dbo].[clinical_codes] c ON (o.["emis_code_id"] = c.["code_id"] AND o.["snomed_concept_id"] = c.["snomed_concept_id"])
	LEFT OUTER JOIN [emis].[dbo].[medication] m ON p.["registration_guid"] = m.["registration_guid"]
WHERE 
	c.["refset_simple_id"] = 999012891000230104
	AND c.["code_id"] IN (591221000033116, 717321000033118, 1215621000033114, 972021000033115, 1223821000033118)
	AND c.["snomed_concept_id"] IN (129490002, 108606009, 702408004, 702801003, 704459002)
	AND c.["refset_simple_id"] NOT IN (999004211000230104, 999011571000230107)
	AND o.["dummy_patient_flag"] = 0
	AND o.["confidential_flag"] = 0
	AND m.["dummy_patient_flag"] = 0
	AND m.["confidential_flag"] = 0;
