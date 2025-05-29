# R/data_prep.R

# 1) Pakete
library(tidyverse)
library(jsonlite)
library(countrycode)
library(maps)
library(here)

# 2) JSON-Pfad & Einlesen
json_path <- here("src", "Case_Study_4", "data", "data_cia2.json")
cia_raw   <- fromJSON(json_path, flatten = TRUE)

# 3) Karte mit ISO-Codes (für Regionen, die countrycode erkennt)
world_map <- map_data("world") %>%
  mutate(
    iso3c = countrycode(region,
                        origin      = "country.name",
                        destination = "iso3c")
  )

# 4) CIA-Daten: ISO3 umbenennen & Fallback für fehlende
cia_clean <- cia_raw %>%
  # benutze deine vorhandene ISO3-Spalte
  rename(iso3c = ISO3) %>%
  # wo ISO3 leer ist, versuch countrycode
  mutate(
    iso3c = if_else(
      is.na(iso3c) | iso3c == "",
      countrycode(country, "country.name", "iso3c"),
      iso3c
    )
  ) %>%
  # Sonderfälle manuell nachpflegen (falls nötig)
  mutate(
    iso3c = case_when(
      country == "Kosovo"       ~ "XKX",
      country == "Micronesia"   ~ "FSM",
      TRUE                       ~ iso3c
    )
  ) %>%
  # 5) Duplikate pro ISO-Code entfernen
  distinct(iso3c, .keep_all = TRUE)

# 6) Join bringen wir alles zusammen
world_full <- world_map %>%
  left_join(cia_clean, by = "iso3c")

# 7) Ergebnis zurückgeben
prepare_world_data <- function() {
  world_full
}

glimpse(prepare_world_data())





