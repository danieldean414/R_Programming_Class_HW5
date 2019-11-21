#placeholder file for HW5

# Experimenting for now; probably delete in final version
library(readr)
library(dplyr)
library(lubridate)
library(stringr)
library(tigris)



homicides <- read_csv("https://raw.githubusercontent.com/washingtonpost/data-homicides/master/homicide-data.csv") %>%
  mutate(reported_date = str_replace(string = reported_date, pattern = "201511018", replacement =  "20151018"),
         reported_date = str_replace(string = reported_date, pattern = "201511105", replacement =  "20151018"),
         reported_date = ymd(reported_date)
         ) %>% #correcting apparent typos before converting to date format
  mutate_at(.vars = c('victim_race', 'victim_sex', 'city', 'state', 'disposition'), .funs = as.factor) %>%
  mutate(victim_age = as.numeric(victim_age))

  
  