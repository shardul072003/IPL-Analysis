USE ipl_analysis;

DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS deliveries;

CREATE TABLE matches (
    id INT PRIMARY KEY,
    season VARCHAR(10),
    city VARCHAR(50),
    date DATE,
    match_type VARCHAR(20),
    player_of_match VARCHAR(50),
    venue VARCHAR(100),
    team1 VARCHAR(50),
    team2 VARCHAR(50),
    toss_winner VARCHAR(50),
    toss_decision VARCHAR(10),
    winner VARCHAR(50),
    result VARCHAR(20),
    result_margin FLOAT,
    target_runs FLOAT,
    target_overs FLOAT,
    super_over VARCHAR(5),
    method VARCHAR(10),
    umpire1 VARCHAR(50),
    umpire2 VARCHAR(50)
);

CREATE TABLE deliveries (
    match_id INT,
    inning INT,
    batting_team VARCHAR(50),
    bowling_team VARCHAR(50),
    `over` INT,
    ball INT,
    batter VARCHAR(50),
    bowler VARCHAR(50),
    non_striker VARCHAR(50),
    batsman_runs INT,
    extra_runs INT,
    total_runs INT,
    extras_type VARCHAR(20),
    is_wicket INT,
    player_dismissed VARCHAR(50),
    dismissal_kind VARCHAR(30),
    fielder VARCHAR(50)
);

SHOW TABLES;
USE ipl_analysis;
SELECT COUNT(*) FROM matches;
SELECT COUNT(*) FROM deliveries;


-- 1) which team has won the most matches?
SELECT winner, COUNT(*) AS total_wins
FROM matches
WHERE winner not in ('NA' , '')
GROUP BY winner 
ORDER BY total_wins DESC;

-- 2) Does winning the toss give a match advantage?
SELECT COUNT(*) AS total_matches,
		SUM( CASE WHEN toss_winner = winner THEN 1 ELSE 0 END ) AS toss_won,
        ROUND(SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END ) * 100 / COUNT(*) , 2) AS win_percentage
FROM matches
WHERE winner NOT IN ('NA', ''); 

-- 3) Bat or field — which toss decision wins more?
SELECT toss_decision,
		COUNT(*) AS times_choosen,
        SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END ) AS toss_winner,
        ROUND(SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) / COUNT(*) , 2) AS win_rate
FROM matches
WHERE winner NOT IN ('NA' , '')
GROUP BY toss_decision;

-- 4) Which venues have hosted the most matches?
SELECT venue,
		COUNT(*) AS matches_played,
        SUM(CASE WHEN result = 'runs' THEN 1 ELSE 0 END) AS won_batting_first,
        SUM(CASE WHEN result = 'wicket' THEN 1 ELSE 0 END) AS won_feilding_first
FROM matches
WHERE winner NOT IN ('NA', '')
GROUP BY venue
HAVING matches_played >= 10
ORDER BY matches_played DESC
LIMIT 10;

-- 5)Top 10 batsmen by total runs
SELECT batter,
        SUM(batsman_runs) AS total_runs,
        COUNT(DISTINCT match_id) AS matches_played,
        ROUND(SUM(batsman_runs) / COUNT(DISTINCT match_id), 2) AS avg_per_match
FROM deliveries
GROUP BY batter
ORDER BY total_runs DESC
LIMIT 10;

-- 6) Top 10 bowlers by total wickets
SELECT 
    bowler,
    COUNT(*) AS total_wickets,
    COUNT(DISTINCT match_id) AS matches_played,
    ROUND(COUNT(*) / COUNT(DISTINCT match_id), 2) AS wickets_per_match
FROM deliveries
WHERE is_wicket = 1
AND dismissal_kind NOT IN ('run out', 'retired hurt', 'obstructing the field')
GROUP BY bowler
ORDER BY total_wickets DESC
LIMIT 10;

-- 7) Average match scores by season

SELECT m.season,
		ROUND(AVG(d.match_runs), 2) AS avg_match_score
FROM matches m 
JOIN (
	SELECT match_id , SUM(total_runs) AS match_runs
    FROM deliveries
    GROUP BY match_id
) d ON m.id = d.match_id
GROUP BY m.season
ORDER BY m.season;

-- 8) Player of the match award leaders
SELECT player_of_match,
		COUNT(*) AS total_awards,
        COUNT(DISTINCT season) AS seasons_active
FROM matches
WHERE player_of_match NOT IN ('NA' , '')
GROUP BY player_of_match
ORDER BY total_awards DESC
LIMIT 10;

-- 9) Batting first vs chasing — who wins more?
SELECT CASE WHEN toss_decision = 'bat' AND toss_winner = winner THEN 'batted first and won'
	   WHEN toss_decision ='field' AND toss_winner = winner THEN 'batted frist and won' ELSE 'chaseed and won'
END AS result_type ,
COUNT(*) AS total_matches
FROM matches 
WHERE winner NOT IN ('NA' , '')
GROUP BY result_type;

-- 10)Most consistent teams across seasons
SELECT
    season,
    winner AS team,
    COUNT(*) AS wins
FROM matches
WHERE winner NOT IN ('NA', '')
GROUP BY season, winner
ORDER BY season, wins DESC;