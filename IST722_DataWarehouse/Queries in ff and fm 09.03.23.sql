-- Quick queries of source data from ff and fm

SELECT * FROM ff_account_billing; 
-- there is a time span in billing from 2010-01-01 to 2013-02-01, so we can do quaterly analysis

-- ff_acount_titles do not have much to do with our project - order fulfillment 
SELECT * FROM ff_account_titles; 

-- ff accounts: including first name, last name, account zipcode, account_address has null values and is not valuable
SELECT * FROM ff_accounts;  

