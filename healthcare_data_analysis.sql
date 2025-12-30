CREATE TABLE healthcare (
    name TEXT,
    age INT,
    gender TEXT,
    blood_type TEXT,
    medical_condition TEXT,
    date_of_admission DATE,
    doctor TEXT,
    hospital TEXT,
    insurance_provider TEXT,
    billing_amount NUMERIC,
    room_number INT,
    admission_type TEXT,
    discharge_date DATE,
    medication TEXT,
    test_results TEXT
);

-- Load csv file to table
COPY healthcare
FROM 'D:\DataAnalytics\SQL\Healthcare Project\archive(1)/healthcare_dataset.csv'
WITH (FORMAT CSV, HEADER true);

----------------------------------------------------------------------------------------
-- Data Quality Checks and Cleaning

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
--KEY QUERIES FOR INSIGHTS

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



