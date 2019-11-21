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

homicides_map_omaha <- homicides %>%
  filter(city == "Omaha") %>%
  mutate(victim_race = fct_lump(victim_race, n=4, other_level = "Other")) %>%
  st_as_sf(coords = c("lon","lat")) %>%
  st_set_crs(4269)

omaha_zip_codes <- tigris::zctas(starts_with = c("681"), tigris_cache_dir("data/")) %>%
  st_as_sf(omaha_zip_codes) %>% st_set_crs(4269) 

#All Omaha zip codes start with 681, but this also brings in a few non-Omaha zip codes to the south

omaha_blocks <- block_groups()
  
  