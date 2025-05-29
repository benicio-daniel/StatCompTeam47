# --------------------------------------------------
# Load Required Packages
# --------------------------------------------------
# install.packages(c("tidyverse","jsonlite","countrycode","maps", "here"))
library(tidyverse)
library(jsonlite)
library(countrycode)
library(maps)
library(here)

# --------------------------------------------------
# Load JSON Data
# --------------------------------------------------
json_path <- here("src", "Case_Study_4", "data", "data_cia2.json")
json_text <- readLines(json_path, warn = FALSE)
cia_raw <- fromJSON(paste(json_text, collapse = ""), flatten = TRUE)

# --------------------------------------------------
# Clean and Rename Variables
# --------------------------------------------------
cia <- cia_raw %>%
  rename(
    index              = X,
    income_status      = status,
    edu_exp            = expenditure,
    unemp_youth_rate   = youth_unempl_rate,
    life_exp           = life_expectancy,
    pop                = population
  ) %>%
  mutate(
    income_status = recode(income_status,
                           "H"  = "High",
                           "UM" = "Upper middle",
                           "LM" = "Lower middle",
                           "L"  = "Low")
  )

# --------------------------------------------------
# Aggregate Countries (handle duplicates)
# --------------------------------------------------
cia <- cia %>%
  group_by(ISO3) %>%
  summarise(
    country                 = first(country),
    index                   = first(index),
    continent               = first(continent),
    subcontinent            = first(subcontinent),
    income_status           = first(income_status),
    edu_exp                 = mean(edu_exp, na.rm = TRUE),
    unemp_youth_rate        = mean(unemp_youth_rate, na.rm = TRUE),
    net_migr_rate           = mean(net_migr_rate, na.rm = TRUE),
    pop_growth_rate         = mean(pop_growth_rate, na.rm = TRUE),
    life_exp                = mean(life_exp, na.rm = TRUE),
    low_yu                  = first(low_yu),
    high_nmr                = first(high_nmr),
    electricity_fossil_fuel = if (all(is.na(electricity_fossil_fuel))) NA else max(electricity_fossil_fuel, na.rm = TRUE),
    area                    = sum(area, na.rm = TRUE),
    pop                     = sum(pop, na.rm = TRUE)
  ) %>%
  ungroup() %>%
  mutate(
    country = if_else(ISO3 == "PSE",
                      "Palestinian Territories (combined: West Bank + Gaza Strip)",
                      country)
  )

# --------------------------------------------------
# Load World Map and Attach ISO3 Codes
# --------------------------------------------------
world_map <- map_data("world") %>%
  mutate(
    ISO3 = suppressWarnings(   # clear Warining in Output
      countrycode(region, origin = "country.name", destination = "iso3c")
    )
  )

# --------------------------------------------------
# Join Map Data with CIA Dataset
# --------------------------------------------------
world_full <- world_map %>%
  left_join(cia, by = "ISO3")

# --------------------------------------------------
# Return Prepared Dataset for Use in Shiny App
# --------------------------------------------------
prepare_data <- function() {
  world_full
}