---Display basic information
Describe Olympics

---Identify duplicates
SELECT City, Year, Sport, Discipline, Event, Athlete, Gender, Country_Code, Country, Event_gender, Medal, COUNT(*)
FROM olympics_data
GROUP BY City, Year, Sport, Discipline, Event, Athlete, Gender, Country_Code, Country, Event_gender, Medal
HAVING COUNT(*) > 1;


---Remove duplicates
WITH numbered_rows AS (
    SELECT City, Year, Sport, Discipline, Event, Athlete, Gender, Country_Code, Country, Event_gender, Medal,
           ROW_NUMBER() OVER (PARTITION BY City, Year, Sport, Discipline, Event, Athlete, Gender, Country_Code, Country, Event_gender, Medal ORDER BY Year) AS rn
    FROM olympics_data
)
DELETE FROM numbered_rows WHERE rn > 1;


---Check for Missing Values
SELECT
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS Missing_City,
    SUM(CASE WHEN Year IS NULL THEN 1 ELSE 0 END) AS Missing_Year,
    SUM(CASE WHEN Sport IS NULL THEN 1 ELSE 0 END) AS Missing_Sport,
    SUM(CASE WHEN Discipline IS NULL THEN 1 ELSE 0 END) AS Missing_Discipline,
    SUM(CASE WHEN Event IS NULL THEN 1 ELSE 0 END) AS Missing_Event,
    SUM(CASE WHEN Athlete IS NULL THEN 1 ELSE 0 END) AS Missing_Athlete,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Missing_Gender,
    SUM(CASE WHEN Country_Code IS NULL THEN 1 ELSE 0 END) AS Missing_Country_Code,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Missing_Country,
    SUM(CASE WHEN Event_gender IS NULL THEN 1 ELSE 0 END) AS Missing_Event_Gender,
    SUM(CASE WHEN Medal IS NULL THEN 1 ELSE 0 END) AS Missing_Medal
FROM olympics_data;


---Impute Missing Values
--City
UPDATE olympics_data
SET City = (SELECT City FROM olympics_data WHERE City IS NOT NULL GROUP BY City ORDER BY COUNT(*) DESC LIMIT 1)
WHERE City IS NULL;


--Year
UPDATE olympics_data
SET Year = (SELECT AVG(Year) FROM olympics_data WHERE Year IS NOT NULL)
WHERE Year IS NULL;


---Export Data
SELECT * 
INTO OUTFILE '/path/to/cleaned_olympics.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM Olympics;





