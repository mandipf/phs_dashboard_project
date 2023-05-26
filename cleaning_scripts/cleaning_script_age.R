# read in libraries
library(tidyverse)
library(here)

#read in data
age_sex <- 
  read_csv(here("data/raw_data/inpatient_and_daycase_by_nhs_board_of_treatment_age_and_sex.csv")) %>% 
  janitor::clean_names()

# add health board names
age_sex_hb <- age_sex %>%
  # remove special health boards
  filter(str_detect(hb, "^S08")) %>% 
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
                     "S08000028" =	"Western Isles")
  )

# select columns we need
age_sex_clean <- age_sex_hb %>% 
  select(quarter, hb, sex, age, episodes, length_of_stay) %>% 
  # replace zeroes with NA in numerical columns
  mutate(across(.cols = c(episodes, length_of_stay),
                .fns = ~ na_if(.x, 0))) %>% 
  # remove any rows that have NA for both numerical columns
  filter(!(is.na(episodes) & (is.na(length_of_stay))))

# write clean file to cleaned data folder
write_csv(age_sex_clean, here("data/clean_data/age_sex_clean.csv"))
