CREATE OR REPLACE MODEL
finance.model_supervised_boosted_tree
OPTIONS(model_type='BOOSTED_TREE_CLASSIFIER', INPUT_LABEL_COLS = ["isfraud"]
)
AS
SELECT
type, amount, oldbalanceOrig, newbalanceOrig, oldbalanceDest, newbalanceDest, isFraud
FROM finance.fraud_data_model;
