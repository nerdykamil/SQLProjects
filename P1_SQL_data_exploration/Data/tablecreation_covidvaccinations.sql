-- Table: myschema.CovidVaccinations

DROP TABLE IF EXISTS myschema."CovidVaccinations";

CREATE TABLE IF NOT EXISTS myschema."CovidVaccinations"
(
    iso_code text COLLATE pg_catalog."default",
    continent text COLLATE pg_catalog."default",
    location text COLLATE pg_catalog."default",
    date date,
	new_tests bigint,	
    total_tests bigint,
	total_tests_per_thousand numeric,
	new_tests_per_thousand numeric,
    new_tests_smoothed numeric,
	new_tests_smoothed_per_thousand numeric,
    positive_rate numeric,
	tests_per_case numeric,
	tests_units text,
	total_vaccinations numeric,
    people_vaccinated numeric,
	people_fully_vaccinated numeric,
	new_vaccinations numeric,
    new_vaccinations_smoothed numeric,
	total_vaccinations_per_hundred numeric,
    people_vaccinated_per_hundred numeric,
	people_fully_vaccinated_per_hundred numeric,
    new_vaccinations_smoothed_per_million numeric,
	stringency_index numeric,
	population_density numeric,
	median_age numeric,
	aged_65_older numeric,
	aged_70_older numeric,
    gdp_per_capita numeric,
	extreme_poverty numeric, 
	cardiovasc_death_rate numeric,
    diabetes_prevalence numeric,
	female_smokers numeric,
	male_smokers numeric,
    handwashing_facilities numeric,
	hospital_beds_per_thousand numeric,
    life_expectancy numeric,
	human_development_index numeric

)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS myschema."CovidVaccinations"
    OWNER to postgres;