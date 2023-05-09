library(tidyverse)

#------------------------- Data Sets -------------------------------------------
waiting_times <- read_csv(here::here("data/raw_data/a&e_waiting_times.csv"))

#------------------------- Add in Health board names ---------------------------
waiting_times_clean <- waiting_times %>% 
  mutate(HBT = recode(HBT,
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
  filter(Month %in% 201701:202303) 

waiting_times_clean <-waiting_times_clean %>% 
  mutate(Month2 = as.character(Month))

waiting_times_clean <- waiting_times_clean %>%
  mutate(Season = case_when(str_detect(Month2, "0[345]$") ~ "ASpring", 
                            str_detect(Month2, "0[678]$") ~ "BSummer",
                            str_detect(Month2, "09$") ~ "CAutumn",
                            str_detect(Month2, "1[01]$") ~ "CAutumn",
                            TRUE ~ "DWinter")) %>% 
  mutate(Year = str_c(str_sub(Month2, 1L,4L), "_",Season))


#------------------------------ write csv -------------------------------------

write_csv(waiting_times_clean,here::here("data/clean_datawaiting_times_clean.csv"))
