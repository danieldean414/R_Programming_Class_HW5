#placeholder file for HW5

# Experimenting for now; probably delete in final version
library(readr)
library(dplyr)
library(lubridate)
library(stringr)
library(tigris)
library(forcats)
library(sf)

homicides <- read_csv("https://raw.githubusercontent.com/washingtonpost/data-homicides/master/homicide-data.csv") %>%
  mutate(reported_date = str_replace(string = reported_date, pattern = "201511018", replacement =  "20151018"),
         reported_date = str_replace(string = reported_date, pattern = "201511105", replacement =  "20151018"),
         reported_date = ymd(reported_date)
         ) %>% #correcting apparent typos before converting to date format
  mutate_at(.vars = c('victim_race', 'victim_sex', 'city', 'state', 'disposition'), .funs = as.factor) %>%
  mutate(victim_age = as.numeric(victim_age)) %>%
  mutate(disposition = fct_collapse(disposition,
                Solved = "Closed by arrest",
               Unsolved = c("Closed without arrest","Open/No arrest")
               ))
#subsetting for Omaha
homicides_map_omaha <- homicides %>%
  filter(city == "Omaha") %>%
  mutate(victim_race = fct_lump(victim_race, n=4, other_level = "Other")) %>%
  add_count(victim_race, name = "race_count") %>%
  mutate(victim_race = fct_reorder(victim_race, .x = race_count, .desc = TRUE)) %>%
  st_as_sf(coords = c("lon","lat")) %>%
  st_set_crs(4269)

#Importing census tracts:
omaha_tracts <- tracts("NE", county = "Douglas") %>%
  st_as_sf() %>%  
  st_set_crs(4269)
  