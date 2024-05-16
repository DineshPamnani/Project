Use practise;
SHOW TABLES;

-- 1) Entire Table
SELECT * FROM sharktank_data;

-- 2) Total Episode
SELECT MAX(Epno) FROM sharktank_data;
SELECT COUNT(DISTINCT(Epno)) FROM sharktank_data;

-- 3) Total Pitches 
SELECT COUNT(DISTINCT(Brand)) FROM sharktank_data;

-- 4) Pitches which got funding
SELECT count(Brand) Funding_Received FROM sharktank_data WHERE NOT Deal = 'No Deal';
SELECT count(Amount_Invested) Funding_Received FROM sharktank_data WHERE Amount_Invested > 0;

SELECT count(Amount_Invested) Funding_Received, (SELECT count(Brand) FROM sharktank_data) Total_Pitches 
FROM sharktank_data 
WHERE Amount_Invested > 0;

-- 5) Success Probability
SELECT (count(Amount_Invested) / (SELECT count(Brand) FROM sharktank_data)) Success_Probability
FROM sharktank_data 
WHERE Amount_Invested > 0;

-- 6) Total Male pitchers
SELECT Sum(Male) FROM sharktank_data;

-- 7) Total Female pitchers
SELECT Sum(Female) FROM sharktank_data;

-- 8) Gender Ratio
SELECT Sum(Female) / Sum(Male) Gender_Ratio FROM sharktank_data;

-- 9) Total Invested Amount
SELECT (sum(Amount_Invested)/100) Amount_Invested_In_Cr FROM sharktank_data;

-- 10) Average Equity Taken (Where deals were made)
SELECT Avg(Equity_Taken_Percentage) Average_Equity FROM sharktank_data WHERE NOT Equity_Taken_Percentage = 0;

-- 11) Highest Amount Invested
SELECT max(Amount_Invested) Highest_Investment FROM sharktank_data;

-- 12) Highest Equity Taken
SELECT max(Equity_Taken_Percentage) FROM sharktank_data;

-- 13) Pitches with atlease 1 Female contestant
SELECT Count(*) FROM sharktank_data WHERE Female > 0;

SELECT sum(F.Female_Count) Pitch_with_one_Female FROM (
SELECT Female , CASE WHEN Female > 0 THEN 1 ELSE 0 END AS Female_Count FROM sharktank_data) F;

-- 14) Pitches converted having one female contestant
SELECT count(s.female) FROM (
SELECT * FROM sharktank_data WHERE Amount_Invested > 0) s WHERE Female > 0;

-- 15) AVG Team members
SELECT avg(Team_members) FROM sharktank_data;

-- 16) Amount invested per deal (only where funding received)
SELECT sum(d.Amount_Invested) Total_Fundings, count(d.Brand) Successful_Deals, sum(d.Amount_Invested) / count(d.Brand) Avg_Amount_Per_Deal FROM
(SELECT * FROM sharktank_data WHERE NOT Deal = 'No Deal') d;

-- 17) Average Age group of contestants
SELECT Average_Age, count(*) Count FROM sharktank_data GROUP BY Average_Age ORDER BY Count DESC;

-- 18) Location-wise split of pitches
SELECT Location, count(*) Count FROM sharktank_data GROUP BY Location ORDER BY Count DESC;

-- 19) Sector-wise split of pitches
SELECT Sector, count(*) Count FROM sharktank_data GROUP BY Sector ORDER BY Count DESC;


-- 20) Standalone Deals
SELECT Partners, count(Total_Investors) Count FROM sharktank_data WHERE Total_Investors = 1 GROUP BY Partners ORDER BY Count DESC;

-- 21) Partner Deals
SELECT Partners, count(Total_Investors) Count FROM sharktank_data WHERE Total_Investors > 1 GROUP BY Partners ORDER BY Count DESC;



-- 22) Statistics of a Shark
-- Ashneer
-- Query 1
SELECT 'Ashneer' as keyy, Count(Ashneer_Amount_Invested) Ashneer_Present FROM sharktank_data WHERE NOT Ashneer_Amount_Invested = 'NA';
-- Query 2
SELECT 'Ashneer' as keyy, Count(Ashneer_Amount_Invested) Ashneer_Invested_Count FROM sharktank_data WHERE Ashneer_Amount_Invested>0;
-- Query 3
SELECT 'Ashneer' as keyy, sum(c.Ashneer_Amount_Invested) Total_Amount_Invested, avg(c.Ashneer_Amount_Invested) Average_Amount_Invested FROM (
SELECT * FROM sharktank_data WHERE Ashneer_Amount_Invested > 0) c;

-- Main Query (Ashneer)
SELECT m.keyy, m.Ashneer_Present,m.Ashneer_Invested_Count,  n.Total_Amount_Invested,n.Average_Amount_Invested FROM (
(SELECT a.keyy,a.Ashneer_Present,b.Ashneer_Invested_Count FROM (
(SELECT 'Ashneer' as keyy, Count(Ashneer_Amount_Invested) Ashneer_Present FROM sharktank_data WHERE NOT Ashneer_Amount_Invested = 'NA') a
INNER JOIN
(SELECT 'Ashneer' as keyy, Count(Ashneer_Amount_Invested) Ashneer_Invested_Count FROM sharktank_data WHERE Ashneer_Amount_Invested>0) b
on a.keyy = b.keyy)) m
INNER JOIN
(SELECT 'Ashneer' as keyy, sum(c.Ashneer_Amount_Invested) Total_Amount_Invested, avg(c.Ashneer_Amount_Invested) Average_Amount_Invested FROM (
SELECT * FROM sharktank_data WHERE Ashneer_Amount_Invested > 0) c) n
on m.keyy=n.keyy);

-- (Anupam)
-- Query 1
SELECT 'Anupam' as keyy, Count(Anupam_Amount_Invested) Anupam_Present FROM sharktank_data WHERE NOT Anupam_Amount_Invested = 'NA';
-- Query 2
SELECT 'Anupam' as keyy, Count(Anupam_Amount_Invested) Anupam_Invested_Count FROM sharktank_data WHERE Anupam_Amount_Invested>0;
-- Query 3
SELECT 'Anupam' as keyy, sum(d.Anupam_Amount_Invested) Total_Amount_Invested, avg(d.Anupam_Amount_Invested) Average_Amount_Invested FROM (
SELECT * FROM sharktank_data WHERE Anupam_Amount_Invested > 0) d;

-- Main Query (Anupam)
SELECT p.keyy, p.Anupam_Present,p.Anupam_Invested_Count,  q.Total_Amount_Invested,q.Average_Amount_Invested FROM (
(SELECT g.keyy,g.Anupam_Present,h.Anupam_Invested_Count FROM (
(SELECT 'Anupam' as keyy, Count(Anupam_Amount_Invested) Anupam_Present FROM sharktank_data WHERE NOT Anupam_Amount_Invested = 'NA') g
INNER JOIN
(SELECT 'Anupam' as keyy, Count(Anupam_Amount_Invested) Anupam_Invested_Count FROM sharktank_data WHERE Anupam_Amount_Invested>0) h
on g.keyy = h.keyy)) p
INNER JOIN
(SELECT 'Anupam' as keyy, sum(d.Anupam_Amount_Invested) Total_Amount_Invested, avg(d.Anupam_Amount_Invested) Average_Amount_Invested FROM (
SELECT * FROM sharktank_data WHERE Anupam_Amount_Invested > 0) d) q
on p.keyy=q.keyy);

-- 23) Anupam and Ashneer statistics combined

SELECT m.keyy, m.Ashneer_Present,m.Ashneer_Invested_Count,  n.Total_Amount_Invested,n.Average_Amount_Invested FROM (
(SELECT a.keyy,a.Ashneer_Present,b.Ashneer_Invested_Count FROM (
(SELECT 'Ashneer' as keyy, Count(Ashneer_Amount_Invested) Ashneer_Present FROM sharktank_data WHERE NOT Ashneer_Amount_Invested = 'NA') a
INNER JOIN
(SELECT 'Ashneer' as keyy, Count(Ashneer_Amount_Invested) Ashneer_Invested_Count FROM sharktank_data WHERE Ashneer_Amount_Invested>0) b
on a.keyy = b.keyy)) m
INNER JOIN
(SELECT 'Ashneer' as keyy, sum(c.Ashneer_Amount_Invested) Total_Amount_Invested, avg(c.Ashneer_Amount_Invested) Average_Amount_Invested FROM (
SELECT * FROM sharktank_data WHERE Ashneer_Amount_Invested > 0) c) n
on m.keyy=n.keyy)
UNION
SELECT p.keyy, p.Anupam_Present,p.Anupam_Invested_Count,  q.Total_Amount_Invested,q.Average_Amount_Invested FROM (
(SELECT g.keyy,g.Anupam_Present,h.Anupam_Invested_Count FROM (
(SELECT 'Anupam' as keyy, Count(Anupam_Amount_Invested) Anupam_Present FROM sharktank_data WHERE NOT Anupam_Amount_Invested = 'NA') g
INNER JOIN
(SELECT 'Anupam' as keyy, Count(Anupam_Amount_Invested) Anupam_Invested_Count FROM sharktank_data WHERE Anupam_Amount_Invested>0) h
on g.keyy = h.keyy)) p
INNER JOIN
(SELECT 'Anupam' as keyy, sum(d.Anupam_Amount_Invested) Total_Amount_Invested, Round(avg(d.Anupam_Amount_Invested),2) Average_Amount_Invested FROM (
SELECT * FROM sharktank_data WHERE Anupam_Amount_Invested > 0) d) q
on p.keyy=q.keyy);


-- 24) Sector-wise startup with highest investment
SELECT a.* FROM 
(SELECT Brand,Sector, Amount_Invested, RANK() OVER( PARTITION BY Sector ORDER BY Amount_Invested DESC) rnk FROM sharktank_data ) a
WHERE a.rnk=1;