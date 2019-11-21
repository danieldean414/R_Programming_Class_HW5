# tigris testing (probably delete eventually; plan to be pasting/running demos) 
  #1: loosely following https://www.computerworld.com/article/3175623/mapping-in-r-just-got-a-whole-lot-easier.html


us_geo <- states(class = "sf")
#wagemap <- append_data(us_geo, wages, key.shp = "NAME", key.data = "State")


homicide_summary <- homicides %>%
  group_by(state) %>%
  summarize(homicide_count = n())


#homicide_map <- left_join(homicide_summary, us_geo, by = c('STUSPS' = 'state'))
#Kind of a weird workaround for now; for some reason above doesn't work

homicide_summary %>%
  rename(STUSPS = state) %>%
  left_join(us_geo) %>%
  rename(state = STUSPS)

austin_roads <- roads("TX","Austin")
plot(austin_roads)

#install.packages("tmap")
library(tmap)
tm_shape(austin_roads)

chi_counties <- c("Cook", "DeKalb", "DuPage", "Grundy", "Lake", 
                  "Kane", "Kendall", "McHenry", "Will County")
chi_tracts <- tracts(state = "IL", county = chi_counties, 
                     cb = TRUE)


values = 

chi_joined = geo_join(chi_tracts, values, by = "GEOID")

tm_shape(chi_joined, projection = 26916)




##

co_counties <- counties(state = "CO", cb = TRUE, class = "sf")
#larimer <- tigris::zctas(state = "CO")

co_counties %>% 
  slice(1:3)


library(ggplot2)

ggplot() + 
  geom_sf(data = co_counties, aes(fill = ALAND))


# Moving on to making an sf object

library(sf)

homicides_map_omaha <- homicides %>%
  filter(city == "Omaha") %>%
  mutate(victim_race = fct_lump(victim_race, n=4, other_level = "Other")) %>%
  st_as_sf(coords = c("lon","lat")) %>%
  st_set_crs(4269)



omaha_zip_codes <- tigris::zctas(starts_with = c("681")) 

omaha_zip_codes_sf <- st_as_sf(omaha_zip_codes) %>% st_set_crs(4269)


st_bbox(omaha_zip_codes)
plot(omaha_zip_codes)


#geo_join(omaha_zip_codes, homicides_map_omaha, by_sp )

library(viridis)
library(ggthemes)

ggplot() + 
  geom_sf(data = omaha_zip_codes_sf, color = "lightgray") + 
  geom_sf(data = homicides_map_omaha, aes(color = month(reported_date),
                                shape = disposition)) + 
  scale_color_viridis(name = "Month") 

ggplot() + 
  geom_sf(data = omaha_zip_codes_sf) + 
  geom_sf(data = homicides_map_omaha, aes(fill = victim_race, color = victim_race)) +
  facet_wrap(.~disposition) +
  labs(title = "Omaha, NE (2007-2015) Homicides", subtitle = "Outcome and Location", color = "Race of Victim", xlab = "Longitude", ylab = "Latitude") +
  theme_tufte()
  
