SELECT 
  AVG(CASE WHEN is_default THEN 1.0 ELSE 0.0 END) AS default_rate
FROM credit_data_clean;
