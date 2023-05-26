library(tidyverse)
library(here)

# import data set
hB_names <-
  read_csv(here("data/raw_data/health_board_names.csv")) %>% 
  janitor::clean_names()

# remove NHS prefix and select required columns
hb_names_clean <- hB_names %>% 
  mutate(hb_name = str_remove(hb_name, "^NHS ")) %>% 
  select(hb, hb_name) 

#------------------------------ write csv -------------------------------------

write_csv(hb_names_clean, here("data/clean_data/hb_names_clean.csv"))
