library(tidycensus)
library(tidyverse)

us_state_pop <- get_acs(
  geography = "state", 
  year = 2019,
  variables = c("population" = "B01001_001"), 
  geometry = TRUE)

us_state_pop %>% 
  filter(NAME == "Florida")

non_contiguous_regions <- c("Alaska", "Hawaii", "Rhode Island", "Puerto Rico")

us_contiguous <- us_state_pop %>% 
  filter(!NAME %in% non_contiguous_regions)
