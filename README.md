#  Credit Risk & Collections Dashboard (SQL Project)

**Author:** Sagnik Ghosh  
**Role:** Collections & Admin Officer at Smart Start Interlocks
**Tools Used:** PostgreSQL, pgAdmin 4  
**Dataset:** [Credit Risk Dataset – Kaggle](https://www.kaggle.com/datasets/laotse/credit-risk-dataset)

---

##  Background & Motivation

As a Collections Officer, I help customers resolve overdue payments and address repayment issues.
Managing hundreds of accounts led me to wonder: What patterns set high-risk borrowers apart from reliable ones?

To explore this, I drew on my collections experience and built the **Credit Risk & Collections Dashboard** using only **SQL**.
This project turned daily observations into a data-driven understanding of credit and risk.

---

## Project Objective

To design and implement a SQL-based analytics model that: 1. Cleans and structures 32,581 real credit records from the Kaggle dataset.  2. Calculates portfolio metrics such as overall default rate and loan status.  3. Analyzes how customer attributes (income, employment, home ownership) and loan details (purpose, interest rate, grade) affect defaults.  4. Builds a borrower risk scoring model (A to E) to classify accounts into clear risk bands.

---

##  Dataset Overview

| Category | Columns |
|-----------|----------|
| **Customer** | age, income, home ownership, employment length |
| **Loan** | intent, grade, amount, interest rate |
| **Credit Behaviour** | prior default flag, credit history length |
| **Target Variable** | `loan_status` (1 = defaulted, 0 = repaid) |
| **Derived Fields** | income bracket, risk score, risk band |

**Records:** 32,581  
**Source:** Kaggle Credit Risk Dataset  

---

##  Repository Structure

SQL Project/
├── data/
│ ├── credit_risk_dataset.csv
│ └── outputs/
│ ├── kpi_default_rate.csv
│ ├── kpi_by_income.csv
│ ├── kpi_by_home_ownership.csv
│ ├── kpi_by_employment.csv
│ ├── kpi_by_prior_default.csv
│ ├── kpi_by_credit_history.csv
│ ├── kpi_by_loan_intent.csv
│ ├── kpi_by_loan_grade.csv
│ ├── kpi_by_interest_rate.csv
│ ├── kpi_portfolio_averages.csv
│ └── risk_bands.csv
├── sql/
│ ├── 01_kpis.sql # Portfolio KPIs
│ ├── 02_customer_kpis.sql # Customer-based analysis
│ ├── 03_loan_kpis.sql # Loan-level analysis
│ └── 04_risk_scoring.sql # Risk scoring model
└── README.md


---

##  Key Insights & Results

| Area | KPI / Finding | Observation |
|------|----------------|--------------|
| **Portfolio Health** | Default Rate | **21.82%** of loans defaulted |
| **Income Bracket** | Low vs Mid vs High | Default risk highest for low-income borrowers |
| **Home Ownership** | Owner vs Renter | Renters default more frequently than homeowners |
| **Employment Stability** | Employment length vs Risk | Shorter employment history → higher default likelihood |
| **Previous Defaults** | Prior default flag | Borrowers with a previous default are **2x more likely** to default again |
| **Credit History** | Length of credit history | Risk decreases steadily with longer credit history |
| **Loan Purpose** | Education / Venture / Medical | Education & venture loans show the highest default rates |
| **Interest Rate** | Interest bucket vs Risk | Higher interest brackets (>16%) correlate with higher default |
| **Risk Bands** | SQL-based A to E model | Default rate increases from **A (lowest)** to **E (highest)** |

---

##  Example Query

```sql
-- Overall portfolio default rate
SELECT 
  ROUND(AVG(CASE WHEN is_default THEN 1.0 ELSE 0.0 END)::numeric, 4) AS default_rate
FROM credit_data_clean;
-- → 0.2182  (≈ 21.8%)



##SQL Concepts Demonstrated

1. Data Cleaning & Type Casting
2. Common Table Expressions (CTEs)
3. Conditional Aggregations with CASE
4. Segmentation & Bucketing Logic
5. Derived Columns & Feature Engineering
6. Scoring Models & Risk Banding
7. Exporting SQL outputs for dashboards



##Risk Scoring Logic

Borrowers are scored based on 7 key risk factors:

1. Income bracket
2. Home ownership type
3. Employment length
4. Prior default flag
5. Credit history length
6. Loan interest rate
7. Loan grade

Each factor adds points to a borrower’s risk_points, which translate into:

Risk Band              Meaning          Typical Default Pattern
A                       Very Low Risk       Long credit history, steady job
B                          Low Risk             Mid-income, no prior defaults
C                      Moderate Risk       Average borrower
D                         High Risk             Renters, shorter employment
E                      Very High Risk        Prior defaults, high-interest loans


##Example Outputs
File Purpose
kpi_default_rate.csv Overall portfolio default rate
kpi_by_income.csv Default rate by income bracket
kpi_by_home_ownership.csv Risk based on housing stability
kpi_by_employment.csv Impact of employment length
kpi_by_loan_intent.csv Risk by loan purpose
risk_bands.csv Final borrower classification by A–E risk band

##Personal Reflection

This project bridges my collections experience and data analysis skills.

In collections, I’ve seen firsthand how different borrower types behave.
By using SQL, I was able to quantify those patterns and show that risk is not random; it can be measured and predicted.

Building this dashboard gave me hands-on experience in:

A. Translating business problems into SQL queries

B. Structuring data for analysis

C. Presenting insights that are practical for credit and operations teams

Created & Documented by:
Sagnik Kumar Ghosh
sagnik1503@gmail.com