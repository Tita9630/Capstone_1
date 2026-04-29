USE sample_sales;

-- Analyzing South Carolina's sales territory. 

-- Total Revenue, start date and end date

SELECT SUM(Sale_Amount) AS TotalRevenue, MIN(Transaction_Date) AS StartDate, 
MAX(Transaction_Date) AS EndDate 
FROM store_sales
JOIN store_locations
ON store_sales.Store_ID = store_locations.StoreID
WHERE State = 'South Carolina';


-- Month by month revenue breakdown

SELECT Year(Transaction_Date) AS Year, Month(Transaction_Date) AS Month, 
SUM(Sale_Amount) AS TotalRevenue 
FROM store_sales
JOIN store_locations
ON store_sales.Store_ID = store_locations.StoreID
WHERE State = 'South Carolina'
GROUP BY Month(Transaction_Date), Year(Transaction_Date);
       
       
-- comparison of total revenue for South Carolina and its region

SELECT Region AS Area, SUM(Sale_Amount) AS TotalRevenue 
FROM (store_sales)
JOIN store_locations
ON store_sales.Store_ID = store_locations.StoreID
JOIN management
ON store_locations.State = management.State
WHERE Region = 'South'

UNION ALL 

SELECT 'South Carolina' AS Area, SUM(Sale_Amount) AS TotalRevenue 
FROM store_sales
JOIN store_locations
ON store_sales.Store_ID = store_locations.StoreID
WHERE State = 'South Carolina';


-- Number of transactions per month and average transaction size by product category

SELECT Year(Transaction_Date) AS Year, Month(Transaction_Date) AS Month, Categoryid, 
Count(*) AS NumberOfTransaction, Round(Avg(Sale_Amount), 2) AS AvgTransactionSize
FROM store_sales
JOIN store_locations
ON store_sales.Store_ID = store_locations.StoreID 
JOIN products
ON store_sales.Prod_Num = products.ProdNum
WHERE State = 'South Carolina'
GROUP BY Categoryid, Year(Transaction_Date), Month(Transaction_Date)
ORDER BY Year(Transaction_Date), Month(Transaction_Date), NumberOfTransaction DESC;


-- Ranking of in-store sales performance by each store

SELECT SUM(Sale_Amount) AS TotalSales, Store_ID
FROM store_sales
JOIN store_locations
ON store_sales.Store_ID = store_locations.StoreID
WHERE State = 'South Carolina' 
GROUP BY Store_ID
ORDER BY TotalSales;

-- Recommendation for where to focus sales attention in the next quarter

/* In South Carolina, there are two stores(Store 852 and Store 853). Based on the analysis, store 853 
has higher total sales than store 852 by 25,191.44. This indicates that store 853 is performing better.
Therefore, for the next quarter, it is recommended to focus on improving store 852 by identifying the
factors that is affecting that store and by adapting store 853's strong strategies. 
Additionally, both stores are performing below the avarage store revenue compared to other states. 
This indicates an overall underperformance in South Carolina. To improve performance, it is 
recommended to apply strategies from high performing period like August 2025. Increasing both number of 
transactions and the average transaction size will be essential to reach above average performance. And,
it is also recommended that South Carolina adopt best practices from higher-performing states. */














