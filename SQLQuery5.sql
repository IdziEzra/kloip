select *
from portfolioproject..['covid deaths$']
where continent is not NULL 
order by 3,4

select location, date, total_cases, new_cases, total_deaths, population
From portfolioproject..['covid deaths$']
where continent is not NULL 
order by 1,2 

--looking at total cases vs total deaths
--possibility of dying from contrcting covid in nigeri is really low


select location, date, total_cases,  total_deaths, (total_deaths/total_cases)*100 as Deathpercentage
From portfolioproject..['covid deaths$']
--where location like 'Nigeria'
where continent is not NULL 
order by 1,2 

--total cases vs population of covid cases in nigeria
--shows the percentage of residents in nigeria that have got covid

select location, date,  population, total_cases, (total_cases/population)*100 as populationInfected
From portfolioproject..['covid deaths$']
--where location like 'Nigeria'
where continent is not NULL   
order by 1,2 

--looking at highest hit country compared to population

  
--showing countries with highest Death Count per population

select location,  MAX(cast(total_deaths as int)) as TotalDeathCount
From portfolioproject..['covid deaths$']
--where location like 'Nigeria'
where continent is not NULL
Group by location
order by TotalDeathCount desc

select continent, SUM(cast(total_deaths as int)) as TotalDeathCount
From portfolioproject..['covid deaths$']
--where location like 'Nigeria'
where continent is not NULL
Group by continent
order by TotalDeathCount desc

--BREAK THINGS DOWN BY CONTINENT  

select continent,  MAX(cast(total_deaths as int)) as TotalDeathCount
From portfolioproject..['covid deaths$']
--where location like 'Nigeria'
where continent is not NULL
Group by continent
order by TotalDeathCount desc

--SHOWING CONTINENT WITH HIGHEST DEATHCOUNTS

select continent, MAX(cast(total_deaths as int)) as TotalDeathCount 
From portfolioproject..['covid deaths$']
--where location like 'Nigeria'
where continent is not NULL
Group by continent
order by TotalDeathCount desc



-- GLOBAL NUMBERS


select SUM(new_cases)as total_cases, SUM(cast(new_Deaths as int))as total_deaths, SUM(cast(new_Deaths as int))/SUM(new_cases)*100 as Deathpercentage
From portfolioproject..['covid deaths$']
--where location like 'Nigeria'
where continent is not NULL 
--Group by date
order by 1,2 desc


select location, population, MAX(total_cases) as HighestInfectedCount, MAX((Total_cases/population))*100 as percentagepopulationInfected
from portfolioproject..['covid deaths$']
group by location, population
Order by percentagepopulationInfected desc 


select location, population, date, MAX(total_cases) as HighestInfectedCount, MAX((Total_cases/population))*100 as percentagepopulationInfected
from portfolioproject..['covid deaths$']
group by location, population, date
Order by percentagepopulationInfected desc 




select *
From portfolioproject..covidvaccinations$


--Looking at total population vs vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER (partition by dea.Location Order by dea.location, dea.date)   
From portfolioproject..['covid deaths$'] dea
join portfolioproject..covidvaccinations$ vac
    on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not NULL 
	order by 1,2,3

