library(tidycensus)
library(tidyverse)
library(leaflet)

us_state_pop <- get_acs(
  geography = "state", 
  year = 2019,
  variables = c("population" = "B01001_001"), 
  geometry = TRUE)

non_contiguous_regions <- c("Alaska", "Hawaii", "Rhode Island", "Puerto Rico")

us_contiguous <- us_state_pop %>% 
  filter(!NAME %in% non_contiguous_regions)

pal_state_pop <- colorNumeric("viridis", us_contiguous$estimate)

label_state <- function(state, pop){
  str_glue("{state} with population of {pop}")
}

us_contiguous %>% 
  leaflet() %>% 
  addPolygons(weight = 1,
              color = "white",
              fillColor = ~pal_state_pop(estimate),
              fillOpacity = 1,
              popup = ~label_state(NAME, estimate)) %>% 
  addLegend(pal = pal_state_pop,
            values = ~estimate,
            opacity = 1)
