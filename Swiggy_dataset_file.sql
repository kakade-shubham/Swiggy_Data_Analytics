SHOW DATABASES;

DROP DATABASE swiggy_analytics;
CREATE DATABASE IF NOT EXISTS Swiggy_Analytics;

USE Swiggy_Analytics;

SET GLOBAL local_infile = 1;

SHOW VARIABLES LIKE 'local_infile';

SHOW TABLES;


CREATE TABLE IF NOT EXISTS Swiggy_Data
(
	State VARCHAR(150),
    City VARCHAR(150),
    order_date DATE,
    Restaurant_Name VARCHAR(150),
    Location VARCHAR(150),
    Category VARCHAR(150),
    Dish_Name VARCHAR(255),
    Price DECIMAL(10,2),
    Rating DECIMAL(10,2),
    Rating_Count INT
);

DESCRIBE Swiggy_data;

-- Importing data locally due to large file size.

LOAD DATA INFILE "E:/Data Analysis/PowerBi/Project/Swiggy Data Analytis/Dataset/swiggy_all_menus_india.csv"
INTO TABLE swiggy_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(State, City, order_date, Restaurant_Name, Location, Category, Dish_Name, Price, Rating, Rating_Count);

SELECT * FROM swiggy_data;

SELECT COUNT(*) FROM Swiggy_Data;

-- Data Cleaning and Validation
-- Cheking Null Values

SELECT 
	SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS Check_Null_State,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS Check_Null_City,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS Check_Null_order_date,
    SUM(CASE WHEN Restaurant_Name IS NULL THEN 1 ELSE 0 END) AS Check_Null_Restaurant_Name,
    SUM(CASE WHEN Location IS NULL THEN 1 ELSE 0 END) AS Check_Null_Location,
    SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS Check_Null_Category,
    SUM(CASE WHEN Dish_Name IS NULL THEN 1 ELSE 0 END) AS Check_Null_Dish_Name,
    SUM(CASE WHEN Price IS NULL THEN 1 ELSE 0 END) AS Check_Null_Price,
    SUM(CASE WHEN Rating IS NULL THEN 1 ELSE 0 END) AS Check_Null_Rating,
    SUM(CASE WHEN Rating_Count IS NULL THEN 1 ELSE 0 END) AS Check_Null_Rating_Count
FROM Swiggy_data;

SELECT COUNT(*) FROM swiggy_data;

-- Cheking Blank or Empty String
-- This query is valid only for measure values not for dimention values (e.g. order_date,price,rating,rating_count)

SELECT *
FROM Swiggy_data
WHERE State = '' OR
	City = '' OR
	Restaurant_Name = '' OR
	Location = '' OR
    Category = '' OR
    Dish_Name = '';
    
-- Cheking Duplicate values

SELECT State, City, order_date, Restaurant_Name, Location, 
	Category, Dish_Name, Price, Rating, Rating_Count, COUNT(*) AS Total_Count
FROM Swiggy_data
GROUP BY State, City, order_date, Restaurant_Name, Location, 
	Category, Dish_Name, Price, Rating, Rating_Count
HAVING COUNT(*) > 1;

-- OR

SELECT COUNT(*) - COUNT(DISTINCT 
    State, City, order_date,
    Restaurant_Name, Location,
    Category, Dish_Name,
    Price, Rating, Rating_Count
) AS duplicate_rows
FROM Swiggy_data;

/*
If data has duplicate rows then we remove then one occurrance. As MySQL doesn’t support DELETE from CTE, so i just handled duplicate 
records using Surrogate/temparary key for identification. (Follow below 4 steps)
*/

-- step 1) Adding a temp primary key
ALTER TABLE Swiggy_Data
ADD COLUMN Row_id INT AUTO_INCREMENT PRIMARY KEY;

-- step 2) Delete duplicate rows (higher rwo id in each group)
DELETE FROM Swiggy_Data
WHERE Row_id NOT IN (
	SELECT Minimum_id FROM (
		SELECT MIN(Row_id) AS Minimum_id
        FROM Swiggy_Data
        GROUP BY State, City, order_date, Restaurant_Name, Location, 
				  Category, Dish_Name, Price, Rating, Rating_Count
		) AS Keep_ids
);

-- Step 3) verify the data again (it should bee 0) 

-- step 4) Drop temparary created column
ALTER TABLE Swiggy_Data
DROP COLUMN Row_id;


-- Creating Schemas
-- Dimention Table Date

CREATE TABLE IF NOT EXISTS Dimention_Date
(
	Date_id INT AUTO_INCREMENT PRIMARY KEY,
    Full_Date DATE,
    Year INT,
    Month INT,
    Month_Name VARCHAR(30),
    Quarter INT,
    Day INT,
    Week INT
);

-- Dimention Table Location

CREATE TABLE IF NOT EXISTS Dimention_Location
(
	Location_id INT AUTO_INCREMENT PRIMARY KEY,
    State VARCHAR(50),
    City VARCHAR(50),
    Location VARCHAR(200)
);

-- Dimention Table Restaurant

CREATE TABLE IF NOT EXISTS Dimention_Restaurant
(
	Restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    Restaurant_Name VARCHAR(200)
);

-- Dimention Table Category

CREATE TABLE IF NOT EXISTS Dimention_Category
(
	Category_id INT AUTO_INCREMENT PRIMARY KEY,
    Category VARCHAR(200)
);

-- Dimention Table Dishes

CREATE TABLE IF NOT EXISTS Dimention_Dishes
(
	Dish_id INT AUTO_INCREMENT PRIMARY KEY,
    Dish_Name VARCHAR(200)
);

-- Fact Table Swiggy_orders

CREATE TABLE IF NOT EXISTS Fact_Swiggy_Orders
(
	Order_id INT AUTO_INCREMENT PRIMARY KEY,
    
    Date_id INT,
    Price DECIMAL(10,2),
    Rating DECIMAL(5,1),
    Rating_Count INT,
    
    Location_id INT,
    Restaurant_id INT,
	Category_id INT,
    Dish_id INT,
    
    CONSTRAINT FK_SwiOrd_DimDate FOREIGN KEY(Date_id) REFERENCES Dimention_Date(Date_id),
    CONSTRAINT FK_SwiOrd_DimLoc FOREIGN KEY(Location_id) REFERENCES Dimention_Location(Location_id),
    CONSTRAINT FK_SwiOrd_DimRest FOREIGN KEY(Restaurant_id) REFERENCES Dimention_Restaurant(Restaurant_id),
    CONSTRAINT Fk_SwiOrd_DimCate FOREIGN KEY(Category_id) REFERENCES Dimention_Category(Category_id),
    CONSTRAINT FK_SwiOrd_DimDish FOREIGN KEY(Dish_id) REFERENCES Dimention_Dishes(Dish_id)
);

SELECT * FROM dimention_category;
SELECT COUNT(*) FROM dimention_category;

SELECT * FROM dimention_date;
SELECT COUNT(*) FROM dimention_date;

SELECT * FROM dimention_dishes;
SELECT COUNT(*) FROM dimention_dishes;

SELECT * FROM dimention_location;
SELECT COUNT(*) FROM dimention_location;

SELECT * FROM dimention_restaurant;
SELECT COUNT(*) FROM dimention_restaurant;

SELECT * FROM Fact_swiggy_orders;
SELECT COUNT(*) FROM Fact_swiggy_orders;

SELECT * FROM swiggy_data;
SELECT COUNT(*) FROM swiggy_data;

-- Inserting Data into the Dimention Tables
-- Dimention_Date

INSERT INTO Dimention_Date (Full_Date,Year,Month,Month_Name,Quarter,Day,Week)
SELECT DISTINCT Order_Date,
	YEAR(Order_Date),
    Month(Order_Date),
    DATE_FORMAT(Order_Date, '%M'),
    QUARTER(Order_Date),
    DAY(Order_Date),
    Week(Order_Date)
FROM Swiggy_data
WHERE Order_Date IS NOT NULL;


-- Dimention_Location

INSERT INTO Dimention_Location (State,City,Location)
SELECT DISTINCT State,
	City,
    Location
FROM Swiggy_Data;

-- Dimention_Restaurant

INSERT INTO Dimention_Restaurant (Restaurant_Name)
SELECT DISTINCT Restaurant_Name
FROM Swiggy_Data;

-- Dimention_Category

INSERT INTO Dimention_Category (Category)
SELECT DISTINCT Category
FROM Swiggy_data;

-- Dimention_dishes

INSERT INTO Dimention_dishes (Dish_Name)
SELECT DISTINCT Dish_Name
FROM Swiggy_Data;

-- Inserting Data into the Fact Tables
-- Fact_Swiggy_Orders

INSERT INTO Fact_Swiggy_Orders
(
	Date_id,
    Price,
    Rating,
    Rating_Count,
    Location_id,
    Restaurant_id,
    Category_id,
    Dish_id
)
SELECT
	Dim_date.Date_id,
	sw_data.Price,
    sw_data.Rating,
    sw_data.Rating_Count,
    Dim_Loc.Location_id,
    Dim_Rest.Restaurant_id,
    Dim_Cate.Category_id,
    Dim_Dish.Dish_id
FROM Swiggy_Data AS sw_data

-- Joining Dimention_Date table
INNER JOIN Dimention_Date AS Dim_date
ON Dim_date.Full_Date = sw_data.order_date

-- Joining Dimention_Location table
INNER JOIN Dimention_Location AS Dim_Loc
ON Dim_Loc.State = sw_data.state
AND Dim_Loc.City = sw_data.City
AND Dim_Loc.Location = sw_data.Location

-- Joining Dimention_Restaurant table. (Trim() fun use for data consistancy)
INNER JOIN Dimention_Restaurant AS Dim_Rest
ON TRIM(LOWER(Dim_Rest.Restaurant_Name)) = TRIM(LOWER(sw_data.Restaurant_Name))

-- Joining Dimention_Category table
INNER JOIN Dimention_Category AS Dim_Cate
ON Dim_Cate.Category = sw_data.Category

-- Joining Dimention_Dishes table
INNER JOIN Dimention_Dishes AS Dim_Dish
ON Dim_Dish.Dish_Name = sw_data.Dish_Name;

-- Incresing time limit to upload the Fact table data, as data size is big.
SET GLOBAL net_read_timeout = 600;
SET GLOBAL net_write_timeout = 600;
SET GLOBAL wait_timeout = 600;
SET GLOBAL interactive_timeout = 600;

-- To see data in all tables
SELECT *
FROM Fact_swiggy_orders AS F
INNER JOIN Dimention_Category AS Dim_Cate
ON Dim_Cate.Category_id = F.Category_id
INNER JOIN Dimention_Date AS Dim_Date
ON Dim_Date.Date_id = F.Date_id
INNER JOIN Dimention_Dishes AS Dim_Dish
ON Dim_Dish.Dish_id = F.Dish_id
INNER JOIN Dimention_Location AS Dim_Loc
ON Dim_Loc.Location_id = F.Location_id
INNER JOIN Dimention_Restaurant AS Dim_Rest
ON Dim_Rest.Restaurant_id = F.Restaurant_id;


-- Basic KPI's

-- Total Orders
SELECT COUNT(*) AS Total_Count
FROM Fact_Swiggy_Orders;

-- Total Revenue
	SELECT CONCAT('₹',"",FORMAT(SUM(Price),2, 'en_IN')) AS Total_Revenue
	FROM Fact_Swiggy_Orders;

-- Average Dish Price
SELECT CONCAT('₹','',ROUND(AVG(Price),2)) AS Avg_Dish_Price
FROM Fact_Swiggy_Orders;

-- Average Rating
SELECT ROUND(AVG(Rating),1) AS Avg_Rating
FROM Fact_Swiggy_Orders;


-- Deep-Dive into Analysis
-- Date-Based Analysis
-- Monthly Order Trends and Revenue:

SELECT 
	Dim_Date.Year,
    Dim_Date.Month,
    Dim_Date.Month_Name,
    COUNT(*) AS Total_Orders,
	CONCAT('₹',' ',FORMAT(SUM(Price),2,'en_IN')) AS Total_Revenue
FROM Fact_Swiggy_Orders AS F
INNER JOIN Dimention_Date AS Dim_Date
ON Dim_Date.Date_id = F.Date_id
GROUP BY 
	Dim_Date.Year,
	Dim_Date.Month,
    Dim_Date.Month_Name
ORDER BY 
	Total_Orders DESC;

-- Quarterly order trends

SELECT
	Dim_Date.Year,
    Dim_Date.Quarter,
    COUNT(*) AS Total_Orders
FROM Fact_Swiggy_Orders AS F
INNER JOIN Dimention_Date AS Dim_Date
ON Dim_Date.Date_id = F.Date_id
GROUP BY 
	Dim_Date.Year,
	Dim_Date.Quarter
ORDER BY Total_Orders DESC;


-- Year-wise growth
SELECT
	Dim_Date.Year,
    FORMAT(COUNT(*),2,'en_IN') AS Total_Orders
FROM Fact_Swiggy_Orders AS F
INNER JOIN Dimention_Date AS Dim_Date
ON Dim_Date.Date_id = F.Date_id
GROUP BY Dim_Date.Year;

-- Day-of-week patterns
SELECT
	DAYNAME(Full_Date) AS Day_Name,
    COUNT(*) AS Total_Orders
FROM Fact_Swiggy_Orders AS F
INNER JOIN Dimention_Date AS Dim_Date
ON Dim_Date.Date_id = F.Date_id
GROUP BY Day_Name, DAYOFWEEK(Full_Date)
ORDER BY DAYOFWEEK(Full_Date);

-- Weekend vs Weekday analysis
SELECT CASE
	WHEN DAYOFWEEK(Dim_Date.Full_Date) IN(1,7) THEN "WeekEnd"
    ELSE "WeekDay"
    END AS Day_Type,
    COUNT(*) AS Total_Orders,
    FORMAT(SUM(F.Price),2,'en_IN') AS Total_Revenue,
    ROUND(AVG(F.Price),1) AS Avg_Order_Value
FROM Fact_Swiggy_Orders AS F
INNER JOIN Dimention_Date AS Dim_Date
ON Dim_Date.Date_id = F.Date_id
GROUP BY Day_Type
ORDER BY Total_Orders DESC;


-- Location based analysis
-- Top 10 Cities by order volume and revenue

SELECT
	Dim_Loc.City,
    COUNT(*) AS Total_Orders,
    FORMAT(SUM(Price),2,'en_IN') AS Total_Revenue
FROM Fact_Swiggy_Orders AS F
INNER JOIN Dimention_Location AS Dim_Loc
ON Dim_Loc.Location_id = F.Location_id
GROUP BY Dim_Loc.City 
ORDER BY Total_Orders DESC
LIMIT 10;

-- Revenue contribution by states
SELECT
	Dim_Loc.State,
    SUM(Price) AS Total_Revenue
FROM Fact_Swiggy_Orders AS F
INNER JOIN Dimention_Location AS Dim_Loc
ON Dim_Loc.Location_id = F.Location_id
GROUP BY Dim_Loc.State
ORDER BY Total_Revenue DESC 
LIMIT 10;


-- Food Performance
-- Top 10 Restaurant by Orders
SELECT
	Dim_Rest.Restaurant_Name,
    SUM(Price) AS Total_Revenue
FROM Fact_Swiggy_Orders AS F
INNER JOIN Dimention_Restaurant AS Dim_Rest
ON Dim_Rest.Restaurant_id = F.Restaurant_id
GROUP BY Dim_Rest.Restaurant_Name
ORDER BY Total_Revenue DESC
LIMIT 10;

-- Top Categories by orders
SELECT
	Dim_Cate.Category,
    COUNT(*) AS Total_Orders
FROM Fact_Swiggy_Orders AS F
INNER JOIN Dimention_Category AS Dim_Cate
ON Dim_Cate.Category_id = F.Category_id
GROUP BY Dim_Cate.Category
ORDER BY Total_Orders DESC
LIMIT 10;

-- Top Order dishes
SELECT 
	Dim_dish.Dish_Name,
    COUNT(*) AS Total_Count
FROM Fact_Swiggy_Orders AS F
INNER JOIN Dimention_Dishes AS Dim_Dish
ON Dim_Dish.Dish_id = F.Dish_id
GROUP BY Dim_Dish.Dish_Name
ORDER BY Total_Count DESC
LIMIT 10;


-- Dish Performance (Orders + Avg Rating)
SELECT
	Dim_Dish.Dish_Name,
    COUNT(*) AS Total_Orders,
    ROUND(AVG(Rating),1) AS Avg_Rating
FROM Fact_Swiggy_Orders AS F
INNER JOIN Dimention_Dishes AS Dim_Dish
ON Dim_Dish.Dish_id = F.Dish_id
GROUP BY Dim_Dish.Dish_Name
ORDER BY Total_Orders DESC
LIMIT 10;


-- Customer Spending Analysis
-- (Total Customer Spend with total order distribution across these ranges)
-- Below 100
-- Between 100 - 199 (Inclusive)
-- Between 200 - 299 (Inclusive)
-- Between 300 - 499 (Inclusive)
-- Above 500+ 

SELECT 
	CASE
		WHEN Price < 100 THEN 'Below 100'
		WHEN Price BETWEEN 100 AND 199 THEN '100 - 199'
		WHEN Price BETWEEN 200 AND 299 THEN '200 - 299'
		WHEN Price BETWEEN 300 AND 499 THEN '300 - 499'
		ELSE 'Above 500'
	END AS Prise_Range,
    COUNT(*) AS Total_Orders
FROM Fact_Swiggy_Orders
GROUP BY
	CASE
		WHEN Price < 100 THEN 'Below 100'
		WHEN Price BETWEEN 100 AND 199 THEN '100 - 199'
		WHEN Price BETWEEN 200 AND 299 THEN '200 - 299'
		WHEN Price BETWEEN 300 AND 499 THEN '300 - 499'
		ELSE 'Above 500'
	END
ORDER BY Total_Orders DESC;


-- Dish Rating Distribution (between 1 to 5)
SELECT 
	Rating,
    COUNT(*) AS Total_Rating_Count
FROM Fact_Swiggy_Orders
GROUP BY Rating
ORDER BY Rating DESC;