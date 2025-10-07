-- Default rate by loan purpose (intent)
SELECT 
  loan_intent,
  COUNT(*) AS total_loans,
  ROUND(AVG(CASE WHEN is_default THEN 1.0 ELSE 0.0 END)::numeric, 4) AS default_rate,
  ROUND(AVG(loan_int_rate_pct)::numeric, 2) AS avg_interest_rate,
  ROUND(AVG(loan_amnt)::numeric, 2) AS avg_loan_amount
FROM credit_data_clean
GROUP BY loan_intent
ORDER BY default_rate DESC;

-- Default rate by internal loan grade
SELECT 
  loan_grade,
  COUNT(*) AS total_loans,
  ROUND(AVG(CASE WHEN is_default THEN 1.0 ELSE 0.0 END)::numeric, 4) AS default_rate,
  ROUND(AVG(loan_int_rate_pct)::numeric, 2) AS avg_interest_rate
FROM credit_data_clean
GROUP BY loan_grade
ORDER BY loan_grade;

-- Bucket loans by interest rate and compute default rate
WITH buckets AS (
  SELECT 
    CASE
      WHEN loan_int_rate_pct IS NULL THEN 'unknown'
      WHEN loan_int_rate_pct < 7 THEN '<7%'
      WHEN loan_int_rate_pct < 10 THEN '7–10%'
      WHEN loan_int_rate_pct < 13 THEN '10–13%'
      WHEN loan_int_rate_pct < 16 THEN '13–16%'
      WHEN loan_int_rate_pct < 20 THEN '16–20%'
      ELSE '20%+'
    END AS rate_bucket,
    is_default
  FROM credit_data_clean
)
SELECT rate_bucket,
       COUNT(*) AS total_loans,
       ROUND(AVG(CASE WHEN is_default THEN 1.0 ELSE 0.0 END)::numeric, 4) AS default_rate
FROM buckets
GROUP BY rate_bucket
ORDER BY 
  CASE rate_bucket
    WHEN '<7%' THEN 1 WHEN '7–10%' THEN 2 WHEN '10–13%' THEN 3
    WHEN '13–16%' THEN 4 WHEN '16–20%' THEN 5 WHEN '20%+' THEN 6 ELSE 7 END;

-- Portfolio averages
SELECT 
  ROUND(AVG(loan_amnt)::numeric, 2) AS avg_loan_amount,
  ROUND(AVG(loan_int_rate_pct)::numeric, 2) AS avg_interest_rate
FROM credit_data_clean;
