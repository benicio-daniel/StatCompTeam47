# Required libraries
# install.packages(c("tidyverse","jsonlite","countrycode","maps", "here", "dplyr"))

library(tidyverse)
library(jsonlite)
library(countrycode)
library(maps)
library(here)
library(dplyr)


# ---- Weltkarte ----------------------------------------------------------
world_map <- map_data("world") %>% 
  mutate(iso3c = countrycode(region,
                             origin      = "country.name",
                             destination = "iso3c"))

# ---- CIA-Daten ----------------------------------------------------------
json_path <- here::here("src", "Case_Study_4", "data", "data_cia2.json")
json_text <- readLines(json_path, warn = FALSE)
cia_raw <- fromJSON(paste(json_text, collapse = ""), flatten = TRUE)

# 1) Prüfen, wie die Länderspalte heißt
names(cia_raw)       # z. B. "country", "name", "Country", ...

# 2) ISO-Codes ergänzen (falls noch nicht vorhanden)
cia <- cia_raw %>% 
  rename(country = your_country_column) %>%     # <- anpassen!
  mutate(iso3c = countrycode(country,
                             "country.name",
                             "iso3c"))

# 3) Duplikate pro Land entfernen (wichtige Falle!)
cia_unique <- cia %>% 
  distinct(iso3c, .keep_all = TRUE)    # pro ISO-Code nur 1 Zeile

# ---- Join ---------------------------------------------------------------
world_full <- world_map %>% 
  left_join(cia_unique, by = "iso3c")

# Länder, die in der CIA-Liste sind, aber NICHT in der Karte gematcht wurden
missing_in_map <- cia_unique %>% 
  anti_join(world_map, by = "iso3c") %>% 
  select(country, iso3c)

# Umgekehrt: Kartengeometrien ohne CIA-Infos
missing_in_cia <- world_map %>% 
  anti_join(cia_unique, by = "iso3c") %>% 
  distinct(region, iso3c)

cia_unique <- cia_unique %>% 
  mutate(
    iso3c = case_when(
      country == "Côte d'Ivoire" ~ "CIV",
      country == "Congo, Democratic Republic of the" ~ "COD",
      TRUE ~ iso3c
    )
  )




