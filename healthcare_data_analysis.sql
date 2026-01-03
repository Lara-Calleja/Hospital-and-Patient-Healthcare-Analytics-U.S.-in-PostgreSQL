
/*
Sections:
1. Data overview 
2. Data quality checks and cleaning
3. Exploratory analysis
3. Key insights
*/
----------------------------------------------------------------------------------------
--1.				DATA OVERVIEW AND ROW COUNTS
----------------------------------------------------------------------------------------
SELECT COUNT(*) FROM healthcare;
----------------------------------------------------------------------------------------
--2.		 Data Quality Checks and Cleaning
----------------------------------------------------------------------------------------

-- Identification of missing critical fields. 
-- Records missing admission or discharge dates cannot be used for length-of-stay analysis.
SELECT
  COUNT(*) AS total_rows,
  COUNT(*) FILTER (WHERE age IS NULL) AS missing_age,
  COUNT(*) FILTER (WHERE date_of_admission IS NULL) AS missing_admission_date,
  COUNT(*) FILTER (WHERE discharge_date IS NULL) AS missing_discharge_date
FROM healthcare;

-- Standardize names and rounding billing amount to 2 decimal places (USD currency standardization)
-- View created for presentation and reporting purposes
CREATE VIEW healthcare_clean AS
	SELECT
  		INITCAP(TRIM(name)) AS patient_name,
 	 	age,
  		gender,
 		blood_type,
  		medical_condition,
 		date_of_admission,
  		doctor,
  		hospital,
  		insurance_provider,
  		ROUND(billing_amount, 2) AS billing_amount,
  		room_number,
  		admission_type,
  		discharge_date,
  		medication,
  		test_results
FROM healthcare;

SELECT * FROM healthcare_clean;

-- check date validity

SELECT COUNT(*) AS invalid_dates
FROM healthcare
WHERE discharge_date < date_of_admission;

-- Check for issues (ex: Male, male, m)
SELECT DISTINCT gender FROM healthcare;

-- standardize gender values
UPDATE healthcare
SET gender = INITCAP(TRIM(gender));

-- medical condition consistency
SELECT medical_condition, COUNT(*)
FROM healthcare
GROUP BY medical_condition;

--outlier check
SELECT
  MIN(billing_amount),
  MAX(billing_amount),
  AVG(billing_amount)
FROM healthcare
WHERE billing_amount < 0;
----------------------------------------------------------------------------------------
--3.			EXPLORATORY ANALYSIS
----------------------------------------------------------------------------------------
--Admissions over time
SELECT
	TO_CHAR(DATE_TRUNC('month', date_of_admission), 'Mon YYYY') AS month,
	COUNT(*) AS admissions
FROM healthcare
GROUP BY month
ORDER BY month;

-- Age and gender distribution
SELECT gender, COUNT(*) AS count, ROUND(AVG(age) ,0) AS avg_age
FROM healthcare
GROUP BY gender;

-- Age distribution buckets
SELECT
	CASE 
		WHEN age < 18 THEN 'Child'
		WHEN age BETWEEN 18 AND 64 THEN 'Adult'
		ELSE 'Senior' 
	END AS age_group,
	COUNT(*) AS population
FROM healthcare	
GROUP BY age_group;

----------------------------------------------------------------------------------------
--4.			KEY INSIGHTS
----------------------------------------------------------------------------------------
-- Most Medical Condition
SELECT medical_condition, COUNT(*) AS total_cases
FROM healthcare
GROUP BY medical_condition
ORDER BY total_cases DESC
LIMIT 10; --helps identify dominant patterns quickly

--Hishest Average billing by condition
SELECT medical_condition, 
	ROUND(AVG(billing_amount), 2) AS avg_billing
FROM healthcare
GROUP BY medical_condition
ORDER BY avg_billing DESC
LIMIT 10;

-- Average billing by insurance provider
SELECT 
	insurance_provider,
	ROUND(AVG(billing_amount),2) AS avg_cost,
	COUNT(*) AS records
FROM healthcare
GROUP BY insurance_provider
ORDER BY avg_cost DESC;

--Service Improvement Metrics (Length of Stay)
SELECT 
	discharge_date - date_of_admission AS length_of_stay,
	COUNT(*) AS stay_count
FROM healthcare
GROUP BY length_of_stay
ORDER BY stay_count DESC;

