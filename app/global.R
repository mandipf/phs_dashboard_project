# LIBRARIES FOR APP
library(tidyverse)
library(bslib)
library(here)
library(shinyWidgets)


# DATA FOR APP
ae_df <- read_csv(here("data/clean_data/waiting_times_clean.csv"))
age_sex_df <- read_csv(here("data/clean_data/age_sex_clean.csv"))
hb_names_df <- read_csv(here("data/clean_data/hb_names_clean.csv"))
bed_occ_df <- read_csv(here("data/clean_data/bed_occupancy_clean.csv"))
simd_df <- read_csv(here("data/clean_data/simd_clean.csv"))
specialty_df <- read_csv(here("data/clean_data/specialty_clean.csv"))


# PLOT STYLING
source("R/plot_themes.R")


# INTERMEDIATE VARIABLES
sidebarpanel_width = 3
hb_choices <- unique(hb_names_df$hb_name)

# age and gender intermediate variables
age_choices <- unique(age_sex_df$age)
age_default <- unique(age_sex_df$age)

sex_choices <- c("All", "Female", "Male")

# SIMD intermediate variables
deprivation_choices <- list("1(Most Deprived)" = 1,
                            "2" = 2,
                            "3" = 3,
                            "4" = 4,
                            "5(Least Deprived)" = 5)
deprivation_default <- c(1, 2, 3, 4, 5)

# specialty intermediate values
specialty_choices <- sort(unique(specialty_df$specialty))
specialty_default <- unique(specialty_df$specialty)
