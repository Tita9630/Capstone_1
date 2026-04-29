USE sample_sales;

/* For each sale, display the transaction date, sale_amount, city, state,
and the name of the store manager responsible for that state.*/

SELECT Transaction_Date, Sale_Amount, StoreLocation AS City, store_locations.state, SalesManager
FROM store_sales
JOIN store_locations
ON store_sales.Store_ID = store_locations.StoreID
JOIN management
ON store_locations.State = management.State;


-- A query that shows total sales by region. And, the region that generates the most revenue

SELECT Region AS Area, SUM(Sale_Amount) AS Revenue
FROM (store_sales)
JOIN store_locations
ON store_sales.Store_ID = store_locations.StoreID
JOIN management
ON store_locations.State = management.State
GROUP BY Region
ORDER BY Revenue DESC;


-- Stores that had total sales above the average store revenue

SELECT SUM(Sale_Amount) AS TotalSales, Store_ID
FROM store_sales
GROUP BY Store_ID
HAVING SUM(Sale_Amount) > (
	SELECT Avg(TotalSales)
    FROM (
	     SELECT SUM(Sale_Amount) AS TotalSales FROM store_sales
         GROUP BY Store_ID
         ORDER BY TotalSales DESC
	) Total
);


-- The top 5 highest-grossing stores, their city and state

SELECT Store_ID, TotalSales, StoreLocation AS City, State
FROM (
     SELECT SUM(Sale_Amount) AS TotalSales, Store_ID FROM store_sales
     GROUP BY Store_ID
     ORDER BY TotalSales DESC
     LIMIT 5
) Total
JOIN store_locations
ON Total.Store_ID = store_locations.StoreID;







    
    



