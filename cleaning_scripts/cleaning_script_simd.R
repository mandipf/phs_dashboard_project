# read in libraries
library(tidyverse)

#read in data
simd <- read_csv("data/raw_data/4fc640aa-bdd4-4fbe-805b-1da1c8ed6383.csv") %>% 
  janitor::clean_names()

# add health board names
simd_hb <- simd %>% 
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
simd_clean <- simd_hb %>% 
  select(id, quarter, hb, simd, episodes, length_of_stay)

# write clean file to cleaned data folder
write_csv(simd_clean, "data/clean_data/simd_clean.csv", append = FALSE)
