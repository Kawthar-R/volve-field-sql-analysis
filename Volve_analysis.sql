USE VolveProject;
-- ============================================
-- Part 1: Monthly Production Analysis
-- Volve Field Dataset
-- ============================================


-- ============================================
-- 1. Data Overview
-- ============================================

-- Number of distinct wells in the dataset
SELECT COUNT(DISTINCT WellboreName) AS TotalWells
FROM MonthlyProduction;


-- Total number of records in the dataset
SELECT COUNT(*) AS TotalRecords
FROM MonthlyProduction;


-- Time period covered by the data (earliest and latest year)
SELECT MIN(Yr) AS EarliestYear, MAX(Yr) AS LatestYear
FROM MonthlyProduction;


-- ============================================
-- 2. Well Production Analysis
-- ============================================

-- Total oil production per well, ranked from highest to lowest
SELECT WellboreName, SUM(Oil) AS TotalOil
FROM MonthlyProduction
GROUP BY WellboreName
ORDER BY TotalOil DESC;


-- Average monthly on-stream hours per well
SELECT WellboreName, AVG(OnStreamHrs) AS AvgOnStreamHrs
FROM MonthlyProduction
GROUP BY WellboreName
ORDER BY AvgOnStreamHrs DESC;


-- ============================================
-- 3. Water Production Analysis
-- ============================================

-- Total water production per well, ranked from highest to lowest
SELECT WellboreName, SUM(Water) AS TotalWater
FROM MonthlyProduction
GROUP BY WellboreName
ORDER BY TotalWater DESC;


-- Number of records per well where Oil = 0 or NULL
-- (used to understand data completeness before calculating the ratio)
SELECT WellboreName, COUNT(*) AS ExcludedRows
FROM MonthlyProduction
WHERE Oil = 0 OR Oil IS NULL
GROUP BY WellboreName
ORDER BY ExcludedRows DESC;


-- Water-to-Oil Ratio per well, with MonthsUsed to show sample size
-- Note: 228 of 526 records have Oil = 0 or NULL and are excluded here.
-- Oil = 0 is excluded to avoid division-by-zero errors,
-- while NULL values represent missing oil data.
-- Most excluded records belong to F-4 (112 records) and F-5 (104 records).
-- MonthsUsed shows how many valid months each ratio is based on,
-- so results for wells with a small sample (e.g. F-5) should be
-- interpreted with caution rather than compared directly to wells
-- with a much larger sample (e.g. F-12 and F-14).
SELECT WellboreName,
    COUNT(*) AS MonthsUsed,
    SUM(Water) AS TotalWater,
    SUM(Oil) AS TotalOil,
    SUM(Water) / SUM(Oil) AS WaterToOilRatio
FROM MonthlyProduction
WHERE Oil > 0
GROUP BY WellboreName
ORDER BY WaterToOilRatio ASC;


-- ============================================
-- 4. Production Trends Over Time
-- ============================================

-- Total oil production per year
SELECT Yr, SUM(Oil) AS TotalOil
FROM MonthlyProduction
GROUP BY Yr
ORDER BY Yr;


-- Investigating 2007: why did total oil come back as NULL?
SELECT WellboreName, Yr, Mnth, Oil, Water
FROM MonthlyProduction
WHERE Yr = 2007;


-- ============================================
-- 5. Key Findings
-- ============================================

-- 1. F-4 has recorded on-stream hours but no recorded
--    oil or water production in the monthly dataset.
--    Its specific role cannot be determined from this
--    production table alone.


-- 2. Higher total oil production does not necessarily
--    mean a lower Water-to-Oil Ratio.
--    F-12 and F-14 have the highest total oil production,
--    but also relatively high Water-to-Oil Ratios (1.49 and 1.81).


-- 3. Sample size matters when interpreting the
--    Water-to-Oil Ratio.
--    F-5 has the lowest ratio (0.33), but it is based
--    on a limited number of valid months, so the result
--    should be interpreted with caution.


-- 4. Oil production peaked in 2009 at approximately
--    2.68 million, then declined significantly through 2013.
--    Production increased in 2014 and 2015 before declining
--    again in 2016 to approximately 313 thousand.
-- 5. The 2007 records contain NULL oil and water values
--    for F-4 and F-5. Therefore, no recorded oil production
--    is available for 2007 in this dataset.
--    The reason for these NULL values cannot be determined
--    from the Monthly Production table alone.