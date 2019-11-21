#placeholder file for HW5
library(readr)

homicides <- read_csv("https://raw.githubusercontent.com/washingtonpost/data-homicides/master/homicide-data.csv")
write_csv(homicides, "data/homicides-data.csv")
