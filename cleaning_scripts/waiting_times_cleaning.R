library(tidyverse)
library(here)

#------------------------- Data Sets -------------------------------------------
waiting_times <-
  read_csv(here("data/raw_data/monthly_ae_waitingtimes_202303.csv")) %>% 
  janitor::clean_names()

#------------------------- Add in Health board names ---------------------------
waiting_times_clean <- waiting_times %>% 
  # remove special health boards
  filter(str_detect(hbt, "^S08")) %>% 
  mutate(hb = recode(hbt,
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
                      "S08000028" =	"Western Isles"
  ))


#------------------------- Add Seasonality ------------------------------------

waiting_times_clean <- waiting_times_clean %>% 
  filter(month %in% 201701:202303) %>% 
  mutate(season = case_when(str_detect(month, "12$") ~ "Winter",
                            str_detect(month, "0[12]$") ~ "Winter",
                            TRUE ~ "Other"))

#------------------------------ write csv -------------------------------------

waiting_times_clean <- waiting_times_clean %>% 
  select(hb, month, season,
         number_of_attendances_aggregate,
         discharge_destination_admission_to_same,
         discharge_destination_residence)

write_csv(waiting_times_clean, here("data/clean_data/waiting_times_clean.csv"))
