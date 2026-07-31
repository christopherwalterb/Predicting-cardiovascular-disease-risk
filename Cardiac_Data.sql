USE CardioDB;
GO

-- Delete rows where systolic is less than or equal to diastolic
DELETE FROM dbo.cardio_data
WHERE ap_hi <= ap_lo;
GO

-- Count remaining patients, Ave_age, Ave_weight,Ave_height, Ave_systolic, Ave_diastolic, Sum_disease_prevalence_percentage
SELECT 
    COUNT(*) AS Remaining_Patients,
    ROUND(AVG(CAST(age AS FLOAT)), 2) AS Avg_Age_Days,
    ROUND(AVG(CAST(weight AS FLOAT)), 2) AS Avg_Weight_Kg,
    ROUND(AVG(CAST(height AS FLOAT)), 2) AS Avg_Height_Cm,
    ROUND(AVG(CAST(ap_hi AS FLOAT)), 2) AS Avg_Systolic,
    ROUND(AVG(CAST(ap_lo AS FLOAT)), 2) AS Avg_Diastolic,
    ROUND(SUM(CAST(disease AS FLOAT)) * 100.0 / COUNT(*), 2) AS Disease_Prevalence_Percentage
FROM dbo.cardio_data;

---Disease Prevalence by Country
SELECT 
    country,
    COUNT(*) AS Remaining_Patients,
    SUM(CAST(disease AS INT)) AS Patients_With_Disease,
    ROUND(SUM(CAST(disease AS FLOAT)) * 100.0 / COUNT(*), 2) AS Disease_Rate_Percentage
FROM dbo.cardio_data
GROUP BY country
ORDER BY Disease_Rate_Percentage DESC;

---Lifestyle prevalence on Disease percentage
SELECT 
    smoke,
    alco,
    active,
    COUNT(*) AS Remaining_Patients,


    ROUND(SUM(CAST(disease AS FLOAT)) * 100.0 / COUNT(*), 2) AS Disease_Rate_Percentage
FROM dbo.cardio_data
GROUP BY smoke, alco, active
ORDER BY Disease_Rate_Percentage DESC;


---Gender prevalence on Disease Percentage
SELECT
    gender,
    COUNT(*) AS Remaining_Patients,
    SUM(CAST(disease AS INT)) AS Patients_With_Disease,
    ROUND(
        SUM(CAST(disease AS FLOAT))*100.0/COUNT(*),
        2
    ) AS Disease_Rate
FROM dbo.cardio_data
GROUP BY gender;

---To verify gender
SELECT
    gender,
    COUNT(*) AS Remaining_Patients,
    AVG(height) AS Avg_Height_cm,
    AVG(CAST(smoke AS FLOAT))*100 AS Smoking_Rate_Pct
FROM dbo.cardio_data
GROUP BY gender;


---Disease prevalence by occupation
SELECT
    occupation,
    COUNT(*) AS Total_Patients,
    SUM(CAST(disease AS INT)) AS Patients_With_Disease,
    ROUND(
        SUM(CAST(disease AS FLOAT)) * 100.0 / COUNT(*),
        2
    ) AS Disease_Rate_Pct
FROM cardio_data
GROUP BY occupation
ORDER BY Disease_Rate_Pct DESC;

SELECT
    occupation,
    ROUND(
        SUM(CAST(disease AS FLOAT)) * 100.0 / COUNT(*),
        2
    ) AS Disease_Rate_Pct
FROM cardio_data
GROUP BY occupation
ORDER BY Disease_Rate_Pct DESC;


---Cholesterol prevalence on Disease percentage
SELECT 
    cholesterol,
    gluc,
    COUNT(*) AS Patient_Count,
    ROUND(SUM(CAST(disease AS FLOAT)) * 100.0 / COUNT(*), 2) AS Disease_Rate_Percentage
FROM dbo.cardio_data
GROUP BY cholesterol, gluc
ORDER BY cholesterol, gluc;


---Exporting Data to Python
SELECT *
FROM dbo.cardio_data;