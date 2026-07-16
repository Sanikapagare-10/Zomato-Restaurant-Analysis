===========================================================
-- Project : Zomato Restaurant Analysis
-- Author  : Sanika Pagare
-- Database: zomato_db
-- ===========================================================

CREATE DATABASE IF NOT EXISTS zomato_db;
USE zomato_db;

-- ===========================================================
-- Query 1 : Total Number of Restaurants
-- ===========================================================

SELECT COUNT(*) AS Total_Restaurants
FROM zomato;

-- ===========================================================
-- Query 2 : Top 10 Highest Rated Restaurants
-- ===========================================================

SELECT
    name,
    location,
    rate
FROM zomato
WHERE rate NOT IN ('NEW','-')
ORDER BY CAST(REPLACE(rate,'/5','') AS DECIMAL(3,1)) DESC
LIMIT 10;

-- ===========================================================
-- Query 3 : Restaurants by Location
-- ===========================================================

SELECT
    location,
    COUNT(*) AS Total_Restaurants
FROM zomato
GROUP BY location
ORDER BY Total_Restaurants DESC;

-- ===========================================================
-- Query 4 : Online Order Availability
-- ===========================================================

SELECT
    online_order,
    COUNT(*) AS Restaurants
FROM zomato
GROUP BY online_order;

-- ===========================================================
-- Query 5 : Table Booking Availability
-- ===========================================================

SELECT
    book_table,
    COUNT(*) AS Restaurants
FROM zomato
GROUP BY book_table;

-- ===========================================================
-- Query 6 : Top Restaurant Types
-- ===========================================================

SELECT
    rest_type,
    COUNT(*) AS Total
FROM zomato
GROUP BY rest_type
ORDER BY Total DESC
LIMIT 10;

-- ===========================================================
-- Query 7 : Top Cuisines
-- ===========================================================

SELECT
    cuisines,
    COUNT(*) AS Total
FROM zomato
GROUP BY cuisines
ORDER BY Total DESC
LIMIT 10;

-- ===========================================================
-- Query 8 : Average Cost for Two by Location
-- ===========================================================

SELECT
    location,
    ROUND(AVG(approx_cost(for two people)),2) AS Average_Cost
FROM zomato
GROUP BY location
ORDER BY Average_Cost DESC
LIMIT 10;

-- ===========================================================
-- Query 9 : Highest Voted Restaurants
-- ===========================================================

SELECT
    name,
    votes
FROM zomato
ORDER BY votes DESC
LIMIT 10;

-- ===========================================================
-- Query 10 : Average Rating by Location
-- ===========================================================

SELECT
    location,
    ROUND(AVG(CAST(REPLACE(rate,'/5','') AS DECIMAL(3,1))),2) AS Average_Rating
FROM zomato
WHERE rate NOT IN ('NEW','-')
GROUP BY location
ORDER BY Average_Rating DESC
LIMIT 10;

-- ===========================================================
-- Query 11 : Restaurants with Online Order and Table Booking
-- ===========================================================

SELECT
    name,
    location
FROM zomato
WHERE online_order='Yes'
AND book_table='Yes';

-- ===========================================================
-- Query 12 : Restaurants Having Rating Above 4.5
-- ===========================================================

SELECT
    name,
    rate
FROM zomato
WHERE rate NOT IN ('NEW','-')
AND CAST(REPLACE(rate,'/5','') AS DECIMAL(3,1))>=4.5;

-- ===========================================================
-- Query 13 : Average Votes by Restaurant Type
-- ===========================================================

SELECT
    rest_type,
    ROUND(AVG(votes),2) AS Average_Votes
FROM zomato
GROUP BY rest_type
ORDER BY Average_Votes DESC;

-- ===========================================================
-- Query 14 : Restaurants by City Category
-- ===========================================================

SELECT
    listed_in(city),
    COUNT(*) AS Restaurants
FROM zomato
GROUP BY listed_in(city)
ORDER BY Restaurants DESC;

-- ===========================================================
-- Query 15 : Restaurants by Service Type
-- ===========================================================

SELECT
    listed_in(type),
    COUNT(*) AS Restaurants
FROM zomato
GROUP BY listed_in(type);

-- ===========================================================
-- Query 16 : Average Cost by Restaurant Type
-- ===========================================================

SELECT
    rest_type,
    ROUND(AVG(approx_cost(for two people)),2) AS Average_Cost
FROM zomato
GROUP BY rest_type
ORDER BY Average_Cost DESC;

-- ===========================================================
-- Query 17 : Top Costliest Restaurants
-- ===========================================================

SELECT
    name,
    approx_cost(for two people)
FROM zomato
ORDER BY approx_cost(for two people) DESC
LIMIT 10;

-- ===========================================================
-- Query 18 : Top Locations by Restaurant Count
-- ===========================================================

SELECT
    location,
    COUNT(*) AS Restaurant_Count
FROM zomato
GROUP BY location
ORDER BY Restaurant_Count DESC
LIMIT 10;

-- ===========================================================
-- Query 19 : Restaurants with Maximum Votes
-- ===========================================================

SELECT
    name,
    votes,
    location
FROM zomato
ORDER BY votes DESC
LIMIT 20;

-- ===========================================================
-- Query 20 : Average Rating by Restaurant Type
-- ===========================================================

SELECT
    rest_type,
    ROUND(AVG(CAST(REPLACE(rate,'/5','') AS DECIMAL(3,1))),2) AS Average_Rating
FROM zomato
WHERE rate NOT IN ('NEW','-')
GROUP BY rest_type
ORDER BY Average_Rating DESC;

-- ===========================================================
-- Query 21 : Top Locations by Average Votes
-- ===========================================================

SELECT
    location,
    ROUND(AVG(votes),2) AS Average_Votes
FROM zomato
GROUP BY location
ORDER BY Average_Votes DESC
LIMIT 10;

-- ===========================================================
-- Query 22 : Rating Category Distribution
-- ===========================================================

SELECT
CASE
    WHEN CAST(REPLACE(rate,'/5','') AS DECIMAL(3,1))>=4.5 THEN 'Excellent'
    WHEN CAST(REPLACE(rate,'/5','') AS DECIMAL(3,1))>=4.0 THEN 'Very Good'
    WHEN CAST(REPLACE(rate,'/5','') AS DECIMAL(3,1))>=3.5 THEN 'Good'
    ELSE 'Average'
END AS Rating_Category,
COUNT(*) AS Restaurants
FROM zomato
WHERE rate NOT IN ('NEW','-')
GROUP BY Rating_Category;

-- ===========================================================
-- Query 23 : Top Restaurant Chains
-- ===========================================================

SELECT
    name,
    COUNT(*) AS Number_of_Outlets
FROM zomato
GROUP BY name
ORDER BY Number_of_Outlets DESC
LIMIT 10;

-- ===========================================================
-- Query 24 : Restaurants Serving Multiple Cuisines
-- ===========================================================

SELECT
    name,
    cuisines
FROM zomato
WHERE cuisines LIKE '%,%'
LIMIT 10;

-- ===========================================================
-- Query 25 : Overall Dataset Summary
-- ===========================================================

SELECT
    COUNT(*) AS Total_Restaurants,
    COUNT(DISTINCT location) AS Total_Locations,
    COUNT(DISTINCT cuisines) AS Total_Cuisines,
    ROUND(AVG(votes),2) AS Average_Votes
FROM zomato;