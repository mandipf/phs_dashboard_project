server <- function(input, output) {
  
  # HOME TAB -----
  home_tab_1 <- eventReactive(
    eventExpr = input$update_home,
    valueExpr = {
      age_sex_df %>%
        filter(hb %in% input$hb_input_home) %>% 
        summarise(no_episodes = mean(episodes, na.rm = TRUE),
                  avg_length_of_stay = mean(length_of_stay, na.rm = TRUE),
                  .by = c(quarter, hb))
    },
    ignoreNULL = FALSE)
  
  output$home_plot_1 <- renderPlot({
    validate(
      need(nrow(home_tab_1()) != 0,
           "No data found that meet your search criteria"),
    )
    if (input$plot_selector == "Number of episodes"){
      home_tab_1() %>% 
        ggplot(aes(x = quarter, y = no_episodes, group = hb,
                   colour = hb, fill = hb)) + 
        geom_line(linewidth=1) +
        geom_point(shape = 21, size = 3) + 
        labs(title = "Mean number of episodes per quarter\n across each health board",
             x = "\nYear", 
             y = "Mean number of episodes\n")+
        scale_colour_manual(values = phs_colours)+
        scale_fill_manual(values = phs_colours)+
        quarter_annual_marker()+
        my_theme()
    } else {
      home_tab_1() %>% 
        ggplot(aes(x = quarter, y = avg_length_of_stay, group = hb,
                   colour = hb, fill = hb)) + 
        geom_line(linewidth=1) +
        geom_point(shape = 21, size = 3) + 
        labs(title = "Mean length of hospital stay per quarter\n across each health board",
             x = "\nYear", 
             y = "Mean length of stay (days)\n")+
        scale_colour_manual(values = phs_colours)+
        scale_fill_manual(values = phs_colours)+
        quarter_annual_marker()+
        my_theme()
    }
  })
  
  home_tab_2 <- eventReactive(
    eventExpr = input$update_home,
    valueExpr = {
      bed_occ_df %>%
        filter(hb %in% input$hb_input_home) %>% 
        summarise(avg_occupancy_percentage = mean(percentage_occupancy),
                  .by = c(quarter, hb))
    },
    ignoreNULL = FALSE)
  
  output$home_plot_2 <- renderPlot({
    validate(
      need(nrow(home_tab_2()) != 0,
           "No data found that meet your search criteria"),
    )
    home_tab_2() %>% 
      ggplot(aes(x = quarter, y = avg_occupancy_percentage, group = hb,
                 colour = hb, fill = hb)) + 
      geom_line(linewidth=1) +
      geom_point(shape = 21, size = 3) + 
      labs(title = "Mean percentage of beds occupied per quarter\n across each health board",
           x = "\nYear", 
           y = "Percentage occupied\n")+
      scale_colour_manual(values = phs_colours)+
      scale_fill_manual(values = phs_colours)+
      quarter_annual_marker()+
      my_theme()
  })
  
  
  # A&E TAB -----
  ae_tab_df <- eventReactive(
    eventExpr = input$update_ae,
    valueExpr = {
      ae_df %>% 
        filter(hb %in% input$hb_input_ae) %>% 
        summarise(no_admissions = sum(number_of_attendances_aggregate, na.rm = TRUE),
                  no_stay = sum(discharge_destination_admission_to_same, na.rm = TRUE), 
                  no_discharge = sum(discharge_destination_residence, na.rm = TRUE),
                  prop_stay = no_stay / no_admissions,
                  prop_discharge = no_discharge / no_admissions,
                  .by = c(month, season))
    },
    ignoreNULL = FALSE)
  
  output$ae_plot_1 <- renderPlot({
    validate(
      need(nrow(ae_tab_df()) != 0,
           "No data found that meet your search criteria"),
    )
    ae_tab_df() %>% 
      ggplot(aes(x = as.character(month), y = no_admissions, fill = season)) + 
      geom_line(group = 1, linewidth=1)+
      geom_point(shape = 21, size = 3) +
      labs(title = "Total number of admissions per month\n across all selected health boards",
           x = "\nYear", 
           y = "Total number of admissions\n")+
      scale_colour_manual(values = phs_colours)+
      scale_fill_manual(values = c("Winter" = "red",
                                   "Other" = "black"))+
      month_annual_marker()+
      my_theme()
  })
  
  output$ae_plot_2 <- renderPlot({
    validate(
      need(nrow(ae_tab_df()) != 0,
           "No data found that meet your search criteria"),
    )
    ae_tab_df() %>% 
      ggplot(aes(x = as.character(month), fill = season)) + 
      geom_point(aes(y= prop_stay), shape = 21, size = 3) +
      geom_line(aes(y= prop_stay), group = 1,
                colour = "#3F3685", linewidth=1) +
      annotate("text", x = "201702", y = (ae_tab_df()$prop_stay[2]),
               label = "Proportion of stays", vjust = -2, hjust = 0,
               colour = "#3F3685", size = 7) +
      geom_point(aes(y= prop_discharge), shape = 21, size = 3) +
      geom_line(aes(y= prop_discharge), group = 1,
                colour = "#D26146", linewidth=1) +
      annotate("text", x = "201702", y = ae_tab_df()$prop_discharge[2],
               label = "Proportion of discharges", vjust = 2, hjust = 0,
               colour = "#D26146", size = 7) +
      labs(title = "Proportion of admissions discharged and retained in same hospital per month\n across all selected health boards",
           x = "\nYear", 
           y = "Proportion of admissions\n")+
      scale_fill_manual(values = c("Winter" = "red", "Other" = "black"))+
      month_annual_marker()+
      my_theme()
  })
  
  
  # AGE_SEX TAB -----
  age_gender_tab_df <- eventReactive(
    eventExpr = input$update_age_sex,
    valueExpr = {
      age_sex_df %>%
        filter(hb %in% input$hb_input_age_sex,
               age %in% input$age_input) %>%
        summarise(mean_episodes = mean(episodes, na.rm = TRUE),
                  mean_length_stay = mean(length_of_stay, na.rm = TRUE),
                  .by = c(quarter, sex))
    },
    ignoreNULL = FALSE)
  
  output$age_gender_plot_1 <- renderPlot({
    validate(
      need(nrow(age_gender_tab_df()) != 0,
           "No data found that meet your search criteria"),
    )
    age_gender_tab_df() %>% 
      ggplot(aes(x = quarter, y = mean_episodes, group = sex,
                 color = sex, fill = sex))+
      geom_point(shape = 21, size = 3)+
      geom_line(linewidth=1)+
      labs(title = "Mean number of episodes per quarter\n across all selected health boards and age ranges",
           x = "\nYear", 
           y = "Mean number of episodes\n")+
      scale_colour_manual(values = phs_colours)+
      scale_fill_manual(values = phs_colours)+
      quarter_annual_marker()+
      my_theme()
  })
  
  output$age_gender_plot_2 <- renderPlot({
    validate(
      need(nrow(age_gender_tab_df()) != 0,
           "No data found that meet your search criteria"),
    )
    age_gender_tab_df() %>% 
      ggplot(aes(x = quarter, y = mean_length_stay,group = sex,
                 color = sex, fill = sex))+
      geom_point(shape = 21, size = 3)+
      geom_line(linewidth=1)+
      labs(title = "Mean length of stay (total treatment) per quarter\n across all selected health boards and age ranges",
           x = "\nYear", 
           y = "Mean length of stay (days)\n")+
      scale_colour_manual(values = phs_colours)+
      scale_fill_manual(values = phs_colours)+
      quarter_annual_marker()+
      my_theme()
  })
  
  
  # SIMD TAB -----
  simd_tab_df <- eventReactive(
    eventExpr = input$update_simd,
    valueExpr = {
      simd_df %>% 
        filter(hb %in% input$hb_input_simd,
               simd %in% input$simd_input) %>% 
        summarise(mean_episodes = mean(episodes, na.rm = TRUE),
                  mean_length_of_stay = mean(length_of_stay, na.rm = TRUE),
                  .by = c(quarter, simd))
    },
    ignoreNULL = FALSE)
  
  output$simd_plot_1 <- renderPlot({
    validate(
      need(nrow(simd_tab_df()) != 0,
           "No data found that meet your search criteria"),
    )
    simd_tab_df() %>% 
      ggplot(aes(x = quarter, y = mean_episodes,
                 group = as.character(simd), colour = as.character(simd),
                 fill = as.character(simd)))+
      geom_point(shape = 21, size = 3)+
      geom_line(linewidth=1)+
      labs(title = "Mean number of episodes per quarter\n across all selected health boards and SIMD categories",
           x = "\nYear", 
           y = "Mean number of episodes\n")+
      scale_colour_manual(values = phs_colours)+
      scale_fill_manual(values = phs_colours)+
      quarter_annual_marker()+
      my_theme()
  })
  
  output$simd_plot_2 <- renderPlot({
    validate(
      need(nrow(simd_tab_df()) != 0,
           "No data found that meet your search criteria"),
    )
    simd_tab_df() %>%
      ggplot(aes(x = quarter, y = mean_length_of_stay, 
                 group = as.character(simd), colour = as.character(simd),
                 fill = as.character(simd)))+
      geom_point(shape = 21, size = 3)+
      geom_line(linewidth=1)+
      labs(title = "Mean length of stay (total treatment) per quarter\n across all selected health boards and SIMD categories",
           x = "\nYear", 
           y = "Mean length of stay (days)\n")+
      scale_colour_manual(values = phs_colours)+
      scale_fill_manual(values = phs_colours)+
      quarter_annual_marker()+
      my_theme()
  })
  
  
  # SPECIALTY TAB -----
  speciality_tab_df <- eventReactive(
    eventExpr = input$update_specialty,
    valueExpr = {
      specialty_df %>% 
        filter(hb %in% input$hb_input_specialty,
               specialty %in% input$specialty_input) %>% 
        summarise(mean_spell = mean(length_of_spell, na.rm = TRUE),
                  mean_episode = mean(episodes, na.rm = TRUE),
                  .by = c(quarter, specialty))
    },
    ignoreNULL = FALSE)
  
  output$specialty_plot_1 <- renderPlot({
    validate(
      need(nrow(speciality_tab_df()) != 0,
           "No data found that meet your search criteria"),
    )
    speciality_tab_df() %>% 
      ggplot(aes(x=quarter, y=mean_episode, group=specialty,
                 colour=specialty, fill=specialty))+
      geom_point(shape = 21, size = 3)+
      geom_line(linewidth=1)+
      labs(title = "Mean number of episodes per quarter\n across all selected health boards and specialties",
           x = "\nYear", 
           y = "Mean number of episodes\n")+
      scale_colour_manual(values = phs_colours)+
      scale_fill_manual(values = phs_colours)+
      quarter_annual_marker()+
      my_theme()
  })
  
  output$specialty_plot_2 <- renderPlot({
    validate(
      need(nrow(speciality_tab_df()) != 0,
           "No data found that meet your search criteria"),
    )
    speciality_tab_df() %>%
      ggplot(aes(x=quarter, y=mean_spell, group=specialty,
                 colour=specialty, fill=specialty))+
      geom_point(shape = 21, size = 3)+
      geom_line(linewidth=1)+
      labs(title = "Mean length of stay (total treatment) per quarter\n across all selected health boards and specialties",
           x = "\nYear", 
           y = "Mean length of stay (days)\n")+
      scale_colour_manual(values = phs_colours)+
      scale_fill_manual(values = phs_colours)+
      quarter_annual_marker()+
      my_theme()
  })
  
  
  # ALL TABS -----
  output$data_source_text <- renderText({
    "Data Source: https://www.opendata.nhs.scot/"
  })
}