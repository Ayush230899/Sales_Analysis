#---- Business Problems Questions solve
# Question No. 1. Find the diff Payement Method and Number Of Transactions, Number Of Qty Sold
Select 
	payment_method, 
    count(*) as No_Pyment,
    SUM(quantity) as No_Quantity
    from walmart
    group by payment_method;

# Q.No.2 Identify the highest rated category in each branch displaying the branch category avg rating 
	Select 
	Branch, 
    category,
    AVG(rating) as High_Rating,
     RANK() OVER (PARTITION BY Branch ORDER BY AVG(rating) DESC) AS R
	from walmart 
    GROUP BY 1,2
    ORDER BY 1,3 DESC;
   # SELECT 
    #Branch, 
    #category,
    #AVG(rating) AS High_Rating,
    #RANK() OVER (PARTITION BY Branch ORDER BY AVG(rating) DESC) AS Rank
#FROM walmart
#GROUP BY Branch, category
#ORDER BY Branch, Rank;

# Q.No. 3 Identify the busist day for each branch on the Number of transaction
SELECT 
	date,Branch,
    date_format(date,'%y/%m/%d') as Formated_date,
    DAYNAME(date) as day_name,
    RANK() OVER (PARTITION BY Branch ORDER BY COUNT(*) DESC) AS rank1
From walmart
GROUP BY 1,2
ORDER BY 1,3 DESC;

# Q.No. 4 Calculate the total quantity of items sold per payment method. list payment_method and total quantity 
Select 
	payment_method, 
    count(*) as No_Pyment,
    SUM(quantity) as No_Quantity
    from walmart
    group by payment_method;
    
# Q.No. 5 Determine the Average, Minimum And Maximum Rating Of Category for Each city List the average_rating, Minmum_rating and Maximum_Rating
Select * From Walmart;
Select 
	city,
    category,
    MIN(rating) as Min_Rating,
    MAX(rating) as Max_Raing,
    Avg(rating) as Avg_Rating
    From Walmart
    GROUP By city,category;
    
#Q.No-6)Calculate the total profit for each category by considering total_profit as (Unit_price*Quantity*Profit_Margin). 
#List category and total_Profit Ordered from highest to lowest profit.
Select * from walmart;
Select 
	category,
    SUM(total) as total_revenue,
    SUM(total * profit_margin) as Profit
From walmart
GROUP BY category, total;

#Q. No. 7 Determine the most common payment method for each Branch. 
		  #Dispaly Branch and the preferred_payment Method.alter
Select * from walmart;
with cte
as
(Select 
	Branch, 
    payment_method,
    count(*) as total_trans,
    RANK() OVER(partition by Branch Order By count(*) DESC) as Ranking 
    from walmart
    GROUP BY Branch,payment_method)
    Select * from cte
    where ranking = 1
#Q. 8 Categorize sales into 3 Group Morining, Afternoon, Evening  find out of the shift and No. Of Invoice
	SELECT * FROM walmart;
   SELECT *, 
       CASE 
           WHEN HOUR(time) < 12 THEN 'Morning'
           WHEN HOUR(time) BETWEEN 12 AND 17 THEN 'Afternoon'
           ELSE 'Evening'
       END AS day_time,
      TIME(time) AS formatted_time
FROM walmart
GROUP BY 1;

SELECT  
	   Branch,
       CASE 
           WHEN HOUR(time) < 12 THEN 'Morning'
           WHEN HOUR(time) BETWEEN 12 AND 17 THEN 'Afternoon'
           ELSE 'Evening'
       END AS day_time,
        COUNT(*)
FROM walmart
GROUP BY 1,2
ORDER BY 1,3 DESC;

#Q.No.9 Identify 5 Branch with highest decrease ratio in  revenue compare  to last  year 
# Current year and last Year. (Most Important)
# Formula (rde = last_rev - current_rev/last_rev*100)
Select * from walmart;
SELECT *, 
       YEAR(STR_TO_DATE(date, '%d/%m/%y')) AS Formatted_Date
FROM walmart;
# 2022 Sales
WITH revenue AS (
    SELECT 
        Branch,
        SUM(total) AS revenue
    FROM walmart 
    WHERE YEAR(STR_TO_DATE(date, '%d/%m/%y')) = 2022
    GROUP BY Branch
), 
revenue_2023 AS (
    SELECT 
        Branch,
        SUM(total) AS revenue
    FROM walmart 
    WHERE YEAR(STR_TO_DATE(date, '%d/%m/%y')) = 2023
    GROUP BY Branch
)
SELECT 
    r2022.Branch,
    r2022.revenue AS revenue_2022,
    r2023.revenue AS revenue_2023,
	Round(r2022.revenue - r2023.revenue/r2022.revenue*100,2) AS Rev_Ratio
FROM revenue r2022
LEFT JOIN revenue_2023 r2023
ON r2022.Branch = r2023.Branch
Where r2022.revenue>r2023.revenue
ORDER BY 4
LIMIT 4;



    
   
