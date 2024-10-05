---Top 20 countries by total number of medals
SELECT Country, COUNT(*) AS medal_count
FROM olympics_data
GROUP BY Country
ORDER BY medal_count DESC
LIMIT 20;


--- Number of medals per year
SELECT Year, COUNT(Medal) AS total_medals
FROM olympics_data
GROUP BY Year
ORDER BY Year;


---Top 20 athletes by medal count
SELECT Athlete, COUNT(*) AS medal_count
FROM olympics_data
GROUP BY Athlete
ORDER BY medal_count DESC
LIMIT 20;


---Top 20 sports by medal count
SELECT Sport, COUNT(*) AS medal_count
FROM olympics_data
GROUP BY Sport
ORDER BY medal_count DESC
LIMIT 20;


--- Medal distribution by gender
SELECT Gender, COUNT(*) AS medal_count
FROM olympics_data
GROUP BY Gender;


--- Medal type distribution (Gold, Silver, Bronze)
SELECT Medal, COUNT(*) AS medal_count
FROM olympics_data
GROUP BY Medal;



