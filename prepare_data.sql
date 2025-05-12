CREATE OR REPLACE TABLE finance.fraud_data_sample AS
SELECT
      type,
      amount,
      nameOrig,
      nameDest,
      oldbalanceOrg as oldbalanceOrig,  #standardize the naming.
      newbalanceOrig,
      oldbalanceDest,
      newbalanceDest,
# add new features:
      if(oldbalanceOrg = 0.0, 1, 0) as origzeroFlag,
      if(newbalanceDest = 0.0, 1, 0) as destzeroFlag,
      round((newbalanceDest-oldbalanceDest-amount)) as amountError,
      generate_uuid() as id,        #create a unique id for each transaction.
      isFraud
FROM finance.fraud_data
WHERE
# filter unnecessary transaction types:
      type in("CASH_OUT","TRANSFER") AND
# undersample:
      (isFraud = 1 or (RAND()< 10/100))  # select 10% of the non-fraud cases;

CREATE OR REPLACE TABLE finance.fraud_data_test AS
SELECT *
FROM finance.fraud_data_sample
where RAND() < 20/100;

CREATE OR REPLACE TABLE finance.fraud_data_model AS
SELECT
*
FROM finance.fraud_data_sample  
EXCEPT distinct select * from finance.fraud_data_test;
