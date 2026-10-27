
-- ReadmitGuard Healthcare Analytics
-- STEP 1: Create and Use Database

CREATE DATABASE IF NOT EXISTS healthcare;
USE healthcare;

CREATE TABLE diabetic_data (
    encounter_id INT,
    patient_nbr INT,
    race VARCHAR(50),
    gender VARCHAR(20),
    age VARCHAR(20),
    weight VARCHAR(20),
    admission_type_id INT,
    discharge_disposition_id INT,
    admission_source_id INT,
    time_in_hospital INT,
    payer_code VARCHAR(20),
    medical_specialty VARCHAR(100),
    num_lab_procedures INT,
    num_procedures INT,
    num_medications INT,
    number_outpatient INT,
    number_emergency INT,
    number_inpatient INT,
    diag_1 VARCHAR(20),
    diag_2 VARCHAR(20),
    diag_3 VARCHAR(20),
    number_diagnoses INT,
    max_glu_serum VARCHAR(20),
    A1Cresult VARCHAR(20),
    metformin VARCHAR(20),
    repaglinide VARCHAR(20),
    nateglinide VARCHAR(20),
    chlorpropamide VARCHAR(20),
    glimepiride VARCHAR(20),
    acetohexamide VARCHAR(20),
    glipizide VARCHAR(20),
    glyburide VARCHAR(20),
    tolbutamide VARCHAR(20),
    pioglitazone VARCHAR(20),
    rosiglitazone VARCHAR(20),
    acarbose VARCHAR(20),
    miglitol VARCHAR(20),
    troglitazone VARCHAR(20),
    tolazamide VARCHAR(20),
    examide VARCHAR(20),
    citoglipton VARCHAR(20),
    insulin VARCHAR(20),
    `glyburide-metformin` VARCHAR(20),
    `glipizide-metformin` VARCHAR(20),
    `glimepiride-pioglitazone` VARCHAR(20),
    `metformin-rosiglitazone` VARCHAR(20),
    `metformin-pioglitazone` VARCHAR(20),
    `change` VARCHAR(20),
    diabetesMed VARCHAR(20),
    readmitted VARCHAR(10)
);

SHOW TABLES;

-- QUESTION 1
-- Total Patient Encounters

SELECT
COUNT(*) AS Total_Encounters
FROM diabetic_data;

-- QUESTION 2
-- Top 10 Most Common Diagnoses

SELECT
diagnosis_code,
COUNT(*) AS Total

FROM
(
SELECT diag_1 AS diagnosis_code
FROM diabetic_data

UNION ALL

SELECT diag_2
FROM diabetic_data

UNION ALL

SELECT diag_3
FROM diabetic_data
) diagnoses

WHERE diagnosis_code <> '?'

GROUP BY diagnosis_code

ORDER BY Total DESC

LIMIT 10;

-- QUESTION 3
-- Average Hospital Stay
-- By Admission Type

SELECT admission_type_id,
       ROUND(AVG(time_in_hospital),2) AS Average_Stay
FROM diabetic_data
GROUP BY admission_type_id
ORDER BY admission_type_id;

-- QUESTION 4
-- Number and Percentage
-- of Readmitted Patients

SELECT

COUNT(*) AS Readmitted_Encounters,

ROUND(

COUNT(*)*100/
(
SELECT COUNT(*)
FROM diabetic_data
),

2

) AS Percentage

FROM diabetic_data

WHERE readmitted IN('<30','>30');

-- QUESTION 5
-- Patient Distribution
-- By Age

SELECT

age,

COUNT(*) AS Patients

FROM diabetic_data

GROUP BY age

ORDER BY age;

-- QUESTION 6
-- Most Common Procedure Count

SELECT

num_procedures,

COUNT(*) AS Total

FROM diabetic_data

GROUP BY num_procedures

ORDER BY Total DESC;

-- QUESTION 7
-- Average Number of Medications
-- By Age

SELECT

age,

ROUND(
AVG(num_medications),2
) AS Average_Medications

FROM diabetic_data

GROUP BY age

ORDER BY age;

-- QUESTION 8
-- Readmission Rate
-- By Payer Code

SELECT

payer_code,

COUNT(*) AS Total,

SUM(
CASE
WHEN readmitted='<30'
THEN 1
ELSE 0
END
) AS Readmitted30,

ROUND(

SUM(
CASE
WHEN readmitted='<30'
THEN 1
ELSE 0
END
)*100/COUNT(*),2

) AS Percentage

FROM diabetic_data

GROUP BY payer_code

ORDER BY Percentage DESC;



















