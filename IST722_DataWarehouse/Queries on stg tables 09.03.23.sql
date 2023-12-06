-- Query stage data to look at the extracted data from the source databases of ff and fm 

SELECT * FROM stgFudgeflixCustomers;
GO

-- plan name is null in the stg table? Check the source data

SELECT * FROM stgFudgeflixProducts; 
GO

-- fudgeflix products looks interesting...ab_id = account billing id. There are ab_account_id that look like account_id in fudgeflix customers. 
