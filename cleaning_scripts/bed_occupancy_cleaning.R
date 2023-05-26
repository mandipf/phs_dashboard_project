library(tidyverse)
library(here)


#------------------------- Data Sets -------------------------------------------
hospital_beds <- 
  read_csv(here("data/raw_data/beds_by_nhs_board_of_treatment_and_specialty.csv")) %>% 
  janitor::clean_names()


#------------------------- Add in Healthboard names ----------------------------

home_hb_occupancy <- hospital_beds %>% 
  # remove special health boards
  filter(str_detect(hb, "^S08")) %>% 
  # recode to full health board name
  mutate(hb = recode(hb,
                     "S08000015" = "Ayrshire and Arran",				
                     "S08000016" = "Borders",
                     "S08000017" =	"Dumfries and Galloway",
                     "S08000029" = "Fife",
                     "S08000019" =	"Forth Valley",
                     "S08000020"	= "Grampian",
                     "S08000031" =	"Greater Glasgow and Clyde",
                     "S08000022" =	"Highland",
                     "S08000032" =	"Lanarkshire",
                     "S08000024" =	"Lothian",
                     "S08000025"	= "Orkney",
                     "S08000026" = "Shetland",
                     "S08000030" =	"Tayside",
                     "S08000028" =	"Western Isles")) %>% 
  # Select columns for "All acute"
  filter(specialty_name == "All Acute") %>% 
  select(quarter, hb, percentage_occupancy ) 

#------------------------------ write csv -------------------------------------

write_csv(home_hb_occupancy, here("data/clean_data/bed_occupancy_clean.csv"))
