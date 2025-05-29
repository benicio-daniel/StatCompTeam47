# Required libraries
# install.packages(c("tidyverse","jsonlite","countrycode","maps", "here", "dplyr"))

library(tidyverse)
library(jsonlite)
library(countrycode)
library(maps)
library(here)
library(dplyr)


# loading the data
json_path <- here::here("src", "Case_Study_4", "data", "data_cia2.json")
json_text <- readLines(json_path, warn = FALSE)
cia_raw <- fromJSON(paste(json_text, collapse = ""), flatten = TRUE)

# data preparation

## rename variables
cia <- cia_raw %>%
  rename(
    iso3 = ISO3,
    index = X,
    income_status = status,
    edu_exp = expenditure,
    unemp_youth_rate = youth_unempl_rate,
    life_exp = life_expectancy,
    pop = population
  )

## recode variable
cia$income_status <- recode(cia$income_status,
                             "H" = "High",
                             "UM" = "Upper middle",
                             "LM" = "Lower middle",
                             "L" = "Low")
#print(names(cia_raw))
#glimpse(cia)

# join mit worldmap






























