#placeholder file for HW5

# Experimenting for now; probably delete in final version
library(readr)
library(dplyr)
library(lubridate)
library(stringr)



homicides <- read_csv("https://raw.githubusercontent.com/washingtonpost/data-homicides/master/homicide-data.csv")
#write_csv(homicides, "data/homicides-data.csv") #writing local copy


homicides %>%
  mutate(reported_date = str_replace(string = reported_date, pattern = "201511018", replacement =  "20151018")) %>% #correcting apparent typos
  mutate(reported_date = str_replace(string = reported_date, pattern = "201511105", replacement =  "20151018")) %>% #couldn't figure out in one step
  mutate(reported_date = ymd(reported_date))

  
  