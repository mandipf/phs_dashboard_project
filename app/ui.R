ui <- fluidPage(
  theme = bs_theme(bootswatch = "pulse"),
  fluidRow(
    column(
      width = sidebarpanel_width,
      offset = 0,
      img(src='phs-logo.png', width = "100%")
    ),
    column(
      width = (12 - sidebarpanel_width),
      offset = 0,
      titlePanel(title = h1("Effects of Covid-19 on hospital admissions in Scotland",
                            align = "center"),
                 windowTitle = "Effects of CV-19 on hospital admissions"),
    )
  ),
  br(),
  
  tabsetPanel(
    # Home tab
    tabPanel(
      title = "Home",
      sidebarLayout(
        sidebarPanel(
          width = sidebarpanel_width,
          pickerInput(inputId = "hb_input_home",
                      label = "Health Board:",
                      choices = hb_choices,
                      multiple = TRUE,
                      options = list(
                        `actions-box` = TRUE,
                        `deselect_all`= TRUE,
                        `select_all` = TRUE,
                        `none-selected` = "zero"
                      ),
                      selected = hb_choices
          ),
          br(),
          actionButton(
            inputId = "update_home",
            label = "Submit"
          ),
          br(),
          radioButtons(
            inputId = "plot_selector",
            label = "Admissions plot type:",
            choices = c("Number of episodes", "Length of stay")
          )
        ),
        mainPanel(
          br(),
          plotOutput("home_plot_1", width = "100%"),
          br(),
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
          pickerInput(inputId = "hb_input_ae",
                      label = "Health Board:",
                      choices = hb_choices,
                      multiple = TRUE,
                      options = list(
                        `actions-box` = TRUE,
                        `deselect_all`= TRUE,
                        `select_all` = TRUE,
                        `none-selected` = "zero"
                      ),
                      selected = hb_choices
          ),
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
          pickerInput(inputId = "hb_input_age_sex",
                      label = "Health Board:",
                      choices = hb_choices,
                      multiple = TRUE,
                      options = list(
                        `actions-box` = TRUE,
                        `deselect_all`= TRUE,
                        `select_all` = TRUE,
                        `none-selected` = "zero"
                      ),
                      selected = hb_choices
          ),
          br(),
          pickerInput(inputId = "age_input",
                      label = "Age range:",
                      choices = age_choices,
                      multiple = TRUE,
                      options = list(
                        `actions-box` = TRUE,
                        `deselect_all`= TRUE,
                        `select_all` = TRUE,
                        `none-selected` = "zero"
                      ),
                      selected = age_choices
          ),
          br(),
          actionButton(
            inputId = "update_age_sex",
            label = "Submit"
          )
        ),
        mainPanel(
          br(),
          plotOutput("age_gender_plot_1", width = "100%"),
          br(),
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
                      ),
                      selected = hb_choices
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
            inputId = "update_simd",
            label = "Submit"
          ),
        ),
        mainPanel(
          br(),
          plotOutput("simd_plot_1", width = "100%"),
          br(),
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
          pickerInput(inputId = "hb_input_specialty",
                      label = "Health Board:",
                      choices = hb_choices,
                      multiple = TRUE,
                      options = list(
                        `actions-box` = TRUE,
                        `deselect_all`= TRUE,
                        `select_all` = TRUE,
                        `none-selected` = "zero"
                      ),
                      selected = hb_choices
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
            inputId = "update_specialty",
            label = "Submit"
          ),
        ),
        mainPanel(
          br(),
          plotOutput("specialty_plot_1", width = "100%"),
          br(),
          br(),
          plotOutput("specialty_plot_2", width = "100%")
        )
      )
    )
  ),
  
  br(),
  textOutput("data_source_text")
)