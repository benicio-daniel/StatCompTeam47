# Required libraries
install.packages(c("tidyverse","jsonlite","countrycode","maps"))

library(tidyverse)
library(jsonlite)
library(countrycode)
library(maps)


# loading the data
cia_raw <- fromJSON("data/data_cia2.json", flatten = TRUE)
glimpse(cia_raw)
