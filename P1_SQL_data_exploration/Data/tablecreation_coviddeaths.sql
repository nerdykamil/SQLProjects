-- Table: myschema.CovidDeaths

-- DROP TABLE IF EXISTS myschema."CovidDeaths";

CREATE TABLE IF NOT EXISTS myschema."CovidDeaths"
(
    iso_code text COLLATE pg_catalog."default",
    continent text COLLATE pg_catalog."default",
    location text COLLATE pg_catalog."default",
    date date,
    population bigint,
    new_cases bigint,
    new_cases_smoothed numeric,
    total_deaths bigint,
    new_deaths bigint,
    new_deaths_smoothed numeric,
    total_cases_per_million numeric,
    new_cases_per_million numeric,
    new_cases_smoothed_per_million numeric,
    total_deaths_per_million numeric,
    new_deaths_per_million numeric,
    new_deaths_smoothed_per_million numeric,
    reproduction_rate numeric,
    icu_patients bigint,
    icu_patients_per_million numeric,
    hosp_patients numeric,
    hosp_patients_per_million numeric,
    weekly_icu_admissions numeric,
    weekly_icu_admissions_per_million numeric,
    weekly_hosp_admissions numeric,
    weekly_hosp_admissions_per_million numeric,
    new_tests bigint,
    total_tests bigint
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS myschema."CovidDeaths"
    OWNER to postgres;