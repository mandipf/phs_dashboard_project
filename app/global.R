# libraries for app
library(tidyverse)
library(bslib)

# data for app


# plot styling
phs_colours <- c("#3F3685", "#9B4393", "#0078D4", "#83BB26", "#948DA3",
                 "#1E7F84", "#6B5C85", "#C73918")

# plot_colours <- c("critic_score" = colour_chart[1],
#                   "user_score" = colour_chart[2],
#                   "sales" = colour_chart[3])

# main intermediate variables
hb_choices <- sort(c("All", "Glasgow City and Other stuff", "L2", "L3", "L4"))
hb_default <- "All"


# recycled intermediate variables
sidebarpanel_width = 3

time_period_choices <- c("All", "Pre-Covid", "Post-Covid")

year_default_low <- 2018
year_default_high <- 2023
year_slider_low <- year_default_low
year_slider_high <- year_default_high


# a&e intermediate values
ae_follow_up_choices <- c("a", "b", "c", "d")

ae_dept_choices <- c("a", "b", "c", "d")
ae_dept_default <- c("a", "b", "c", "d")


# age and gender intermediate variables
age_choices <- c("0-5", "5-10", "15-20", "25-30")
age_default <- c("0-5", "5-10", "15-20", "25-30")

gender_choices <- c("All", "Female", "Male")


# SIMD intermediate variables
deprivation_choices <- list("1(Most Deprived)" = 1,
                            "2" = 2,
                            "3" = 3,
                            "4" = 4,
                            "5(Least Deprived)" = 5)
deprivation_default <- c(1, 2, 3, 4, 5)


# specialty intermediate values
specialty_choices <- c("a", "b", "c", "d")
specialty_default <- c("a", "b", "c", "d")


# covid intermediate values
specialty_choices <- c("a", "b", "c", "d")
specialty_default <- c("a", "b", "c", "d")
