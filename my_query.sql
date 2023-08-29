--CREATE TABLE 
CREATE TABLE  IF NOT EXISTS covid_19_data (
    sno VARCHAR,
    observation_date DATE,
    province VARCHAR,
    country VARCHAR,
    last_update TIMESTAMP,
    confirmed INT,
    deaths INT,
    recovered INT
);


--Retrieve the cumulative counts of confirmed, deceased, and recovered cases.
select 
   sum(confirmed) as cumulative_confirmed, 
   sum(deaths) as  cumulative_deaths, 
   sum(recovered) as  cumulative_recovered
from covid_19_data


--Extract the aggregate counts of confirmed, deceased, and recovered cases for  the first quarter of each observation year. 
SELECT
    EXTRACT(YEAR FROM observation_date) AS year,
    EXTRACT(QUARTER FROM observation_date) AS quarter,
    SUM(confirmed) AS total_confirmed,
    SUM(deaths) AS total_deaths,
    SUM(recovered) AS total_recovered
FROM
    covid_19_data
GROUP BY
    year, quarter
HAVING EXTRACT(QUARTER FROM observation_date) = 1


--Formulate a comprehensive summary encompassing the following for each
-- country:
-- Total confirmed cases
-- Total deaths
-- Total recoveries
SELECT
    Country,
    SUM(Confirmed) AS TotalConfirmedCases,
    SUM(Deaths) AS TotalDeaths,
    SUM(Recovered) AS TotalRecoveries
FROM
    covid_data
GROUP BY
    Country
ORDER BY
    Country;

-- Determine the percentage increase in the number of death cases from 2019
-- to 2020.
SELECT
    (SUM(CASE WHEN EXTRACT(YEAR FROM observation_date) = 2020 THEN Deaths ELSE 0 END) - SUM(CASE WHEN EXTRACT(YEAR FROM observation_date) = 2019 THEN Deaths ELSE 0 END)) * 100.0 /
    NULLIF(SUM(CASE WHEN EXTRACT(YEAR FROM observation_date) = 2019 THEN Deaths ELSE 0 END), 0) AS PercentageIncrease
FROM
    covid_19_data
WHERE
    EXTRACT(YEAR FROM observation_date) IN (2019, 2020);


-- Compile data for the top 5 countries with the highest confirmed cases.

SELECT
    Country,
    SUM(Confirmed) AS TotalConfirmedCases
FROM
    covid_19_data
GROUP BY
    Country
ORDER BY
    TotalConfirmedCases DESC
LIMIT 5;




-- Calculate the net change (increase or decrease) in confirmed cases on a
-- monthly basis over the two-year period.
SELECT
    EXTRACT(YEAR FROM observation_date) AS Year,
    EXTRACT(MONTH FROM observation_date) AS Month,
    SUM(Confirmed) AS TotalConfirmed,
    SUM(Confirmed) - LAG(SUM(Confirmed), 1, 0) OVER (ORDER BY  EXTRACT(YEAR FROM observation_date),EXTRACT(MONTH FROM observation_date)) AS MonthlyChange
FROM
    covid_19_data
GROUP BY
    EXTRACT(YEAR FROM observation_date),
    EXTRACT(MONTH FROM observation_date)
ORDER BY
    Year, Month;




