CREATE OR REPLACE MODEL
  finance.model_unsupervised OPTIONS(model_type='kmeans', num_clusters=5) AS
SELECT
  amount, oldbalanceOrig, newbalanceOrig, oldbalanceDest, newbalanceDest, type, origzeroFlag, destzeroFlag, amountError
  FROM
  `finance.fraud_data_model`;

SELECT
  centroid_id, sum(isfraud) as fraud_cnt,  count(*) total_cnt
FROM
  ML.PREDICT(MODEL `finance.model_unsupervised`,
    (
    SELECT *
    FROM  `finance.fraud_data_test`))
group by centroid_id
order by centroid_id;
