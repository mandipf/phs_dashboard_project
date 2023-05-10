ui <- fluidPage(
  #theme = bs_theme(bootswatch = "cerulean"),
  #theme = bs_theme(bootswatch = "vapor"),
  theme = bs_theme(bootswatch = "pulse"),
  titlePanel(title = h1("Effects of Covid-19 on hospital admissions in Scotland",
                        align = "center"),
             windowTitle = "Effects of CV-19 on hospital admissions"),
  br(),
  
  tabsetPanel(
    # Home tab
    tabPanel(
      title = "Home",
      sidebarLayout(
        sidebarPanel(
          width = sidebarpanel_width,
          selectInput(
            inputId = "hb_input_home",
            label = "Health Board:",
            choices = hb_choices,
            selected = hb_default
          ),
          # pickerInput(inputId = "hb_input_home",
          #             label = "Health Board:",
          #             choices = hb_choices,
          #             multiple = TRUE,
          #             options = list(
          #               `actions-box` = TRUE,
          #               `deselect_all`= TRUE,
          #               `select_all` = TRUE,
          #               `none-selected` = "zero"
          #             )
          # ),
          # br(),
          # sliderInput(
          #   inputId = "year_input",
          #   label = "Year:",
          #   min = year_slider_low,
          #   max = year_slider_high,
          #   value = c(year_default_low, year_default_high),
          #   sep = ""
          # ),
          # br(),
          # radioButtons(
          #   inputId = "sex_input",
          #   label = "Sex:",
          #   choices = sex_choices,
          #   inline = TRUE
          # ),
          # br(),
          # checkboxGroupInput(
          #   inputId = "age_input",
          #   label = "Age range:",
          #   choices = age_choices,
          #   selected = age_default
          # ),
          br(),
          actionButton(
            inputId = "update_home",
            label = "Submit"
          )
        ),
        mainPanel(
          br(),
          plotOutput("home_plot_1", width = "100%"),
          br(),
          plotOutput("home_plot_2", width = "100%")
        )
      )
    ),
    # A&E tab
    tabPanel(
      title = "A&E",
      sidebarLayout(
        sidebarPanel(
          width = sidebarpanel_width,
          selectInput(
            inputId = "hb_input_ae",
            label = "Health Board:",
            choices = hb_choices,
            selected = hb_default
          ),
          # br(),
          # sliderInput(
          #   inputId = "year_input",
          #   label = "Year:",
          #   min = year_slider_low,
          #   max = year_slider_high,
          #   value = c(year_default_low, year_default_high),
          #   sep = ""
          # ),
          # br(),
          # radioButtons(
          #   inputId = "ae_follow_up_input",
          #   label = "A&E follow-up:",
          #   choices = ae_follow_up_choices,
          #   inline = TRUE
          # ),
          # br(),
          # checkboxGroupInput(
          #   inputId = "ae_dept_input",
          #   label = "Follow-up department:",
          #   choices = ae_dept_choices,
          #   selected = ae_dept_default
          # ),
          br(),
          actionButton(
            inputId = "update_ae",
            label = "Submit"
          )
        ),
        mainPanel(
          br(),
          plotOutput("ae_plot_1", width = "100%"),
          br(),
          plotOutput("ae_plot_2", width = "100%")
        )
      )
    ),
    # Age and Sex tab
    tabPanel(
      title = "Age and Sex",
      sidebarLayout(
        sidebarPanel(
          width = sidebarpanel_width,
          selectInput(
            inputId = "hb_input_age_sex",
            label = "Health Board:",
            choices = hb_choices,
            selected = hb_default
          ),
          br(),
          # sliderInput(
          #   inputId = "year_input",
          #   label = "Year:",
          #   min = year_slider_low,
          #   max = year_slider_high,
          #   value = c(year_default_low, year_default_high),
          #   sep = ""
          # ),
          # br(),
          checkboxGroupInput(
            inputId = "age_input",
            label = "Age range:",
            choices = age_choices,
            selected = age_default
          ),
          br(),
          # radioButtons(
          #   inputId = "gender_input",
          #   label = "Gender:",
          #   choices = gender_choices,
          #   inline = TRUE
          # ),
          # br(),
          actionButton(
            inputId = "update_age_sex",
            label = "Submit"
          )
        ),
        mainPanel(
          br(),
          plotOutput("age_gender_plot_1", width = "100%"),
          br(),
          plotOutput("age_gender_plot_2", width = "100%")
        )
      )
    ),
    # SIMD tab
    tabPanel(
      title = "SIMD",
      sidebarLayout(
        sidebarPanel(
          width = sidebarpanel_width,
          pickerInput(inputId = "hb_input_simd",
                      label = "Health Board:",
                      choices = hb_choices,
                      multiple = TRUE,
                      options = list(
                        `actions-box` = TRUE,
                        `deselect_all`= TRUE,
                        `select_all` = TRUE,
                        `none-selected` = "zero"
                      )
          ),
          # selectInput(
          #   inputId = "hb_input_simd",
          #   label = "Health Board:",
          #   choices = hb_choices,
          #   selected = hb_default
          # ),
          br(),
          # sliderInput(
          #   inputId = "year_input",
          #   label = "Year:",
          #   min = year_slider_low,
          #   max = year_slider_high,
          #   value = c(year_default_low, year_default_high),
          #   sep = ""
          # ),
          # br(),
          checkboxGroupInput(
            inputId = "simd_input",
            label = "SIMD:",
            choices = deprivation_choices,
            selected = deprivation_default
          ),
          br(),
          actionButton(
            inputId = "update_simd",
            label = "Submit"
          ),
        ),
        mainPanel(
          br(),
          plotOutput("simd_plot_1", width = "100%"),
          br(),
          plotOutput("simd_plot_2", width = "100%")
        )
      )
    ),
    # Specialty tab
    tabPanel(
      title = "Specialty",
      sidebarLayout(
        sidebarPanel(
          width = sidebarpanel_width,
          selectInput(
            inputId = "hb_input_specialty",
            label = "Health Board:",
            choices = hb_choices,
            selected = hb_default
          ),
          br(),
          # sliderInput(
          #   inputId = "year_input",
          #   label = "Year:",
          #   min = year_slider_low,
          #   max = year_slider_high,
          #   value = c(year_default_low, year_default_high),
          #   sep = ""
          # ),
          # br(),
          checkboxGroupInput(
            inputId = "specialty_input",
            label = "Specialty:",
            choices = specialty_choices,
            selected = specialty_default
          ),
          br(),
          actionButton(
            inputId = "update_specialty",
            label = "Submit"
          ),
        ),
        mainPanel(
          br(),
          plotOutput("specialty_plot_1", width = "100%"),
          br(),
          plotOutput("specialty_plot_2", width = "100%")
        )
      )
    # ),
    # # Effects of COVID-19 tab
    # tabPanel(
    #   title = "Covid-19",
    #   sidebarLayout(
    #     sidebarPanel(
    #       width = sidebarpanel_width,
    #       radioButtons(
    #         inputId = "time_period",
    #         label = "Time period:",
    #         choices = time_period_choices,
    #         inline = TRUE
    #       ),
    #       br(),
    #       sliderInput(
    #         inputId = "year_input",
    #         label = "Year:",
    #         min = year_slider_low,
    #         max = year_slider_high,
    #         value = c(year_default_low, year_default_high),
    #         sep = ""
    #       ),
    #       br(),
    #       checkboxGroupInput(
    #         inputId = "specialty_input",
    #         label = "Specialty:",
    #         choices = specialty_choices,
    #         selected = specialty_default
    #       ),
    #       br(),
    #       actionButton(
    #         inputId = "field_update",
    #         label = "Submit"
    #       ),
    #     ),
    #     mainPanel(
    #       plotOutput("covid_plot", width = "90%")
    #     )
    #   )
    )
  ),
  
  br(),
  textOutput("data_source_text")
)