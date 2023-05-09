# LIBRARIES FOR APP
library(tidyverse)
library(bslib)
library(here)

# DATA FOR APP

ae_df <- read_csv(here("data/clean_data/datawaiting_times_clean.csv"))
age_sex_df <- read_csv(here("data/clean_data/age_sex_clean.csv"))
hb_names_df <- read_csv(here("data/clean_data/health_board_names.csv"))
# home_hb_admissions_df <- read_csv(here("data/clean_data/ "))
simd_df <- read_csv(here("data/clean_data/simd_clean.csv"))
specialty_episode <- read_csv(here("data/clean_data/specialty_mean_episodes.csv"))
specialty_spell <- read_csv(here("data/clean_data/specialty_mean_lengthofspell.csv"))


# PLOT STYLING
source("R/plot_themes.R")

# plot_colours <- c("critic_score" = colour_chart[1],
#                   "user_score" = colour_chart[2],
#                   "sales" = colour_chart[3])




# INTERMEDIATE VARIABLES
sidebarpanel_width = 3

time_period_choices <- c("All", "Pre-Covid", "Post-Covid")

year_default_low <- 2018
year_default_high <- 2023
year_slider_low <- year_default_low
year_slider_high <- year_default_high


# main intermediate variables
# hb_choices <- sort(c("All", "Glasgow City and Other stuff", "L2", "L3", "L4"))
hb_choices <- c("All", unique(hb_names_df$HBName))
hb_default <- "All"


# a&e intermediate values
# ae_follow_up_choices <- c("a", "b", "c", "d")
# 
# ae_dept_choices <- unique(simd_df$hb)
# ae_dept_default <- unique(simd_df$hb)


# age and gender intermediate variables
# age_choices <- c("0-5", "5-10", "15-20", "25-30")
# age_default <- c("0-5", "5-10", "15-20", "25-30")
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
specialty_choices <- unique(specialty_episode$specialty_name_top)
specialty_default <- unique(specialty_episode$specialty_name_top)


# # covid intermediate values
# covid_choices <- c("a", "b", "c", "d")
# covid_default <- c("a", "b", "c", "d")
