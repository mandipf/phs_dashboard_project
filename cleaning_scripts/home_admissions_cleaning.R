library(tidyverse)

#------------------------- Data Sets -------------------------------------------
admissions <- read_csv(here::here("data/raw_data/activity_by_board_of_treatment_Age_and_sex.csv"))


home_hb_admissions <- admissions %>% 
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
                     "S92000003" = "Scotland",
                     "S27000001" = "Non-NHS Provider/Location", 
                     "SN0811" = "Louisa Jordan"
  )) %>% 
  
# Select columns
  
  select(Quarter, HB, LengthOfStay, Episodes)

#------------------------------ write csv -------------------------------------

write_csv(home_hb_admissions,here::here("data/clean_data/home_hb_admissions.csv"))
