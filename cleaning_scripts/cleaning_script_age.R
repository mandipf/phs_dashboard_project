# read in libraries
library(tidyverse)

#read in data
age_sex <- read_csv("data/raw_data/00c00ecc-b533-426e-a433-42d79bdea5d4.csv") %>% 
  janitor::clean_names()

# add health board names
age_sex_hb <- age_sex %>% 
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
                     "SN0811" = "National Facility NHS Louisa Jordan")
  )

# select columns we need
age_sex_clean <- age_sex_hb %>% 
  select(id, quarter, hb, sex, age, episodes, length_of_stay)

# write clean file to cleaned data folder
write_csv(age_sex_clean, "data/clean_data/age_sex_clean.csv", append = FALSE)
