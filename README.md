# NFT Sales Analysis: CryptoPunks Dataset

## Overview
This project analyzes historical sales data for CryptoPunk NFTs using SQL to uncover key trends, insights, and market patterns in the NFT space.

**Key Highlights**:
- Dataset: 20,000+ sales transactions (2018–2021).
- Insights:
  - Top 5 most expensive transactions.
  - Average price trends across NFTs.
  - Daily sales distribution.
- Techniques:
  - SQL for querying and aggregating data.
  - Python for data Ingestion into MySQL.

---

## Dataset
The dataset contains the following columns:
- `buyer_address`: Wallet address of the buyer.
- `eth_price`: Price in ETH.
- `usd_price`: Price in USD.
- `seller_address`: Wallet address of the seller.
- `day`: Date of sale (MM/DD/YY).
- `token_id`: Unique ID of the NFT.
- `transaction_hash`: Blockchain transaction identifier.
- `name`: Name of the NFT.
- `wrapped_punk`: Boolean indicating if the NFT is wrapped.

---


## SQL Queries

All the SQL queries used for analyzing the CryptoPunks NFT dataset are included in the [`SQL_Capstone_Queries.sql`](SQL/SQL_Capstone_Queries.sql) file.

### Key Features:
- **Total Sales Count**: Count the total number of NFT transactions.
- **Top 5 Most Expensive Transactions**: Identify the most expensive sales.
- **Price Histograms**: Aggregate sales by ETH price ranges.
- **Moving Averages**: Analyze trends in USD price using rolling averages.
- **Average Sale Price per NFT**: Calculate average prices for each NFT.
- **Daily and Weekly Trends**: Identify trends in sales volume and price by day of the week.
- **Outlier Analysis**: Filter daily sales data to exclude outliers and compute adjusted averages.

### How to Use the Queries:
1. Open the file [`SQL_Capstone_Queries.sql`](SQL/SQL_Capstone_Queries.sql) in any SQL editor (e.g., MySQL Workbench, DBeaver).
2. Run the queries one by one to analyze the dataset.
3. Modify the queries as needed for your own analysis.

### Example Query:
```sql
-- Top 5 Most Expensive Transactions
SELECT name, eth_price, usd_price, day
FROM nft_sales
ORDER BY usd_price DESC
LIMIT 5;
