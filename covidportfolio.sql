SELECT *
FROM AdebisiPortfolio..CovidDeaths123$
ORDER BY 3,4

SELECT *
FROM AdebisiPortfolio..CovidVaccinations$
ORDER BY 3,4

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM AdebisiPortfolio..CovidDeaths123$
ORDER BY 1,2

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM AdebisiPortfolio..CovidDeaths123$
where location like '%state%'
ORDER BY 1,2



SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM AdebisiPortfolio..CovidDeaths123$
where location like '%asia%'
ORDER BY 1,2

AFRICA

TOTAL CASES VS TOTAL DEATH

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM AdebisiPortfolio..CovidDeaths123$
where location like '%africa%'
ORDER BY 1,2

--TOTAL CASES VS POPULATION

SELECT location, date, total_cases, population, (total_cases/population)*100 AS PopulationPercentage
FROM AdebisiPortfolio..CovidDeaths123$
where location like '%AFRICA%'
ORDER BY 1,2

 --COUNTRY WITH HIGHEST INFECTION RATE

 SELECT location, population, MAX(total_cases) AS Highestinfectioncount, MAX (total_cases/population)*100 AS PopulationPercentage
FROM AdebisiPortfolio..CovidDeaths123$
--where location like %africa%
Group by location, population
ORDER BY 1,2

 SELECT location, population, MAX(total_cases) AS Highestinfectioncount, MAX (total_cases/population)*100 AS PopulationPercentage
FROM AdebisiPortfolio..CovidDeaths123$
--where location like %africa%
Group by location, population
Order by PopulationPercentage desc

--countries with highest death rate

SELECT location, population, MAX(total_deaths) AS TotalDeathCount, MAX (total_deaths/population)*100 AS DeathPercentage
FROM AdebisiPortfolio..CovidDeaths123$
--where location like %africa%
Group by location, population
Order by DeathPercentage desc

SELECT location, population, MAX(cast(total_deaths as int)) AS TotalDeathCount, MAX (total_deaths/population)*100 AS DeathPercentage
FROM AdebisiPortfolio..CovidDeaths123$
--where location like %africa%
Group by location, population
Order by DeathPercentage desc

SELECT *
FROM AdebisiPortfolio..CovidDeaths123$
where continent is not null


SELECT location, MAX(cast(total_deaths as int)) AS TotalDeathCount 
FROM AdebisiPortfolio..CovidDeaths123$
--where location like %africa%
where continent is not null
Group by location
Order by TotalDeathCount desc


SELECT location, MAX(cast(total_deaths as int)) AS TotalDeathCount 
FROM AdebisiPortfolio..CovidDeaths123$
--where location like %africa%
where continent is null  
Group by location
Order by TotalDeathCount desc


--continent with highest death count

SELECT continent, MAX(cast(total_deaths as int)) AS TotalDeathCount 
FROM AdebisiPortfolio..CovidDeaths123$
--where location like %africa%
where continent is not null  
Group by continent
Order by TotalDeathCount desc

--global Number

SELECT date, SUM(new_cases), SUM(cast(new_deaths as int))--, (total_deaths/total_cases)*100 AS DeathPercentage
FROM AdebisiPortfolio..CovidDeaths123$
--where location like '%africa%'
where continent is not null
group by date
ORDER BY 1,2  




--COVID VACCINATION TABLE

SELECT *
FROM AdebisiPortfolio..CovidVaccinations$

SELECT *
FROM AdebisiPortfolio..CovidDeaths123$
JOIN AdebisiPortfolio..CovidVaccinations$
ON CovidDeaths123$.location = CovidVaccinations$.location
AND CovidDeaths123$.date = CovidVaccinations$.date

--population vs vaccination

SELECT CovidDeaths123$.continent, CovidDeaths123$.location, CovidDeaths123$.date, CovidDeaths123$.population,CovidVaccinations$.new_vaccinations
FROM AdebisiPortfolio..CovidDeaths123$
JOIN AdebisiPortfolio..CovidVaccinations$
ON CovidDeaths123$.location = CovidVaccinations$.location
AND CovidDeaths123$.date = CovidVaccinations$.date

SELECT CovidDeaths123$.continent, CovidDeaths123$.location, CovidDeaths123$.date, CovidDeaths123$.population,CovidVaccinations$.new_vaccinations
FROM AdebisiPortfolio..CovidDeaths123$
JOIN AdebisiPortfolio..CovidVaccinations$
ON CovidDeaths123$.location = CovidVaccinations$.location
AND CovidDeaths123$.date = CovidVaccinations$.date
order by 1,2


SELECT CovidDeaths123$.continent, CovidDeaths123$.location, CovidDeaths123$.date, CovidDeaths123$.population,CovidVaccinations$.new_vaccinations
FROM AdebisiPortfolio..CovidDeaths123$
JOIN AdebisiPortfolio..CovidVaccinations$
ON CovidDeaths123$.location = CovidVaccinations$.location
AND CovidDeaths123$.date = CovidVaccinations$.date
where CovidDeaths123$.continent is not null
order by 1,2

SELECT CovidDeaths123$.continent, CovidDeaths123$.location, CovidDeaths123$.date, CovidDeaths123$.population,CovidVaccinations$.new_vaccinations
FROM AdebisiPortfolio..CovidDeaths123$
JOIN AdebisiPortfolio..CovidVaccinations$
ON CovidDeaths123$.location = CovidVaccinations$.location
AND CovidDeaths123$.date = CovidVaccinations$.date
where CovidDeaths123$.continent is not null
and CovidVaccinations$.new_vaccinations is not null
order by 1,2


SELECT CovidDeaths123$.continent, CovidDeaths123$.location, CovidDeaths123$.date, CovidDeaths123$.population,CovidVaccinations$.new_vaccinations
,count(CovidDeaths123$.continent) over (partition by CovidDeaths123$.location)
FROM AdebisiPortfolio..CovidDeaths123$
JOIN AdebisiPortfolio..CovidVaccinations$
ON CovidDeaths123$.location = CovidVaccinations$.location
AND CovidDeaths123$.date = CovidVaccinations$.date
where CovidDeaths123$.continent is not null
and CovidVaccinations$.new_vaccinations is not null
order by 1,2 


--using ctes

SELECT CovidDeaths123$.continent, CovidDeaths123$.location, CovidDeaths123$.date, CovidDeaths123$.population,CovidVaccinations$.new_vaccinations
,sum(convert (int,CovidVaccinations$.new_vaccinations)) over (partition by CovidDeaths123$.location order by CovidDeaths123$.location,CovidDeaths123$.date) as PeopleVaccinated
FROM AdebisiPortfolio..CovidDeaths123$
JOIN AdebisiPortfolio..CovidVaccinations$
ON CovidDeaths123$.location = CovidVaccinations$.location
AND CovidDeaths123$.date = CovidVaccinations$.date
where CovidDeaths123$.continent is not null
and CovidVaccinations$.new_vaccinations is not null
order by 1,2 


SELECT CovidDeaths123$.continent, CovidDeaths123$.location, CovidDeaths123$.date, CovidDeaths123$.population,CovidVaccinations$.new_vaccinations
,sum(convert (int,CovidVaccinations$.new_vaccinations)) over (partition by CovidDeaths123$.location order by CovidDeaths123$.location,CovidDeaths123$.date) as PeopleVaccinated
, (PeopleVaccinated/population)*100
FROM AdebisiPortfolio..CovidDeaths123$
JOIN AdebisiPortfolio..CovidVaccinations$
ON CovidDeaths123$.location = CovidVaccinations$.location
AND CovidDeaths123$.date = CovidVaccinations$.date
where CovidDeaths123$.continent is not null
order by 1,2


WITH PopvsVac (Continent, location, date, population, new_vaccinations, Peoplevaccinated)
AS
(
SELECT CovidDeaths123$.continent, CovidDeaths123$.location, CovidDeaths123$.date, CovidDeaths123$.population, CovidVaccinations$.new_vaccinations
,sum(convert (int,CovidVaccinations$.new_vaccinations)) over (partition by CovidDeaths123$.location order by CovidDeaths123$.location,CovidDeaths123$.date) as PeopleVaccinated
FROM AdebisiPortfolio..CovidDeaths123$
JOIN AdebisiPortfolio..CovidVaccinations$
ON CovidDeaths123$.location = CovidVaccinations$.location
AND CovidDeaths123$.date = CovidVaccinations$.date
where CovidDeaths123$.continent is not null
)
SELECT *, (peoplevaccinated/population)
FROM PopvsVac


--TEMP TABLE
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(300),
Location nvarchar (300),
Date datetime,
Population numeric,
New_vaccination numeric,
Peoplevaccinated numeric
)

Insert into #PercentPopulationVaccinated
SELECT CovidDeaths123$.continent, CovidDeaths123$.location, CovidDeaths123$.date, CovidDeaths123$.population, CovidVaccinations$.new_vaccinations
,sum(convert (int,CovidVaccinations$.new_vaccinations)) over (partition by CovidDeaths123$.location order by CovidDeaths123$.location,CovidDeaths123$.date) as PeopleVaccinated
FROM AdebisiPortfolio..CovidDeaths123$
JOIN AdebisiPortfolio..CovidVaccinations$
ON CovidDeaths123$.location = CovidVaccinations$.location
AND CovidDeaths123$.date = CovidVaccinations$.date
where CovidDeaths123$.continent is not null

SELECT *, (peoplevaccinated/population)*100
FROM #PercentPopulationVaccinated


--dropping table

Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar (255),
Date datetime,
Population numeric,
New_vaccination numeric,
Peoplevaccinated numeric
)

Insert into #PercentPopulationVaccinated
SELECT CovidDeaths123$.continent, CovidDeaths123$.location, CovidDeaths123$.date, CovidDeaths123$.population, CovidVaccinations$.new_vaccinations
,sum(convert (int,CovidVaccinations$.new_vaccinations)) over (partition by CovidDeaths123$.location order by CovidDeaths123$.location,CovidDeaths123$.date) as PeopleVaccinated
FROM AdebisiPortfolio..CovidDeaths123$
JOIN AdebisiPortfolio..CovidVaccinations$
ON CovidDeaths123$.location = CovidVaccinations$.location
AND CovidDeaths123$.date = CovidVaccinations$.date
where CovidDeaths123$.continent is not null

SELECT *, (peoplevaccinated/population)*100
FROM #PercentPopulationVaccinated



--creating views for visualization

Create View PercentPopulationVaccinated as
SELECT CovidDeaths123$.continent, CovidDeaths123$.location, CovidDeaths123$.date, CovidDeaths123$.population, CovidVaccinations$.new_vaccinations
,sum(convert (int,CovidVaccinations$.new_vaccinations)) over (partition by CovidDeaths123$.location order by CovidDeaths123$.location,CovidDeaths123$.date) as PeopleVaccinated
FROM AdebisiPortfolio..CovidDeaths123$
JOIN AdebisiPortfolio..CovidVaccinations$
ON CovidDeaths123$.location = CovidVaccinations$.location
AND CovidDeaths123$.date = CovidVaccinations$.date
where CovidDeaths123$.continent is not null
