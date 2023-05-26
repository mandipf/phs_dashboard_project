#libraries
library(tidyverse)
library(here)

#upload the raw data
specialty_and_boards <- 
  read.csv(here("data/raw_data/inpatient_and_daycase_by_nhs_board_of_treatment_and_specialty.csv")) %>% 
  janitor::clean_names() %>% 
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
                     "S08000028" =	"Western Isles"))

# find top10 specialties
top10_specialties <- specialty_and_boards %>%
  summarise(episodes = sum(episodes),
            .by = specialty_name) %>% 
  slice_max(episodes, n = 10) %>% 
  pull(specialty_name)

#naming all specialties apart from TOP-10 as "Other" 
top_specialty <- specialty_and_boards %>% 
  mutate(specialty = if_else(specialty_name %in% top10_specialties,
                             specialty_name,
                             "Other"))

#selecting only needed columns
specialty_clean <- top_specialty %>% 
  select(quarter, hb, specialty, episodes, length_of_spell) %>% 
  # replace zeroes with NA in numerical columns
  mutate(across(.cols = c(episodes, length_of_spell),
                .fns = ~ na_if(.x, 0))) %>% 
  # remove any rows that have NA for both numerical columns
  filter(!(is.na(episodes) & (is.na(length_of_spell))))

#write the data
write_csv(x=specialty_clean, here("data/clean_data/specialty_clean.csv"))

