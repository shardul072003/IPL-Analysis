# IPL Performance Analysis 2008 - 2024 

## Project Overview
An end-to-end data analysis project on 15 seasons of IPL data using MySQL 
for analysis and Tableau for visualization. The dataset contains 1,095 
matches and 260,920 ball-by-ball deliveries.

## Tools Used
- **MySQL** — data storage and querying
- **Python (Pandas, SQLAlchemy)** — data loading and cleaning
- **Tableau Public** — interactive dashboard
- **GitHub** — version control and portfolio hosting

## Dataset
- **Source:** Kaggle — IPL Complete Dataset 2008–2024
- **Tables:** matches (1,095 rows) and deliveries (260,920 rows)

## Dashboard
🔗 [View Live Tableau Dashboard](https://public.tableau.com/app/profile/shardul.tidke/viz/IPLAnalysisDashboard_17761586023580/IPLPerformanceAnalysis2008-2024)

## Key Business Findings

**1. Mumbai Indians are the most dominant franchise**
Mumbai Indians have the highest total wins across all 15 seasons —
making them the most consistently successful franchise in IPL history.
This signals strong team management, retention strategy, and squad depth.

**2. Batting first wins more often**
Teams that batted first won more matches than teams that chased.
This challenges the common assumption that chasing is always easier in 
T20 cricket and suggests teams should consider conditions carefully 
before making toss decisions.

**3. Virat Kohli is the all-time leading run scorer**
Kohli leads the batting charts across all IPL seasons — a testament to 
his consistency across different teams, conditions, and formats over 15 years.

**4. Yuzvendra Chahal is the top wicket taker**
Chahal leads the bowling charts, making him the most impactful bowler 
in IPL history. His leg-spin has proven effective across venues and seasons.

**5. Toss advantage is roughly 50/50**
Teams that won the toss won approximately 50% of their matches — 
suggesting that toss luck alone does not determine match outcomes.
Team quality and execution matter far more.

**6. Eden Gardens is the most used venue**
Eden Gardens in Kolkata has hosted the most IPL matches, making it the 
spiritual home of the tournament and a critical venue for franchise planning.

**7. 2024 was the highest scoring season**
Average match scores peaked in 2024 — reflecting how T20 batting has 
evolved with more aggressive techniques, better bats, and smaller boundaries.

## SQL Queries
All 10 analytical queries are in `queries.sql` — covering team wins, 
player performance, venue analysis, toss impact, and scoring trends.

## Project Structure
ipl_analysis/
── data/
   ── matches.csv
   ── deliveries.csv
/── schema.sql
/── queries.sql
/── README.md

## How to Run
1. Clone this repository
2. Run schema.sql in MySQL to create the database
3. Load CSVs using the Python script in queries.sql
4. Run queries.sql to reproduce all analysis
5. Open Tableau dashboard link to view visualizations
