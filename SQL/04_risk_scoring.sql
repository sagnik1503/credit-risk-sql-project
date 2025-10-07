-- Create a table with risk score components
DROP TABLE IF EXISTS risk_scores;

CREATE TABLE risk_scores AS
SELECT
  *,
  (
    0
    + CASE WHEN income_bracket = 'low' THEN 2 WHEN income_bracket = 'mid' THEN 1 ELSE 0 END
    + CASE WHEN person_home_ownership IN ('rent','other') THEN 1 ELSE 0 END
    + CASE WHEN person_emp_length_years IS NOT NULL AND person_emp_length_years < 2 THEN 1 ELSE 0 END
    + CASE WHEN cb_person_default_on_file = 'yes' THEN 2 ELSE 0 END
    + CASE WHEN cb_person_cred_hist_length < 3 THEN 1 ELSE 0 END
    + CASE WHEN loan_int_rate_pct >= 15 THEN 2 WHEN loan_int_rate_pct >= 10 THEN 1 ELSE 0 END
    + CASE WHEN loan_grade IN ('E','F','G') THEN 2 WHEN loan_grade IN ('C','D') THEN 1 ELSE 0 END
  ) AS risk_points
FROM credit_data_clean;
