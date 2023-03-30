WITH cte_patient AS (
    SELECT 
        p.["registration_guid"],
        p.["patient_id"],
        CONCAT(p.["patient_givenname"], ' ', p.["patient_surname"]) AS full_name,
        p.["postcode"],
        p.["age"],
        p.["gender"]
    FROM [emis].[dbo].[patient] p
    WHERE p.["postcode"] LIKE 'LS%'
),
cte_medication AS (
    SELECT DISTINCT
        m.["registration_guid"],
        m.["dummy_patient_flag"],
        m.["confidential_flag"]
    FROM [emis].[dbo].[medication] m
    JOIN [emis].[dbo].clinical_codes c ON m.["emis_drug_guid"] = c.["code_id"]
    WHERE c.["refset_simple_id"] = 999012891000230104
        AND c.["parent_code_id"] IN (591221000033116, 717321000033118, 1215621000033114, 972021000033115, 1223821000033118)
        AND c.["snomed_concept_id"] IN (129490002, 108606009, 702408004, 702801003, 704459002)
        AND m.["dummy_patient_flag"] = 0
        AND m.["confidential_flag"] = 0
        AND NOT EXISTS (
            SELECT 1
            FROM [emis].[dbo].[clinical_codes] c2
            WHERE c2.["refset_simple_id"] IN (999004211000230104, 999011571000230107)
                AND c2.["snomed_concept_id"] IN (27113001)
                AND c2.["code_id"] = m.["emis_drug_guid"]
        )
),
cte_observation AS (
    SELECT DISTINCT
        o.["registration_guid"],
        o.["dummy_patient_flag"],
        o.["confidential_patient_flag"]
    FROM [emis].[dbo].[observation] o
    JOIN [emis].[dbo].[clinical_codes] c ON o.["emis_code_id"] = c.["code_id"]
    WHERE c.["refset_simple_id"] = 999012891000230104
        AND c.["parent_code_id"] IN (591221000033116, 717321000033118, 1215621000033114, 972021000033115, 1223821000033118)
        AND c.["snomed_concept_id"] IN (129490002, 108606009, 702408004, 702801003, 704459002)
        AND o.["dummy_patient_flag"] = 0
        AND o.["confidential_patient_flag"] = 0
        AND NOT EXISTS (
            SELECT 1
            FROM [emis].[dbo].[clinical_codes] c2
            WHERE c2.["refset_simple_id"] IN (999004211000230104, 999011571000230107)
                AND c2.["snomed_concept_id"] IN (27113001)
                AND c2.["code_id"] = o.["emis_code_id"]
        )
)
SELECT 
    p.["registration_guid"],
    p.["patient_id"],
    p.full_name,
    p.["postcode"],
    p.["age"],
    p.["gender"]
FROM cte_patient p
JOIN cte_medication m ON p.["registration_guid"] = m.["registration_guid"]
JOIN cte_observation o ON p.["registration_guid"] = o.["registration_guid"];
