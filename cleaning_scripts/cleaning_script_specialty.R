#libraries
library(tidyverse)
library(dplyr)
library(lubridate)
library(tsibble)
library(forcats)
library(scales)

#upload the raw data
specialty <- read.csv("data/raw_data/inpatient_and_daycase_by_nhs_board_of_treatment_and_specialty.csv") %>% 
  janitor::clean_names()

board_codes <- read_csv("data/raw_data/special-health-boards_19022021.csv") %>% 
  janitor::clean_names() %>% 
  rename(hb = shb)
#add names of boards to the data
specialty_and_boards <- left_join(specialty, board_codes, by = "hb")

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
#group_by and summarise - mean episodes.
specialty_mean_episodes <- top_specialty %>% 
  group_by(quarter, specialty_name_top) %>% 
  summarise(mean=mean(episodes))
#writing the data
write_csv(x=specialty_mean_episodes, "data/clean_data/specialty_mean_episodes.csv", append = FALSE)
#group_by and summarise - mean length of spell.
specialty_mean_lengthofspell <- top_specialty %>% 
  group_by(quarter, specialty_name_top) %>% 
  summarise(mean=mean(length_of_spell))
#writing the data
write_csv(x=specialty_mean_lengthofspell, "data/clean_data/specialty_mean_lengthofspell.csv", append = FALSE)

