library(tidycensus)
library(tidyverse)
library(mapview)

us_state_pop <- get_acs(
  geography = "state", 
  year = 2019,
  variables = c("population" = "B01001_001"), 
  geometry = TRUE)

non_contiguous_regions <- c("Alaska", "Hawaii", "Rhode Island", "Puerto Rico")

us_contiguous <- us_state_pop %>% 
  filter(!NAME %in% non_contiguous_regions)

us_contiguous %>% 
  mapview(zcol = "estimate")
