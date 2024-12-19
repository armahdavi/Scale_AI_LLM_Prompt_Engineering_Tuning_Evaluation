---------------------------------------------------------------------------
-- PROMPT: STOCK VOLATILITY & SOCIAL MEDIA SENTIMENT DATA ENTRY FOR TEST --
---------------------------------------------------------------------------

DROP TABLE IF EXISTS StockPrices
CREATE TABLE StockPrices (
    StockID INT PRIMARY KEY,
    StockSymbol VARCHAR(10),
    Date DATE,
    OpenPrice DECIMAL(10, 2),
    ClosePrice DECIMAL(10, 2),
    HighPrice DECIMAL(10, 2),
    LowPrice DECIMAL(10, 2),
    Volume INT
);

INSERT INTO StockPrices VALUES
(1, 'AAPL', '2023-01-01', 150.00, 155.00, 157.50, 148.50, 100000),
(2, 'GOOGL', '2023-01-01', 2700.00, 2750.00, 2780.00, 2680.00, 50000),
(3, 'MSFT', '2023-01-01', 220.00, 225.00, 230.00, 215.00, 75000),
(4, 'AMZN', '2023-01-01', 3300.00, 3350.00, 3380.00, 3270.00, 60000),
(5, 'FB', '2023-01-01', 330.00, 335.00, 340.00, 325.00, 40000),
(6, 'TSLA', '2023-01-01', 850.00, 900.00, 920.00, 840.00, 80000),
(7, 'NVDA', '2023-01-01', 400.00, 410.00, 415.00, 395.00, 35000),
(8, 'AMD', '2023-01-01', 150.00, 155.00, 158.00, 148.00, 30000),
(9, 'NFLX', '2023-01-01', 550.00, 560.00, 565.00, 545.00, 45000),
(10, 'INTC', '2023-01-01', 50.00, 52.00, 53.00, 48.00, 20000),
(11, 'IBM', '2023-01-01', 120.00, 125.00, 128.00, 118.00, 25000);


DROP TABLE IF EXISTS SocialMediaSentiment
CREATE TABLE SocialMediaSentiment (
    SentimentID INT PRIMARY KEY,
    Date DATE,
    Platform VARCHAR(20),
    PositiveSentiment INT,
    NeutralSentiment INT,
    NegativeSentiment INT,
    TotalPosts INT,
    ImpactScore DECIMAL(5, 2)
);

INSERT INTO SocialMediaSentiment VALUES
(1, '2023-01-01', 'Twitter', 300, 200, 100, 600, 7.5),
(2, '2023-01-01', 'Facebook', 400, 300, 150, 850, 8.2),
(3, '2023-01-01', 'Reddit', 250, 350, 200, 800, 6.8),
(4, '2023-01-01', 'Instagram', 350, 250, 100, 700, 7.0),
(5, '2023-01-01', 'LinkedIn', 200, 400, 150, 750, 6.5),
(6, '2023-01-01', 'TikTok', 450, 100, 50, 600, 7.8),
(7, '2023-01-01', 'Snapchat', 300, 200, 100, 600, 7.2),
(8, '2023-01-01', 'Pinterest', 200, 300, 100, 600, 6.3),
(9, '2023-01-01', 'YouTube', 350, 250, 150, 750, 7.5),
(10, '2023-01-01', 'WhatsApp', 200, 300, 100, 600, 6.0),
(11, '2023-01-01', 'Telegram', 400, 250, 100, 750, 7.8);


---------------------
-- RESPONSE 1 CODE --
---------------------

-- Calculate stock volatility
WITH StockVolatility AS (
    SELECT 
        StockID,
        StockSymbol,
        Date,
        (HighPrice - LowPrice) / LowPrice AS Volatility
    FROM 
        StockPrices
),
-- Rank stocks based on volatility
RankedStocks AS (
    SELECT 
        StockID,
        StockSymbol,
        Date,
        Volatility,
        RANK() OVER (ORDER BY Volatility DESC) AS VolatilityRank
    FROM 
        StockVolatility
),
-- Group sentiment scores into quantiles
SentimentQuantiles AS (
    SELECT 
        SentimentID,
        Date,
        Platform,
        ImpactScore,
        NTILE(4) OVER (ORDER BY ImpactScore) AS SentimentQuantile
    FROM 
        SocialMediaSentiment
)
-- Join ranked stocks with sentiment quantiles
SELECT 
    rs.StockID,
    rs.StockSymbol,
    rs.Date,
    rs.Volatility,
    rs.VolatilityRank,
    sq.Platform,
    sq.ImpactScore,
    sq.SentimentQuantile
FROM 
    RankedStocks rs
JOIN 
    SentimentQuantiles sq ON rs.Date = sq.Date
ORDER BY 
    rs.VolatilityRank, sq.SentimentQuantile;


---------------------
-- RESPONSE 2 CODE --
---------------------

WITH VolatilityCTE AS (
  SELECT 
    StockID,
    StockSymbol,
    Date,
    (HighPrice - LowPrice) / ClosePrice AS Volatility
  FROM 
    StockPrices
),
RankedVolatilityCTE AS (
  SELECT 
    StockID,
    StockSymbol,
    Date,
    Volatility,
    RANK() OVER (PARTITION BY Date ORDER BY Volatility DESC) AS VolatilityRank
  FROM 
    VolatilityCTE
),
SentimentQuantileCTE AS (
  SELECT 
    Date,
    ImpactScore,
    NTILE(4) OVER (PARTITION BY Date ORDER BY ImpactScore) AS SentimentQuantile
  FROM 
    SocialMediaSentiment
)
SELECT 
  rv.StockID,
  rv.StockSymbol,
  rv.Date,
  rv.Volatility,
  rv.VolatilityRank,
  sq.SentimentQuantile
FROM 
  RankedVolatilityCTE rv
  INNER JOIN SentimentQuantileCTE sq ON rv.Date = sq.Date;
