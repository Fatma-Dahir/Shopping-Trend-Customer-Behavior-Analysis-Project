-- DATA CLEANING
-- Check for duplicates
SELECT Customer_ID, COUNT(*)
FROM sales_info
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

-- STANDARDIZE DATA
-- Check if any trim is required or misspelt words and Modify
SELECT DISTINCT Item_Purchased
FROM sales_info
ORDER BY 1;

SELECT DISTINCT Category
FROM sales_info
ORDER BY 1;

SELECT DISTINCT Location
FROM sales_info
ORDER BY 1;

SELECT DISTINCT Color
FROM sales_info
ORDER BY 1;

SELECT DISTINCT Season
FROM sales_info
ORDER BY 1;

SELECT DISTINCT Payment_Method
FROM sales_info
ORDER BY 1;

SELECT DISTINCT Location
FROM sales_info
ORDER BY 1;

SELECT DISTINCT Shipping_Type
FROM sales_info
ORDER BY 1;

SELECT DISTINCT PreferredPayment_Method
FROM sales_info
ORDER BY 1;

-- DATA ANALYSIS
-- CUSTOMER BEHAVIOR ANALYSIS
-- How many unique customers are there
SELECT COUNT(DISTINCT Customer_ID) as Customers_Count
FROM sales_info;

-- What is the overall distribution of customer ages in the dataset?
SELECT ROUND(AVG(Age),0) AS Avg_age
FROM sales_info;

-- What is the mode of the age values?
SELECT age, COUNT(*) AS frequency
FROM sales_info
GROUP BY age
ORDER BY frequency DESC
LIMIT 1;

-- Which gender has the highest Total Sales Amount
SELECT Gender, SUM(PurchasedAmount_USD) AS Total_sales
FROM sales_info
GROUP BY Gender
ORDER BY Total_sales DESC;

-- Which gender has the highest number of purchases
SELECT Gender, COUNT(Gender) AS Number_of_Purchases
FROM sales_info
GROUP BY Gender
ORDER BY Number_of_Purchases DESC;

-- Which Age Category has the highest number of purchases and Total Sales
-- First Add a new column Age_Category to categorize the ages 
ALTER TABLE sales_info
ADD COLUMN Age_Category VARCHAR(20) AFTER Age;

UPDATE sales_info
SET Age_Category = CASE 
                   WHEN Age < 13 THEN 'Child'
                   WHEN Age BETWEEN 13 AND 19 THEN 'Teenager'
                   WHEN age BETWEEN 20 AND 35 THEN 'Young Adult'
				   WHEN age BETWEEN 36 AND 55 THEN 'Adult'
                   ELSE 'Senior'
                   END;
                   
SELECT Age_Category, COUNT(*) as Number_of_Purchases, SUM(PurchasedAmount_USD) AS Total_Sales
FROM sales_info
GROUP BY Age_Category
ORDER BY Number_of_Purchases DESC, Total_Sales DESC;

-- How does the frequency of purchases vary across different age groups?
SELECT Age_Category, SUM(CASE WHEN FrequencyOf_Purchases = 'Weekly' THEN 1 ELSE 0 END) AS Weekly,
					 SUM(CASE WHEN FrequencyOf_Purchases = 'Bi-Weekly' THEN 1 ELSE 0 END) AS Bi_Weekly,
                     SUM(CASE WHEN FrequencyOf_Purchases = 'Fortnightly' THEN 1 ELSE 0 END) AS Fortnightly,
					 SUM(CASE WHEN FrequencyOf_Purchases = 'Quarterly' THEN 1 ELSE 0 END) AS Quarterly,
                     SUM(CASE WHEN FrequencyOf_Purchases = 'Every 3 Months' THEN 1 ELSE 0 END) AS Every_3_Months,
                     SUM(CASE WHEN FrequencyOf_Purchases = 'Annually' THEN 1 ELSE 0 END) AS Annually
FROM sales_info
GROUP BY Age_Category
ORDER BY Weekly DESC ;

-- Most common to least common interval between purchases (ordering frequency_of_purchases)
SELECT FrequencyOf_Purchases, COUNT(FrequencyOf_Purchases) AS Count_of_Frequency
FROM sales_info
GROUP BY FrequencyOf_Purchases
ORDER BY Count_of_Frequency DESC;

-- Are there any specific colors that are more popular among customers?
SELECT Color, COUNT(*) AS Customer_Count
FROM sales_info
GROUP BY Color
ORDER BY Customer_Count DESC;

-- What are the number of customers that purchased with a subscription vs. without
SELECT Subscription_Status, COUNT(*) AS Customer_Count
FROM sales_info
GROUP BY Subscription_Status
ORDER BY Customer_Count DESC;

-- How many subscribed customers use discounts vs unsubscribed?
SELECT Subscription_Status,Discount_Applied, COUNT(Discount_Applied) AS Discounted_Customers
FROM sales_info
GROUP BY Discount_Applied,Subscription_Status;

-- PRODUCTS ANALYSIS
-- How many distinct items and categories are sold?
SELECT COUNT(DISTINCT Item_purchased) as Items, COUNT(DISTINCT Category) as Categories
FROM sales_info;

-- Check the Items and categories names
SELECT DISTINCT Item_purchased
FROM sales_info;

SELECT DISTINCT Category
FROM sales_info;

-- How does the average purchase amount vary across different product categories?
SELECT Category, ROUND(AVG(PurchasedAmount_USD),2) AS Average_PurchasedAmount
FROM sales_info
GROUP BY Category;

-- Which category has the most number of purchases and Total_Sales?
SELECT Category, COUNT(*) AS Number_of_Purchases, SUM(PurchasedAmount_USD) AS Total_Sales
FROM sales_info
GROUP BY Category
ORDER BY Total_Sales DESC, Number_of_Purchases DESC;

-- What are the most commonly purchased items in each category?
WITH CTE_rank AS
(
SELECT Item_Purchased, Category, COUNT(Item_Purchased) AS Item_count, ROW_NUMBER() OVER(PARTITION BY Category ORDER BY COUNT(Item_Purchased) DESC) AS row_num
FROM sales_info
GROUP BY Item_Purchased, Category
)
SELECT Item_Purchased, Category,Item_count, row_num
FROM CTE_rank
WHERE row_num = 1;

--  Are there any correlations between the size of the product and the purchase amount?
SELECT Size, COUNT(*) AS Customer_Count
FROM sales_info
GROUP BY Size
ORDER BY Customer_Count DESC;

-- Which shipping type is preferred by customers for different product categories?
SELECT Category, Shipping_Type, COUNT(*) AS Customer_Count
FROM sales_info
GROUP BY Category, Shipping_Type
ORDER BY Customer_Count DESC;

-- What are the top 5 Product Category & Items' Average Ratings?
SELECT Category, Item_Purchased, ROUND(AVG(Review_Rating),2) AS Average_rating
FROM sales_info
GROUP BY Category, Item_Purchased
ORDER BY Average_rating DESC
LIMIT 5;

-- What are the bottom 5 Product Category & Items' Average Ratings?
SELECT Category, Item_Purchased, ROUND(AVG(Review_Rating),2) AS Average_rating
FROM sales_info
GROUP BY Category, Item_Purchased
ORDER BY Average_rating ASC
LIMIT 5;

-- What are the General Category Average Ratings?
SELECT Category, ROUND(AVG(Review_Rating),2) AS Average_rating
FROM sales_info
GROUP BY Category
ORDER BY Average_rating DESC
LIMIT 5;

-- SALES AND MARKETING ANALYSIS
-- Which season has the most number of purchases and Total Sales?
SELECT Season, COUNT(*) AS Number_of_Purchases, SUM(PurchasedAmount_USD) AS Total_Sales
FROM sales_info
GROUP BY Season
ORDER BY Total_Sales DESC, Number_of_Purchases DESC;

-- What are the seasonal sales by category?
SELECT Season,Category, SUM(PurchasedAmount_USD) AS Total_Sales
FROM sales_info
GROUP BY Season, Category
ORDER BY Season, Total_Sales DESC;

-- Which payment method is the most popular among customers?
SELECT Payment_Method, COUNT(*) AS Number_of_Customers
FROM sales_info
GROUP BY Payment_Method
ORDER BY Number_of_Customers DESC ;

-- Are there any notable differences in purchase behavior between subscribed and non-subscribed customers?
SELECT Subscription_Status, COUNT(Subscription_Status) as CustomerPurchase_Count
FROM sales_info
GROUP BY Subscription_Status
ORDER BY CustomerPurchase_Count;

-- Do customers who use promo codes tend to spend more than those who don't?
SELECT PromoCode_Used, Gender, SUM(PurchasedAmount_USD) AS Total_Sales
FROM sales_info
GROUP BY PromoCode_Used, Gender
ORDER BY Total_Sales DESC;

-- What is the Popularity of shipping types & Impact on sales?
SELECT Shipping_Type, COUNT(*) AS Number_of_Customers, 
	   SUM(PurchasedAmount_USD) AS Total_Sales
  FROM sales_info
 GROUP BY Shipping_Type
 ORDER BY Number_of_customers DESC, Total_Sales DESC;

-- How does the presence of a discount affect the purchase decision of customers?
SELECT Discount_Applied, Gender, COUNT(*) as Number_of_Purchases
FROM sales_info
GROUP BY Discount_Applied, Gender;

-- Are there any noticeable differences in purchase behavior between different locations? 
SELECT Location, COUNT(*) AS Customer_Count
FROM sales_info
GROUP BY Location
ORDER BY Customer_Count DESC;

-- How does the average purchase amount AND total purchased amount differ between male and female customers?
SELECT Gender, SUM(PurchasedAmount_USD) AS Total_PurchasedAmount, ROUND(AVG(PurchasedAmount_USD),2) AS Average_PurchasedAmount
FROM sales_info
GROUP BY Gender;

-- Add a new column Average_PurchasedAmount for the calculated average purchased amount per gender
ALTER TABLE sales_info
ADD COLUMN Average_PurchasedAmount FLOAT AFTER PurchasedAmount_USD;

WITH CTE AS
(
SELECT Gender, ROUND(AVG(PurchasedAmount_USD),2) AS Average_PurchasedAmount
FROM sales_info
GROUP BY Gender
)

UPDATE tdi_project.sales_info
JOIN CTE
ON sales_info.Gender = CTE.Gender
SET sales_info.Average_PurchasedAmount =CTE.Average_PurchasedAmount;




