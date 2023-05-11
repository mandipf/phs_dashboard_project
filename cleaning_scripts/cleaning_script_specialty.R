#libraries
library(tidyverse)
library(dplyr)
library(lubridate)
library(tsibble)
library(forcats)
library(scales)

#upload the raw data
specialty_and_boards <- read.csv("data/raw_data/inpatient_and_daycase_by_nhs_board_of_treatment_and_specialty.csv") %>% 
  janitor::clean_names() %>% 
  mutate(hb = recode(hb,
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
  ))

#naming all specialties apart from TOP-10 as "Other" 
top_specialty <- specialty_and_boards %>% 
  mutate(specialty_name_top = 
           ifelse(specialty_name == "General Medicine", "General Medicine",
                  ifelse(specialty_name == "General Surgery", "General Surgery", 
                         ifelse(specialty_name == "Geriatric Medicine", "Geriatric Medicine",
                                ifelse(specialty_name == "Cardiothoracic Surgery", "Cardiothoracic Surgery",
                                       ifelse(specialty_name == "Trauma and Orthopaedic Surgery", "Trauma and Orthopaedic Surgery", 
                                              ifelse(specialty_name == "Cardiology", "Cardiology",
                                                     ifelse(specialty_name == "Medical oncology", "Medical oncology",
                                                            ifelse(specialty_name == "Gastroenterology", "Gastroenterology", 
                                                                   ifelse(specialty_name == "Urology", "Urology",
                                                                          ifelse(specialty_name == "Haematology", "Haematology", "Other" 
                                                                          )))))))))), .after=specialty_name) 
#selecting only needed columns
specialty_clean <- top_specialty %>% 
  select(quarter, hb, specialty_name_top, episodes, length_of_spell)

#write the data
write_csv(x=specialty_clean, "data/clean_data/specialty_clean.csv", append = FALSE)

