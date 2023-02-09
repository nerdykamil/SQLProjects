-- one issue with the data is that the location column has entries such as World, South America
-- Oceania etc but for these continent column is null
-- this can be seen in the query below
SELECT *
FROM myschema."CovidDeaths"
WHERE continent is not NULL;

-- so to get rid of this issue we make sure to have only the entries where the continent is not null
SELECT *
FROM myschema."CovidDeaths"
WHERE continent is not NULL;


SELECT location,date,total_cases,new_cases,total_deaths,population
FROM myschema."CovidDeaths"
WHERE continent is not NULL
ORDER BY 1,2;

-- Looking at Total Cases vs Total Deaths
SELECT location,date,total_cases,total_deaths, (CAST(total_deaths AS NUMERIC)/CAST(total_cases AS NUMERIC))*100 as DeathPercentage
FROM myschema."CovidDeaths"
WHERE location LIKE 'Pak%' and continent is not NULL
ORDER BY 1,2;


-- How much of population is impacted
SELECT location,date,population,total_cases, (CAST(total_cases AS NUMERIC)/CAST(population AS NUMERIC))*100 as Affectedpopulation
FROM myschema."CovidDeaths"
WHERE location LIKE 'Pak%' and continent is not NULL
ORDER BY 1,2;

-- Which countries had highest infection rates
SELECT location,population,MAX(total_cases) AS HighestInfection,
MAX((CAST(total_cases AS NUMERIC)/CAST(population AS NUMERIC))*100) as HighestAffectedpopulation
FROM myschema."CovidDeaths"
WHERE continent is not NULL
GROUP BY location,population
ORDER BY HighestAffectedpopulation DESC;

-- Showing countries with highest death counts per population
SELECT location, MAX(total_deaths) AS totaldeathcount
FROM myschema."CovidDeaths"
WHERE continent is not NULL
GROUP BY location
ORDER BY totaldeathcount DESC;

-- Lets break things down by continent
SELECT continent, MAX(total_deaths) AS totaldeathcount
FROM myschema."CovidDeaths"
WHERE continent is not NULL
GROUP BY continent
ORDER BY totaldeathcount DESC;

-- the numbers by above query seem off
-- the query below gave the right numbers
-- perfect example of why it is necessary to fact check numbers
SELECT location, MAX(total_deaths) AS totaldeathcount
FROM myschema."CovidDeaths"
WHERE continent is NULL
GROUP BY location
ORDER BY totaldeathcount DESC;

-- GLOBAL Numbers
SELECT date, SUM(new_cases) AS total_cases,
SUM(new_deaths) AS total_deaths,
SUM(new_deaths)/SUM(new_cases)*100 AS DeathPercentage
FROM myschema."CovidDeaths"
WHERE continent is not NULL
GROUP BY date
ORDER BY 1,2

SELECT SUM(new_cases) AS total_cases,
SUM(new_deaths) AS total_deaths,
SUM(new_deaths)/SUM(new_cases)*100 AS DeathPercentage
FROM myschema."CovidDeaths"
WHERE continent is not NULL
ORDER BY 1,2

-- Combining vaccination info
-- How many people have been vaccinated from the total population
SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date) Rollingpeoplevaccinated
FROM myschema."CovidDeaths" dea
JOIN myschema."CovidVaccinations" vac
ON dea.location = vac.location and dea.date = vac.date
Where dea.continent is not null
order by 2,3

-- find the percentage of people vaccinated in different location in a rolling manner

-- USE CTE

WITH popvsvac (continent,location,date,population,new_vaccinations,rollingpeoplevac)
as
(
SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date) Rollingpeoplevaccinated
FROM myschema."CovidDeaths" dea
JOIN myschema."CovidVaccinations" vac
ON dea.location = vac.location and dea.date = vac.date
Where dea.continent is not null
-- order by 2,3  %%order by clause can't be in cte
)

SELECT *, (rollingpeoplevac/population)*100 as percentpopulationvaccinated
FROM popvsvac

-- Creating view to store data for later for visualizations
CREATE VIEW percentpeoplevaccinated AS
SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(vac.new_vaccination) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date) Rollingpeoplevaccinated
FROM myschema."CovidDeaths" dea
JOIN myschema."CovidVaccinations" vac
ON dea.location = vac.location and dea.date = vac.date
Where dea.continent is not null



