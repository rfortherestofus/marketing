library(tidycensus)
library(tidyverse)
library(scales)

us_state_pop <- get_acs(
  geography = "state", 
  year = 2019,
  variables = c("population" = "B01001_001"), 
  geometry = TRUE)

non_contiguous_regions <- c("Alaska", "Hawaii", "Rhode Island", "Puerto Rico")

us_contiguous <- us_state_pop %>% 
  filter(!NAME %in% non_contiguous_regions)

us_contiguous %>% 
  ggplot() +
  geom_sf(aes(fill = estimate)) +
  scale_fill_viridis_c(label = number_format(scale = 1E-6, suffix = " Million"),
                       name = "") +
  labs(title = "State population for the contiguous US",
       subtitle = "Data: ACS Survey") +
  theme_void() +
  theme(legend.position = "top",
        legend.key.width = unit(3, "cm"))
