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
FROM 'path/healthcare_dataset.csv'
WITH (FORMAT CSV, HEADER true);
