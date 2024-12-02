CREATE DATABASE nft_data;
USE nft_data;

SHOW TABLES;

CREATE TABLE nft_sales (
    buyer_address VARCHAR(255),
    eth_price FLOAT,
    usd_price FLOAT,
    seller_address VARCHAR(255),
    day VARCHAR(10),
    `utc_timestamp` VARCHAR(20),
    token_id INT,
    transaction_hash VARCHAR(255),
    name VARCHAR(255),
    wrapped_punk BOOLEAN
);

SELECT COUNT(*) AS total_rows
FROM nft_sales;

-- question 1
SELECT COUNT(*) AS total_sales
FROM nft_sales;

-- question 2
SELECT name, eth_price, usd_price, day
FROM nft_sales
ORDER BY usd_price DESC
LIMIT 5;

-- question 3
SELECT 
    transaction_hash AS event,
    usd_price,
    AVG(usd_price) OVER (ORDER BY transaction_hash ROWS BETWEEN 49 PRECEDING AND CURRENT ROW) AS usd_price_moving_avg
FROM nft_sales;

-- Question 4
SELECT name, 
       AVG(usd_price) AS average_price
FROM nft_sales
GROUP BY name
ORDER BY average_price DESC;

-- question 5
SELECT 
    DAYNAME(STR_TO_DATE(day, '%m/%d/%y')) AS day_of_week,
    COUNT(*) AS total_sales,
    AVG(eth_price) AS average_eth_price
FROM nft_sales
GROUP BY day_of_week
ORDER BY total_sales ASC;

-- Question 6
SELECT 
    CONCAT(name, ' was sold for $', ROUND(usd_price, 0), 
           ' to ', buyer_address, 
           ' from ', seller_address, 
           ' on ', day) AS summary
FROM nft_sales;

-- question 7
CREATE VIEW 1919_purchases AS
SELECT *
FROM nft_sales
WHERE buyer_address = '0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685';

-- question 8
SELECT 
    ROUND(eth_price, -2) AS eth_price_range,
    COUNT(*) AS transaction_count,
    REPEAT('*', COUNT(*)) AS histogram  -- Adjust scale as needed
FROM nft_sales
GROUP BY eth_price_range
ORDER BY eth_price_range;

-- question 9
SELECT name, MAX(usd_price) AS price, 'highest' AS status
FROM nft_sales
GROUP BY name
UNION
SELECT name, MIN(usd_price) AS price, 'lowest' AS status
FROM nft_sales
GROUP BY name
ORDER BY name, status;

-- question 10
SELECT 
    DATE_FORMAT(STR_TO_DATE(day, '%m/%d/%y'), '%Y-%m') AS month_year,
    name,
    MAX(usd_price) AS highest_price
FROM nft_sales
GROUP BY month_year, name
ORDER BY month_year ASC;

-- question 11
SELECT 
    DATE_FORMAT(STR_TO_DATE(day, '%m/%d/%y'), '%Y-%m') AS month_year,
    ROUND(SUM(usd_price), -2) AS total_volume
FROM nft_sales
GROUP BY month_year
ORDER BY month_year ASC;

-- question 12
SELECT COUNT(*) AS transaction_count
FROM nft_sales
WHERE buyer_address = '0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685'
   OR seller_address = '0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685';

-- question 13a 
WITH daily_avg AS (
    SELECT 
        day,
        usd_price,
        AVG(usd_price) OVER (PARTITION BY day) AS daily_avg_price
    FROM nft_sales
)
SELECT *
FROM daily_avg;


-- question 13b
WITH daily_avg AS (
    SELECT 
        day,
        usd_price,
        AVG(usd_price) OVER (PARTITION BY day) AS daily_avg_price
    FROM nft_sales
)
SELECT 
    day,
    AVG(usd_price) AS estimated_value
FROM daily_avg
WHERE usd_price >= 0.1 * daily_avg_price
GROUP BY day
ORDER BY day;