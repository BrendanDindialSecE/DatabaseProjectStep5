-- Step 5: Deeper Analysis SQL Queries

-- 1. Which gender has higher average billing? This can help reveal financial patterns related to gender
SELECT 
    GENDER,
    ROUND(AVG(BILLINGAMOUNT), 2) AS AVG_BILLING
FROM 
    HEALTHCARE_PATIENT
WHERE 
    GENDER IS NOT NULL
GROUP BY 
    GENDER
ORDER BY AVG_BILLING DESC;

-- 2. Top 5 conditions with the highest average billing, Identify which medical conditions are most costly on average.
SELECT 
    MEDICALCONDITION,
    COUNT(*) AS NUM_CASES,
    ROUND(AVG(BILLINGAMOUNT), 2) AS AVG_BILL
FROM 
    HEALTHCARE_PATIENT
WHERE 
    MEDICALCONDITION IS NOT NULL
GROUP BY 
    MEDICALCONDITION
ORDER BY AVG_BILL DESC
FETCH FIRST 5 ROWS ONLY;

-- 3. Hospital performance.. average stay and billing. See which hospitals have longer stays and higher costs.
SELECT 
    HOSPITAL,
    COUNT(*) AS TOTAL_PATIENTS,
    ROUND(AVG(DISCHARGEDATE - DATEOFADMISSION), 2) AS AVG_STAY,
    ROUND(AVG(BILLINGAMOUNT), 2) AS AVG_BILLING
FROM 
    HEALTHCARE_PATIENT
WHERE 
    DATEOFADMISSION IS NOT NULL 
    AND DISCHARGEDATE IS NOT NULL
GROUP BY 
    HOSPITAL
ORDER BY AVG_STAY DESC;

--4. Do older patients stay longer? See if there's a trend between age and stay duration.

SELECT 
    CASE 
        WHEN AGE < 20 THEN 'Under 20'
        WHEN AGE BETWEEN 20 AND 39 THEN '20-39'
        WHEN AGE BETWEEN 40 AND 59 THEN '40-59'
        WHEN AGE BETWEEN 60 AND 79 THEN '60-79'
        ELSE '80+'
    END AS AGE_GROUP,
    COUNT(*) AS TOTAL_PATIENTS,
    ROUND(AVG(DISCHARGEDATE - DATEOFADMISSION), 2) AS AVG_STAY
FROM 
    HEALTHCARE_PATIENT
WHERE 
    AGE IS NOT NULL 
    AND DATEOFADMISSION IS NOT NULL 
    AND DISCHARGEDATE IS NOT NULL
GROUP BY 
    CASE 
        WHEN AGE < 20 THEN 'Under 20'
        WHEN AGE BETWEEN 20 AND 39 THEN '20-39'
        WHEN AGE BETWEEN 40 AND 59 THEN '40-59'
        WHEN AGE BETWEEN 60 AND 79 THEN '60-79'
        ELSE '80+'
    END
ORDER BY AVG_STAY DESC;

--5. Is there a trend in admission type and billing amount?

SELECT 
    ADMISSIONTYPE,
    COUNT(*) AS NUM_ADMISSIONS,
    ROUND(AVG(BILLINGAMOUNT), 2) AS AVG_BILLING
FROM 
    HEALTHCARE_PATIENT
WHERE 
    ADMISSIONTYPE IS NOT NULL
GROUP BY 
    ADMISSIONTYPE
ORDER BY AVG_BILLING DESC;
