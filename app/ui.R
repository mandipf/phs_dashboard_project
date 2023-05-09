ui <- fluidPage(
  #theme = bs_theme(bootswatch = "cerulean"),
  #theme = bs_theme(bootswatch = "vapor"),
  theme = bs_theme(bootswatch = "pulse"),
  titlePanel(title = h1("PHS Scotland", align = "center"),
             windowTitle = "PHS Scotland"),
  br(),
  
  tabsetPanel(
    # Home tab
    tabPanel(
      title = "Home",
      sidebarLayout(
        sidebarPanel(
          width = sidebarpanel_width,
          radioButtons(
            inputId = "time_period",
            label = "Time period:",
            choices = time_period_choices,
            inline = TRUE
          ),
          br(),
          sliderInput(
            inputId = "year_input",
            label = "Year:",
            min = year_slider_low,
            max = year_slider_high,
            value = c(year_default_low, year_default_high),
            sep = ""
          ),
          br(),
          radioButtons(
            inputId = "gender_input",
            label = "Gender:",
            choices = gender_choices,
            inline = TRUE
          ),
          br(),
          checkboxGroupInput(
            inputId = "age_input",
            label = "Age range:",
            choices = age_choices,
            selected = age_default
          ),
          br(),
          actionButton(
            inputId = "field_update",
            label = "Submit"
          )
        ),
        mainPanel(
          br(),
          plotOutput("home_plot", width = "100%")
        )
      )
    ),
    # A&E tab
    tabPanel(
      title = "A&E",
      sidebarLayout(
        sidebarPanel(
          width = sidebarpanel_width,
          radioButtons(
            inputId = "time_period",
            label = "Time period:",
            choices = time_period_choices,
            inline = TRUE
          ),
          br(),
          sliderInput(
            inputId = "year_input",
            label = "Year:",
            min = year_slider_low,
            max = year_slider_high,
            value = c(year_default_low, year_default_high),
            sep = ""
          ),
          br(),
          radioButtons(
            inputId = "ae_follow_up_input",
            label = "A&E follow-up:",
            choices = ae_follow_up_choices,
            inline = TRUE
          ),
          br(),
          checkboxGroupInput(
            inputId = "ae_dept_input",
            label = "Follow-up department:",
            choices = ae_dept_choices,
            selected = ae_dept_default
          ),
          br(),
          actionButton(
            inputId = "field_update",
            label = "Submit"
          )
        ),
        mainPanel(
          br(),
          plotOutput("ae_plot", width = "90%")
        )
      )
    ),
    # Age and Gender tab
    tabPanel(
      title = "Age and Gender",
      sidebarLayout(
        sidebarPanel(
          width = sidebarpanel_width,
          radioButtons(
            inputId = "time_period",
            label = "Time period:",
            choices = time_period_choices,
            inline = TRUE
          ),
          br(),
          sliderInput(
            inputId = "year_input",
            label = "Year:",
            min = year_slider_low,
            max = year_slider_high,
            value = c(year_default_low, year_default_high),
            sep = ""
          ),
          br(),
          checkboxGroupInput(
            inputId = "age_input",
            label = "Age range:",
            choices = age_choices,
            selected = age_default
          ),
          br(),
          radioButtons(
            inputId = "gender_input",
            label = "Gender:",
            choices = gender_choices,
            inline = TRUE
          ),
          br(),
          actionButton(
            inputId = "field_update",
            label = "Submit"
          )
        ),
        mainPanel(
          plotOutput("age_gender_plot", width = "90%")
        )
      )
    ),
    # SIMD tab
    tabPanel(
      title = "SIMD",
      sidebarLayout(
        sidebarPanel(
          width = sidebarpanel_width,
          radioButtons(
            inputId = "time_period",
            label = "Time period:",
            choices = time_period_choices,
            inline = TRUE
          ),
          br(),
          sliderInput(
            inputId = "year_input",
            label = "Year:",
            min = year_slider_low,
            max = year_slider_high,
            value = c(year_default_low, year_default_high),
            sep = ""
          ),
          br(),
          checkboxGroupInput(
            inputId = "simd_input",
            label = "SIMD:",
            choices = deprivation_choices,
            selected = deprivation_default
          ),
          br(),
          actionButton(
            inputId = "field_update",
            label = "Submit"
          ),
        ),
        mainPanel(
          plotOutput("simd_plot", width = "90%")
        )
      )
    ),
    # Specialty tab
    tabPanel(
      title = "Specialty",
      sidebarLayout(
        sidebarPanel(
          width = sidebarpanel_width,
          radioButtons(
            inputId = "time_period",
            label = "Time period:",
            choices = time_period_choices,
            inline = TRUE
          ),
          br(),
          sliderInput(
            inputId = "year_input",
            label = "Year:",
            min = year_slider_low,
            max = year_slider_high,
            value = c(year_default_low, year_default_high),
            sep = ""
          ),
          br(),
          checkboxGroupInput(
            inputId = "specialty_input",
            label = "Specialty:",
            choices = specialty_choices,
            selected = specialty_default
          ),
          br(),
          actionButton(
            inputId = "field_update",
            label = "Submit"
          ),
        ),
        mainPanel(
          plotOutput("specialty_plot", width = "90%")
        )
      )
    ),
    # Effects of COVID-19 tab
    tabPanel(
      title = "Covid-19",
      sidebarLayout(
        sidebarPanel(
          width = sidebarpanel_width,
          radioButtons(
            inputId = "time_period",
            label = "Time period:",
            choices = time_period_choices,
            inline = TRUE
          ),
          br(),
          sliderInput(
            inputId = "year_input",
            label = "Year:",
            min = year_slider_low,
            max = year_slider_high,
            value = c(year_default_low, year_default_high),
            sep = ""
          ),
          br(),
          checkboxGroupInput(
            inputId = "specialty_input",
            label = "Specialty:",
            choices = specialty_choices,
            selected = specialty_default
          ),
          br(),
          actionButton(
            inputId = "field_update",
            label = "Submit"
          ),
        ),
        mainPanel(
          plotOutput("covid_plot", width = "90%")
        )
      )
    )
  ),
  
  br(),
  column(
    width = sidebarpanel_width,
    offset = 0,
    selectInput(
      inputId = "hb_input",
      label = "Health Board:",
      choices = hb_choices,
      selected = hb_default
    ),
    actionButton(
      inputId = "hb_update",
      label = "Submit"
    )
  ),
  br(),
  textOutput("data_source_text")
  
  # br(),
  # fluidRow(
  #   column(
  #     width = 3,
  #     offset = 0,
  #     selectInput(
  #       inputId = "hb_input",
  #       label = "Health Board:",
  #       choices = hb_choices,
  #       selected = hb_default
  #     )
  #   ),
  #   column(
  #     width = 2,
  #     offset = 0,
  #     actionButton(
  #       inputId = "hb_update",
  #       label = "Submit",
  #       style = 'margin-top:33px'
  #     )
  #   )
  # ),
  # textOutput("data_source_text")
  
)


# ADDITIONAL BUTTONS
#   fluidRow(
#     # column(
#     #   width = 2,
#     #   offset = 1,
#     #   textOutput("hb_text")
#     # ),
#     column(
#       width = 4,
#       offset = 0,
#       selectInput(
#         inputId = "hb_input",
#         label = "Health Board:",
#         choices = hb_choices,
#         selected = hb_selected
#       )
#     ),
#     column(
#       width = 2,
#       offset = 0,
#       fluidRow(
#       actionButton(
#         inputId = "update",
#         label = "Submit",
#         style = 'margin-top:33px'
#       )
#       )
#     ),
#     column(
#       width = 3,
#       offset = 0,
#       textOutput("data_source_text")
#     )
#   )
# )
# 
# fluidRow(
# actionButton(
#   inputId = "update",
#   label = "Submit",
#   style = 'margin-top:33px'
# )
#   column(
#     width = 5,
#     offset = 1,
#     fluidRow(
#       "Health Board",
#     ),
#     fluidRow(
#       column(
#         width = 9,
#         offset = 0,
#         selectInput(
#           inputId = "hb_input",
#           label = NULL,
#           choices = hb_choices,
#           selected = hb_selected
#         )
#       ),
#       column(
#         width = 3,
#         offset = 0,
#         actionButton(
#           inputId = "update",
#           label = "Submit"
#         )
