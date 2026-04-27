USE sample_sales;

-- Analyzing South Carolina's sales territory. 

-- Total Revenue, start date and end date

SELECT SUM(TotalRevenue) AS SouthCarolina_TotalRevenue, MIN(StartDate) AS StartDate, MAX(EndDate) AS EndDate FROM (

	SELECT SUM(Sale_Amount) AS TotalRevenue, MIN(Transaction_Date) AS StartDate,
    MAX(Transaction_Date) AS EndDate FROM store_sales
    JOIN store_locations
    ON store_sales.Store_ID = store_locations.StoreID
    WHERE State = 'South Carolina'

    UNION ALL

    SELECT SUM(SalesTotal) AS TotalRevenue, MIN(Date) AS StartDate, MAX(Date) AS EndDate FROM online_sales
    WHERE ShiptoState = 'South Carolina'
) revenues;

-- Month by month revenue breakdown

SELECT Month, SUM(TotalRevenue) AS TotalRevenue FROM (
	   SELECT SUM(Sale_Amount) AS TotalRevenue, Month(Transaction_Date) AS Month FROM store_sales
       JOIN store_locations
       ON store_sales.Store_ID = store_locations.StoreID
       WHERE State = 'South Carolina'
       GROUP BY Month(Transaction_Date)
       
       UNION ALL
       
       SELECT SUM(SalesTotal) AS TotalRevenue, Month(Date) AS Month FROM online_sales
       WHERE ShiptoState = 'South Carolina'
       GROUP BY Month(Date)
)revenues
GROUP BY Month;
       

-- comparison of total revenue for South Carolina and its region.

SELECT 'South Region' AS Area, SUM(TotalRevenue) AS TotalRevenue FROM (
	   SELECT SUM(Sale_Amount) AS TotalRevenue FROM store_sales
       JOIN store_locations
       ON store_sales.Store_ID = store_locations.StoreID
       JOIN management
       ON store_locations.State = management.State
       WHERE Region = 'South'

       UNION ALL
       
       SELECT SUM(SalesTotal) AS TotalRevenue FROM online_sales
       JOIN management
       ON online_sales.ShiptoState = management.State
       WHERE Region = 'South'
) South
UNION ALL 
SELECT 'South Carolina' AS Area, SUM(TotalRevenue) AS TotalRevenue FROM (
        SELECT SUM(Sale_Amount) AS TotalRevenue FROM store_sales
        JOIN store_locations
        ON store_sales.Store_ID = store_locations.StoreID
        WHERE State = 'South Carolina'

        UNION ALL
        
        SELECT SUM(SalesTotal) AS TotalRevenue FROM online_sales
        WHERE ShiptoState = 'South Carolina'
) SouthCarolina;

-- Number of transactions per month and average transaction size by product category.








