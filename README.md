# 📊 Shopping-Trend-Customer-Behavior-Analysis-Project

## Table of Contents
- [Project Overview](#project-overview)
- [Data Sources](#data-sources)
- [Tools](#tools)
- [Data Cleaning](#data-cleaning)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Results and Findings](#results-and-findings)
- [Recommendations](#recommendations)

## Project Overview
This project involves analysis of Shopping Trends & Customer Behavior Analysis for Marc, a retailer of clothing, footwear, outerwear, accessories. It includes data cleaning, exploratory analysis and visualizations to uncover insights across demographics, product categories & seasonal trends, aiming to optimize sales strategies & enhance customer engagement. Advanced SQL techniques were used for data cleaning and analysis, while Microsoft Power BI was utilized for visualization, creating dynamic and interactive dashboards that highlight shopping trends, customer behavior, and product performance.

![Dashboard](https://github.com/user-attachments/assets/d2b69ec8-81ca-4157-818f-508cd07a251c)

## Data Sources
The data for this project was sourced from Kaggle. You can access the dataset [here](https://www.kaggle.com/code/kyleakepanidtaworn/dtsa5304-customer-segment-and-shopping-pattern/input?select=shopping_trends.csv).

## Tools
- MySQL Workbench - Data Cleaning and Analysis [Download Here](https://dev.mysql.com/downloads/installer/)
- Microsoft Power BI - Data Visualization [Download Here](https://www.microsoft.com/)

## Data Cleaning
In this phase, I performed the following tasks:
1. Imported the Data into MySQL Workbench using the Import Table Wizard
2. Checked for null values and duplicate records, ensuring data quality
3. Standardized the data for consistency and analysis

## Exploratory Data Analysis
I used SQL to conduct the following analyses on the data:

**1.	Customer Behavior Analysis**
- How many distinct customers are there?
- What is the overall distribution of customer ages in the dataset?
- Which gender has the highest total sales amount?
- Which age category has the highest number of purchases and total sales?
- How does the frequency of purchases vary across different age categories?
- What is the most common to least common interval between purchases?
- Are there any specific colors that are more popular among customers?
- What are the number of customers that purchased with a subscription vs. without?
- How many subscribed customers use discounts vs unsubscribed?

**2.	Product Performance Analysis**
- How many distinct items and categories are sold?
- How does the average purchase amount vary across different product categories?
- Which category has the most number of purchases and total sales?
- What are the most commonly purchased items in each category?
- Are there any correlations between the size of the product and the purchase amount?
- Which shipping type is preferred by customers for different product categories?
- What are the top 5 and bottom 5 product category & Items based on average ratings?
- What are the General Category Average Ratings?

**3.	Sales and Marketing Anaysis**
- Which season has the most number of purchases and Total Sales?
- What are the seasonal sales by category?
- Are there any noticeable differences in purchase behavior between different locations?
- Which payment method is the most popular among customers?
- Are there any notable differences in purchase behavior between subscribed and non-subscribed customers?
- Do customers who use promo codes tend to spend more than those who don't?
- What is the popularity of shipping types & Impact on sales?
- How does the presence of a discount influence the purchase decision of male and female customers?

Below are some of the SQL queries executed to extract insights from the data:
- This SQL query returns the most commonly purchased items in each category
```sql
WITH CTE_rank AS
(
SELECT Item_Purchased, Category, COUNT(Item_Purchased) AS Item_count, ROW_NUMBER() OVER(PARTITION BY Category ORDER BY COUNT(Item_Purchased) DESC) AS row_num
FROM sales_info
GROUP BY Item_Purchased, Category
)
SELECT Item_Purchased, Category, Item_count, row_num
FROM CTE_rank
WHERE row_num = 1;
```
- This SQL query returns the frequency of purchases across different age groups
```sql
SELECT Age_Category, SUM(CASE WHEN FrequencyOf_Purchases = 'Weekly' THEN 1 ELSE 0 END) AS Weekly_Customers,
                     SUM(CASE WHEN FrequencyOf_Purchases = 'Bi-Weekly' THEN 1 ELSE 0 END) AS Bi_Weekly_Customers,
                     SUM(CASE WHEN FrequencyOf_Purchases = 'Fortnightly' THEN 1 ELSE 0 END) AS Fortnightly_Customers,
                     SUM(CASE WHEN FrequencyOf_Purchases = 'Quarterly' THEN 1 ELSE 0 END) AS Quarterly_Customers,
                     SUM(CASE WHEN FrequencyOf_Purchases = 'Every 3 Months' THEN 1 ELSE 0 END) AS Every_3_Months_Customers,
                     SUM(CASE WHEN FrequencyOf_Purchases = 'Annually' THEN 1 ELSE 0 END) AS Annual_Customers
FROM sales_info
GROUP BY Age_Category
ORDER BY Weekly_Customers DESC ;
```

## Results and Findings
- There was a total of 3900 purchases made and total sales was $233,081.
- There were 4 distinct product categories(Clothing, Footwear, Outerwear, Accessories) having 25 items.
- There were 50 distinct locations where customers made purchases.
- The overall distribution of customer ages in the dataset exhibits an average age of 44 years and a mode at 69 years
  
**Sales and Number of Purchases by Gender**
- Total Sales amount for Male is $157,890 which is  higher than Female $75,191 making it 67.74% of  the Sales Amount.
- Males made the most number of purchases, a total of 2652 while Females made 1248.

**Sales and Number of Purchases by Product Category and Items**
- Clothing had the highest total sales of $104,264 and highest total number of Purchases at 1737, followed by Accessories at 1240 , Footwear at 599, and Outerwear at 324.
- Outerwear has the lowest total sales of $18,524 and lowest total number of purchases at 324.
- The average purchase amount remained relatively consistent across all categories, with only minor variations in spending.

**Sales by Age Group and Product Category**
- Adults lead in total sales, particularly in Clothing with $38,421 and 640 purchases, followed by Accessories ($28,088) and Footwear ($14,930).
- Seniors have strong sales in Accessories ($21,102) and Clothing ($29,680), though with fewer purchases than Adults.
- Young Adults show similar purchasing patterns, especially in Clothing ($31,966) and Accessories ($22,475).
- Teenagers contribute the least to sales across all categories, with a total of $2,535 in Accessories and $4,197 in Clothing.
- Adults in Product Category Clothing made up 16.41% of Number of Purchases.
  
**Most Commonly Purchased Items in each Category**
- Accessories Category: The most commonly purchased item in the Accessories category is jewelry. 
- Clothing Category: Within the Clothing category, the most commonly purchased item is blouse. 
- Footwear Category: The most commonly purchased item in the Footwear category is sandals.
- Outerwear Category: The most commonly purchased item in the Outerwear category is jacket.

**Seasonal Sales Performance**
- Fall is the top season, achieving the highest total sales at $60,018.
- Spring and Winter have nearly identical sales ($58,679 and $58,607, respectively), while Summer has the lowest sales at $55,777.
- In all seasons, Clothing category was leading in sales.

**Purchase Behavior between different Locations**
- Based on the analysis, there are no significant differences in purchase behavior across locations. All locations show nearly identical total purchases, with no notable variations.

**Correlation between the Size of the Product and the Number of Purchases**
- Size M had the most purchases, with a total of 1755, followed by Size L with 1053 purchases.

**Color Preference**
- Olive emerged as the most popular color, with 177 purchases, followed closely by Yellow at 174 purchases and Silver with 173 purchases.

**Frequency of Purchases across different Age Groups**
- Frequency of purchases varied across different age groups, with the adult category (Ages 36-55) exhibiting the highest frequency of purchases.
- The most common interval between purchases is Every 3 months having a total of 584 purchases.
  
**Payment Method by Popularity**
- Credit Card: 696 purchases
- Venmo: 653 purchases
- Cash: 648 purchases
- PayPal: 638 purchases
- Debit Card: 633 purchases
- Bank Transfer: 632 purchases
  
**Popularity of Shipping Types & Impact on Sales**
- Free Shipping was the most popular shipping method and had the highest sales of $40,777.
- Express shipping wasn't as popular but had the 2nd highest sales of $ 39067.
- The preferred shipping type for the clothing category is standard shipping.
- For the accessories category, store pickup shipping is the preferred option.
- Free shipping is the preferred shipping type for the footwear and outerwear categories.

**Subscription Status, Discount Applied, Promo Codes**
- Unsubscribed customers made the most purchases, a total of 2847 while Subscribed made 1053.
- Unsubscribed customers with no discount applied in their purchases are leading with 2223 number of purchases. 
- Customers who used promo codes spend more than those who don’t.
- Males who used promo code are the leading in sales with $99411.
- Female customers  don’t use promo code and discounts in their purchases, the statistics show only male customers using.

**General Category Average Ratings**
- The average rating given by customers for each product category is consistent across all categories, with minimal variations.

## Recommendations
**Gender-Based Strategies**
- Target Male Customers: With higher sales and purchases, tailor campaigns to engage male customers, especially in clothing and accessories.
- Engage Female Customers: Offer discounts and promotions to encourage more purchases and promo code usage among females.

**Focus on High-Performing Categories**
- Prioritize Clothing: Drive sales through seasonal promotions, especially on popular items like blouses.
- Promote Accessories: Bundle accessories with clothing to boost sales, particularly in jewelry and handbags.
- Boost Outerwear sales: Consider offers like "Buy One Get One Free" to increase outerwear sales.

**Age Group Targeting**
- Leverage Adults & Seniors: Offer targeted promotions on clothing and accessories for adults and seniors.
- Engage Younger Audiences: Create youth-oriented marketing strategies (e.g., influencer campaigns) to increase sales among teenagers and young adults.

**Seasonal Sales Strategies**
- Capitalize on Fall: Introduce fall-specific promotions to increase sales.
- Optimize for Spring & Winter: Target adults and seniors with seasonal clothing and accessory offers.
- Improve Summer Sales: Adjust summer offerings to boost competitiveness.

**Size Preferences**
- Stock More of Popular Sizes: Ensure sizes like M are always well-stocked and promoted.

**Color Preferences**
- Focus on Popular Colors: Promote colors like olive, yellow, and silver to increase sales.

**Location-Based Strategy**
- Optimize Online Sales: Focus on e-commerce marketing, as no significant location-based differences were observed.

**Payment Methods**
- Promote Credit Cards & Venmo: Encourage these popular payment options through incentives.

**Subscription & Promo Codes**
- Boost Subscriptions: Offer exclusive perks for subscribed customers.
- Leverage Promo Codes: Target females with tailored promo code offers to increase their usage.

**Optimize Shipping**
- Enhance Free Shipping: Highlight free shipping offers and expand for larger orders or specific categories.
- Tailor Shipping by Category: Focus on customer preferences (e.g., store pickup for accessories, free shipping for footwear).

**Loyalty Programs**
- Reward High-Frequency Purchasers: Implement loyalty programs to incentivize repeat purchases among adults (ages 36-55).


