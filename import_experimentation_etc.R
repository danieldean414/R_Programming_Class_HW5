#placeholder file for HW5

# Experimenting for now; probably delete in final version
library(readr)
library(dplyr)

homicides <- read_csv("https://raw.githubusercontent.com/washingtonpost/data-homicides/master/homicide-data.csv")
#write_csv(homicides, "data/homicides-data.csv") #writing local copy

  #names all seem fine already
  

homicides %>%
  head()
