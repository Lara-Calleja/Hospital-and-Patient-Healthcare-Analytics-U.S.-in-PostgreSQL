# Hospital and Patient Healthcare Analytics U.S.
This project explores patient admissions, healthcare costs, and length of stay using a publicly available synthetic U.S. healthcare dataset. 
The goal is to identify patterns that could inform service improvement and resource planning.

## Project Evolution

- **Version 1:** Exploratory healthcare analytics using core SQL
- **Version 2:** Advanced SQL implementation with JOINs, window functions, and stored procedures
- **Version 3:** Interactive Power BI dashboard for stakeholder reporting

**Version 1:**
## Objectives
- Analyze admission trends over time
- Identify common medical conditions
- Examine billing distributions
- Assess data quality issues in public healthcare datasets

## Tools Used
- PostgreSQL
- SQL (aggregations, filtering, date functions)

## Dataset
Publicly available U.S. healthcare dataset sourced from Kaggle.
- [Hospital and Patient Healthcare Analytics (U.S.)](https://www.kaggle.com/datasets/prasad22/healthcare-dataset)

## Methodology
- Data quality assessment (missing values, duplicates, outliers)
- Data standardization for analysis
- Aggregate-level exploratory analysis
- No patient-level tracking or relational joins

## Key Findings
- Admissions show seasonal variation across years
- A small number of conditions account for a large share of admissions
- Billing amounts contain outliers and rounding inconsistencies

## Limitations
- The dataset is synthetic and designed to simulate healthcare admissions rather than represent real patient records.
- No unique patient identifier
- Aggregate-level analysis only
- Patterns observed may not fully reflect real-world healthcare system behavior.
