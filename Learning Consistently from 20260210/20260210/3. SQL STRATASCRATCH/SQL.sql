-- StrataScratch ID 2054 – Consecutive Days Login Users
WITH ranked_logins AS (
    SELECT
        user_id,
        login_date,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY login_date
        ) AS rn
    FROM logins
),
grouped_dates AS (
    SELECT
        user_id,
        login_date,
        login_date - rn AS grp
    FROM ranked_logins
)
SELECT DISTINCT user_id
FROM grouped_dates
GROUP BY user_id, grp
HAVING COUNT(*) >= 3;

-- StrataScratch ID 10172 – Best Selling Item
SELECT
    product_id,
    SUM(quantity) AS total_sold
FROM sales
GROUP BY product_id
ORDER BY total_sold DESC
LIMIT 1;
WITH product_sales AS (
    SELECT
        product_id,
        SUM(quantity) AS total_sold
    FROM sales
    GROUP BY product_id
)
SELECT product_id, total_sold
FROM product_sales
WHERE total_sold = (
    SELECT MAX(total_sold) FROM product_sales
);


