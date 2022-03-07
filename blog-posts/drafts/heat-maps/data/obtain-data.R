library(tigris)
library(sf)
library(rmapshaper)
library(tidyverse)
library(janitor)

# ==== States Data =====

us_contiguous <- states() %>% 
  clean_names() %>% 
  mutate(statefp = as.numeric(statefp)) %>% 
  filter(statefp < 60,
         !statefp %in% c(2, 15)) %>% 
  ms_simplify()

us_contiguous %>% 
  write_sf("data/us-contiguous/us-contiguous.shp")
