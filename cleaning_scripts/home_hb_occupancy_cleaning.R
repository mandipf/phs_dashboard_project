library(tidyverse)


#------------------------- Data Sets -------------------------------------------
hospital_beds <- read_csv(here::here("data/raw_data/beds_by_board_of_treatment_and_specialty.csv"))


#------------------------- Add in Healthboard names ----------------------------

home_hb_occupancy <- hospital_beds %>% 
  mutate(HB = recode(HB,
                     "SB0801" = "The Golden Jubilee National Hospital",
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
                     "S08000028" =	"Western Isles",
                     "S92000003" = "Scotland"
  )) %>% 


# Select columns 

filter(SpecialtyName == "All Acute") %>% 
  select(Quarter, HB, PercentageOccupancy ) 

#------------------------------ write csv -------------------------------------

write_csv(home_hb_occupancy,here::here("data/clean_data/home_hb_occupancy.csv"))
