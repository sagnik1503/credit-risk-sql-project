-- Default rate by income bracket
SELECT 
  income_bracket,
  COUNT(*) AS total_loans,
  ROUND(AVG(CASE WHEN is_default THEN 1.0 ELSE 0.0 END)::numeric, 4) AS default_rate
FROM credit_data_clean
GROUP BY income_bracket
ORDER BY CASE income_bracket
           WHEN 'low' THEN 1
           WHEN 'mid' THEN 2
           WHEN 'high' THEN 3
           ELSE 4 END;


	-- Default rate by home ownership type
SELECT 
  person_home_ownership,
  COUNT(*) AS total_loans,
  ROUND(AVG(CASE WHEN is_default THEN 1.0 ELSE 0.0 END)::numeric, 4) AS default_rate
FROM credit_data_clean
GROUP BY person_home_ownership
ORDER BY total_loans DESC;

-- Bucket employment length and compute default rate
WITH buckets AS (
  SELECT 
    CASE
      WHEN person_emp_length_years IS NULL THEN 'unknown'
      WHEN person_emp_length_years < 1 THEN '0–1'
      WHEN person_emp_length_years < 3 THEN '1–3'
      WHEN person_emp_length_years < 5 THEN '3–5'
      WHEN person_emp_length_years < 10 THEN '5–10'
      ELSE '10+'
    END AS emp_bucket,
    is_default
  FROM credit_data_clean
)
SELECT emp_bucket,
       COUNT(*) AS total_loans,
       ROUND(AVG(CASE WHEN is_default THEN 1.0 ELSE 0.0 END)::numeric, 4) AS default_rate
FROM buckets
GROUP BY emp_bucket
ORDER BY 
  CASE emp_bucket
    WHEN '0–1' THEN 1 WHEN '1–3' THEN 2 WHEN '3–5' THEN 3
    WHEN '5–10' THEN 4 WHEN '10+' THEN 5 ELSE 6
  END;


-- Default rate by previous default flag
SELECT 
  cb_person_default_on_file,
  COUNT(*) AS total_loans,
  ROUND(AVG(CASE WHEN is_default THEN 1.0 ELSE 0.0 END)::numeric, 4) AS default_rate
FROM credit_data_clean
GROUP BY cb_person_default_on_file;

-- Default rate by credit history bucket
WITH buckets AS (
  SELECT 
    CASE
      WHEN cb_person_cred_hist_length IS NULL THEN 'unknown'
      WHEN cb_person_cred_hist_length < 3 THEN '<3'
      WHEN cb_person_cred_hist_length < 6 THEN '3–6'
      WHEN cb_person_cred_hist_length < 10 THEN '6–10'
      ELSE '10+'
    END AS hist_bucket,
    is_default
  FROM credit_data_clean
)
SELECT hist_bucket,
       COUNT(*) AS total_loans,
       ROUND(AVG(CASE WHEN is_default THEN 1.0 ELSE 0.0 END)::numeric, 4) AS default_rate
FROM buckets
GROUP BY hist_bucket
ORDER BY 
  CASE hist_bucket
    WHEN '<3' THEN 1 WHEN '3–6' THEN 2 WHEN '6–10' THEN 3
    WHEN '10+' THEN 4 ELSE 5 END;

	   