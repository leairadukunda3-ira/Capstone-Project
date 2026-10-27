-- RETAILVC RETAIL ANALYTICS
-- SQL ANALYSIS

-- 1. CREATE SCHEMA

CREATE SCHEMA retail_data;

USE retail_data;

-- create table

CREATE TABLE marketing_campaign (
    ID INT NOT NULL,
    Year_Birth INT,
    Education VARCHAR(50),
    Marital_Status VARCHAR(50),

    Income VARCHAR(30),

    Kidhome INT,
    Teenhome INT,

    Dt_Customer VARCHAR(30),

    Recency INT,
    MntWines INT,
    MntFruits INT,
    MntMeatProducts INT,
    MntFishProducts INT,
    MntSweetProducts INT,
    MntGoldProds INT,

    NumDealsPurchases INT,
    NumWebPurchases INT,
    NumCatalogPurchases INT,
    NumStorePurchases INT,
    NumWebVisitsMonth INT,

    AcceptedCmp3 INT,
    AcceptedCmp4 INT,
    AcceptedCmp5 INT,
    AcceptedCmp1 INT,
    AcceptedCmp2 INT,

    Complain INT,
    Z_CostContact INT,
    Z_Revenue INT,
    Response INT,
    Age INT,

    PRIMARY KEY (ID)
);


-- Data loading

SELECT COUNT(*) AS Total_Customers
FROM marketing_campaign;


-- Turn Safe Update mode off

SET SQL_SAFE_UPDATES = 0;

-- Convert the blank Income values to NULL

UPDATE marketing_campaign
SET Income = NULL
WHERE TRIM(Income) = '';

-- Check how many became NULL

SELECT COUNT(*) AS Missing_Income
FROM marketing_campaign
WHERE Income IS NULL;

-- Check how many became NULL

ALTER TABLE marketing_campaign
MODIFY COLUMN Income DECIMAL(12,2) NULL;

-- Verify everything
SELECT
    COUNT(*) AS Total_Customers,
    COUNT(Income) AS Customers_With_Income,
    COUNT(*) - COUNT(Income) AS Missing_Income
FROM marketing_campaign;

-- Turn Safe Updates back on
SET SQL_SAFE_UPDATES = 1;

-- Step 1 — First inspect the dates
SELECT ID, Dt_Customer
FROM marketing_campaign
LIMIT 30;

-- Step 1 — Add the clean DATE column
ALTER TABLE marketing_campaign
ADD COLUMN Dt_Customer_Clean DATE;

-- Step 2 — Turn off Safe Updates temporarily
SET SQL_SAFE_UPDATES = 0;

-- Step 3 — Convert  dates
UPDATE marketing_campaign
SET Dt_Customer_Clean =
    STR_TO_DATE(Dt_Customer, '%d-%m-%Y');

-- Step 4 — Compare

SELECT
    ID,
    Dt_Customer,
    Dt_Customer_Clean
FROM marketing_campaign
LIMIT 30;

-- Step 5 — Check for failed conversions
SELECT COUNT(*) AS Failed_Date_Conversions
FROM marketing_campaign
WHERE Dt_Customer IS NOT NULL
  AND Dt_Customer_Clean IS NULL;

-- Confirm all 2,240 dates are present
SELECT
    COUNT(*) AS Total_Customers,
    COUNT(Dt_Customer_Clean) AS Valid_Dates
FROM marketing_campaign;

-- Remove the old text date column

ALTER TABLE marketing_campaign
DROP COLUMN Dt_Customer;

-- Rename the clean column
ALTER TABLE marketing_campaign
CHANGE COLUMN Dt_Customer_Clean Dt_Customer DATE;

-- Verify that it is really DATE
DESCRIBE marketing_campaign;

-- Look at some dates
SELECT
    ID,
    Dt_Customer
FROM marketing_campaign
LIMIT 20;

-- Final data-loading verification
SELECT
    COUNT(*) AS Total_Customers,
    COUNT(Income) AS Customers_With_Income,
    COUNT(*) - COUNT(Income) AS Missing_Income,
    COUNT(Dt_Customer) AS Valid_Customer_Dates
FROM marketing_campaign;

-- 2. TOTAL CUSTOMER ENCOUNTERS

SELECT COUNT(*) AS Total_Customers
FROM marketing_campaign;

-- 3. PRODUCT CATEGORY TOTALS
SELECT
    SUM(MntWines) AS Total_Wines,
    SUM(MntFruits) AS Total_Fruits,
    SUM(MntMeatProducts) AS Total_Meat,
    SUM(MntFishProducts) AS Total_Fish,
    SUM(MntSweetProducts) AS Total_Sweets,
    SUM(MntGoldProds) AS Total_Gold
FROM marketing_campaign;

-- 4. RESPONSE COUNTS
SELECT
    Response,
    COUNT(*) AS Number_of_Customers
FROM marketing_campaign
GROUP BY Response;

-- 5. EDUCATION AND MARITAL STATUS

SELECT
    Education,
    Marital_Status,
    COUNT(*) AS Number_of_Customers
FROM marketing_campaign
GROUP BY Education, Marital_Status
ORDER BY Number_of_Customers DESC;

-- 6. AVERAGE INCOME OF RESPONDERS
SELECT
    ROUND(AVG(Income), 2) AS Average_Income
FROM marketing_campaign
WHERE Response = 1;

-- 7. CAMPAIGN ACCEPTANCE

SELECT
    SUM(AcceptedCmp1) AS Campaign_1,
    SUM(AcceptedCmp2) AS Campaign_2,
    SUM(AcceptedCmp3) AS Campaign_3,
    SUM(AcceptedCmp4) AS Campaign_4,
    SUM(AcceptedCmp5) AS Campaign_5
FROM marketing_campaign;

--  8. LAST CAMPAIGN RESPONSE
 SELECT
    Response,
    COUNT(*) AS Customers
FROM marketing_campaign
GROUP BY Response;


-- 9. HOUSEHOLD COMPOSITION
SELECT
    ROUND(AVG(Kidhome), 2) AS Average_Children,
    ROUND(AVG(Teenhome), 2) AS Average_Teenagers
FROM marketing_campaign;

-- 10. CALCULATE AGE
ALTER TABLE marketing_campaign
ADD COLUMN Calculated_Age INT;

UPDATE marketing_campaign
SET Calculated_Age =
    YEAR(CURDATE()) - Year_Birth;
    
-- 11. CREATE AGE GROUP

ALTER TABLE marketing_campaign
ADD COLUMN Age_Group VARCHAR(20);

UPDATE marketing_campaign
SET Age_Group =
    CASE
        WHEN Calculated_Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Calculated_Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Calculated_Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Calculated_Age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END;
    
    
-- 12. AVERAGE VISITS BY AGE GROUP


SELECT
    Age_Group,
    ROUND(
        AVG(NumWebVisitsMonth),
        2
    ) AS Average_Monthly_Visits
FROM marketing_campaign
GROUP BY Age_Group
ORDER BY
    CASE Age_Group
        WHEN '18-25' THEN 1
        WHEN '26-35' THEN 2
        WHEN '36-45' THEN 3
        WHEN '46-55' THEN 4
        WHEN '56+' THEN 5
    END;    







