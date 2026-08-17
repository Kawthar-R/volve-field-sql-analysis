# 🛢️ Volve Field – Monthly Production Analysis (SQL)

## Overview
This project analyzes monthly oil and water production data from the Volve
oil field, using SQL Server / T-SQL. The goal was to explore well performance,
compare production efficiency across wells, and identify trends in the field's
production over time — while carefully distinguishing between findings the
data actually supports and assumptions that would require additional data.

## Data Source
- Dataset: Volve Field Production Dataset
- Original data owner: Equinor (released publicly for research and education)
- Source: [Kaggle – Volve Production Dataset](https://www.kaggle.com/datasets/singhkulbir7868/volve-production-dataset)
- Table used: Monthly Production Data (526 records, 7 wells, 2007–2016)

## Tools Used
- Microsoft SQL Server
- T-SQL

## Skills Applied
SELECT · WHERE · GROUP BY · ORDER BY · COUNT / COUNT(DISTINCT) ·
SUM · AVG · MIN / MAX · IS NULL · calculated metrics (Water-to-Oil Ratio)

## Analysis Structure
1. Data Overview – dataset size, number of wells, time period covered
2. Well Production Analysis – total oil per well, average on-stream hours
3. Water Production Analysis – total water per well, Water-to-Oil Ratio
   (with careful handling of NULL/zero oil values to avoid division errors)
4. Production Trends Over Time – yearly oil production and field decline pattern

## Key Findings
1. Well F-4 has recorded on-stream hours but no recorded oil or water
   production. Its specific role cannot be determined from this table alone.
2. Higher total oil production doesn't mean lower Water-to-Oil Ratio.
   Wells F-12 and F-14 have the highest total oil output but also relatively
   high water ratios (1.49 and 1.81).
3. Sample size matters. Well F-5 shows the lowest Water-to-Oil Ratio (0.33),
   but this is based on very few valid months, so it should not be directly
   compared to wells with much larger samples.
4. Field production peaked in 2009 (~2.68M Sm3), declined steadily through
   2013, recovered briefly in 2014–2015, then declined again in 2016 to ~313K
   Sm3 — an ~88% drop from peak.
5. 2007 has no usable oil production data — the only records that year
   belong to F-4 and F-5, both with NULL values.

## Files
- volve_analysis.sql – full SQL script with comments and analysis

## Note
This is my first data project after completing an SQL Foundations course.
It intentionally uses only fundamental SQL concepts (no window functions,
subqueries, or CTEs) to reflect my actual current skill level.
