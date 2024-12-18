-- Example CTE for daily production report

WITH DailyRigProduction AS (
    SELECT
        RigID,
        DATE(ProductionDate) AS ProductionDate, 
        SUM(ProductionAmount) AS DailyTotalProduction
    FROM
        OilRigProduction
    WHERE
        ProductionDate >= '2024-09-01' AND ProductionDate < '2024-10-01'
    GROUP BY
        RigID,
        DATE(ProductionDate)
),
AverageRigProduction AS (
    SELECT
        RigID,
        AVG(DailyTotalProduction) AS AverageDailyProduction
    FROM
        DailyRigProduction
    GROUP BY
        RigID
)
SELECT
    RigID,
    AverageDailyProduction,
    RANK() OVER (ORDER BY AverageDailyProduction DESC) AS ProductionRank
FROM
    AverageRigProduction
ORDER BY
    ProductionRank;
