server <- function(input, output) {
  
  #####
  # HOME TAB
  home_tab_1 <- eventReactive(
    eventExpr = input$update_home,
    valueExpr = {
      age_sex_df %>%
        filter(hb %in% input$hb_input_home) %>% 
        summarise(no_episodes = round(mean(episodes, na.rm = TRUE),0),
                  avg_length_of_stay = round(mean(length_of_stay, na.rm = TRUE),0),
                  .by = c(quarter, hb))
    })

  output$home_plot_1 <- renderPlot({
    validate(
      need(nrow(home_tab_1()) != 0,
           "No data found that meet your search criteria"),
    )
    if (input$plot_selector == "Number of episodes"){
    home_tab_1() %>% 
      ggplot(aes(x = quarter, y = no_episodes,
                 group = hb, colour = hb)) + 
      geom_line() +
      geom_point(shape = 21, size = 2) + 
      labs(title = "Number of Episodes 2017 - 2023",
           x = "Health Board", 
           y = "Number of Episodes")+
      scale_colour_manual(values = phs_colours)+
      quarter_annual_marker()+
      my_theme()
    } else {
      home_tab_1() %>% 
        ggplot(aes(x = quarter, y = avg_length_of_stay,
                   group = hb, colour = hb)) + 
        geom_line() +
        geom_point(shape = 21, size = 2) + 
        labs(title = "Average Length of Stay 2017 - 2023",
             x = "Health Board", 
             y = "Average Length of Stay")+
        scale_colour_manual(values = phs_colours)+
        quarter_annual_marker()+
        my_theme()
    }
  })
  
  home_tab_2 <- eventReactive(
    eventExpr = input$update_home,
    valueExpr = {
      home_hb_occ_df %>%
        filter(HB %in% input$hb_input_home) %>% 
        summarise(avg_occupancy_percentage = round(mean(PercentageOccupancy),0),
                  .by = c(Quarter, HB))
    })
  
  output$home_plot_2 <- renderPlot({
    validate(
      need(nrow(home_tab_2()) != 0,
           "No data found that meet your search criteria"),
    )
    home_tab_2() %>% 
      ggplot(aes(x = Quarter, y = avg_occupancy_percentage,
                 group = HB, colour = HB)) + 
      geom_line() +
      geom_point(shape = 21, size = 2) + 
      labs(title = "Average Occupancy 2017-2023",
           x = "Health Board", 
           y = "Occupancy Percentage")+
      scale_colour_manual(values = phs_colours)+
      quarter_annual_marker()+
      my_theme()
  })
  
  
  
  
  #####
  # A&E TAB
  ae_tab_df <- eventReactive(
    eventExpr = input$update_ae,
    valueExpr = {
      ae_df %>% 
        filter(HBT %in% input$hb_input_ae) %>% 
        summarise(no_admissions = sum(NumberOfAttendancesAggregate, na.rm = TRUE),
                  no_stay = sum(DischargeDestinationAdmissionToSame, na.rm = TRUE), 
                  no_discharge = sum(DischargeDestinationResidence, na.rm = TRUE),
                  prop_stay = no_stay / no_admissions,
                  prop_discharge = no_discharge / no_admissions,
                  .by = Month) %>% 
        mutate(season = case_when(str_detect(Month, "12$") ~ "Winter",
                                  str_detect(Month, "0[12]$") ~ "Winter",
                                  TRUE ~ "Other"))
    })
  
  output$ae_plot_1 <- renderPlot({
    validate(
      need(nrow(ae_tab_df()) != 0,
           "No data found that meet your search criteria"),
    )
    ae_tab_df() %>% 
      ggplot(aes(x = as.character(Month), y = no_admissions, fill = season)) + 
      geom_line(group = 1)+
      geom_point(shape = 21, size = 3) +
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
      ggplot(aes(x = as.character(Month), fill = season)) + 
      geom_line(aes(y= prop_stay), group = 1, colour = "#3F3685") +
      geom_point(aes(y= prop_stay), shape = 21, size = 2) +
      geom_line(aes(y= prop_discharge), group = 1, colour = "#D26146") +
      annotate("text", x = "201702",
               y = (ae_tab_df()$prop_stay[2]),
               label = "No. of stays",
               vjust = -2,
               hjust = 0,
               colour = "#3F3685",
               size = 7) +
      annotate("text", x = "201702",
               y = ae_tab_df()$prop_discharge[2],
               label = "No. of discharges",
               vjust = 2,
               hjust = 0,
               colour = "#D26146",
               size = 7) +
      geom_point(aes(y= prop_discharge), shape = 21, size = 2) +
      scale_y_continuous(labels = scales::comma) +
      scale_colour_manual(values = phs_colours)+
      scale_fill_manual(values = c("Winter" = "red",
                                   "Other" = "black"))+
      xlim("201701", "202308")+
      month_annual_marker()+
      my_theme()
  })
  


    
  #####  
  # AGE_SEX TAB
  age_gender_tab_df <- eventReactive(
    eventExpr = input$update_age_sex,
    valueExpr = {
      age_sex_df %>%
        filter(hb %in% input$hb_input_age_sex,
               age %in% input$age_input) %>%
        summarise(mean_episodes = mean(episodes, na.rm = TRUE),
                  mean_length_stay = mean(length_of_stay, na.rm = TRUE),
                  .by = c(quarter, sex))
    })

  output$age_gender_plot_1 <- renderPlot({
    validate(
      need(nrow(age_gender_tab_df()) != 0,
           "No data found that meet your search criteria"),
    )
    age_gender_tab_df() %>% 
      ggplot(aes(x = quarter, y = mean_episodes,
                 group = sex, color = sex))+
      geom_point()+
      geom_line()+
      scale_colour_manual(values = phs_colours)+
      quarter_annual_marker()+
      my_theme()
  })
  
  output$age_gender_plot_2 <- renderPlot({
    validate(
      need(nrow(age_gender_tab_df()) != 0,
           "No data found that meet your search criteria"),
    )
    age_gender_tab_df() %>% 
      ggplot(aes(x = quarter, y = mean_length_stay,
                 group = sex, color = sex))+
      geom_point()+
      geom_line()+
      scale_colour_manual(values = phs_colours)+
      quarter_annual_marker()+
      my_theme()
  })
  
  
  
  
  #####
  # SIMD TAB
  simd_tab_df <- eventReactive(
    eventExpr = input$update_simd,
    valueExpr = {
      simd_df %>% 
        filter(hb %in% input$hb_input_simd,
               simd %in% input$simd_input) %>% 
        summarise(mean_episodes = mean(episodes, na.rm = TRUE),
                  mean_length_of_stay = mean(length_of_stay, na.rm = TRUE),
                  .by = c(quarter, simd))
    })

  output$simd_plot_1 <- renderPlot({
    validate(
      need(nrow(simd_tab_df()) != 0,
           "No data found that meet your search criteria"),
    )
    simd_tab_df() %>% 
      ggplot(aes(x = quarter, y = mean_episodes,
                 group = as.character(simd), colour = as.character(simd)))+
      geom_point()+
      geom_line()+
      scale_colour_manual(values = phs_colours)+
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
                 group = as.character(simd), colour = as.character(simd)))+
      geom_point()+
      geom_line()+
      labs(x = "Quarter/Year",
           y = "Mean number of episodes")+
      scale_colour_manual(values = phs_colours)+
      quarter_annual_marker()+
      my_theme()
  })
  
  
  
  
  #####
  # SPECIALTY TAB
  speciality_tab_df <- eventReactive(
    eventExpr = input$update_specialty,
    valueExpr = {
      specialty_df %>% 
        filter(hb %in% input$hb_input_specialty,
               specialty_name_top %in% input$specialty_input) %>% 
        summarise(mean_spell = mean(length_of_spell),
                  mean_episode = mean(episodes),
                  .by = c(quarter, specialty_name_top))
    })
  
  output$specialty_plot_1 <- renderPlot({
    validate(
      need(nrow(speciality_tab_df()) != 0,
           "No data found that meet your search criteria"),
    )
    speciality_tab_df() %>% 
      ggplot(aes(x=quarter, y=mean_episode,
                 colour=specialty_name_top, group=specialty_name_top))+
      geom_line(linewidth=1)+
      labs(x = "Quarter/Year",
           y = "Mean number of episodes", 
           title="Mean number of episodes per quarter per year")+
      scale_colour_manual(values = phs_colours)+
      quarter_annual_marker()+
      my_theme()
  })
  
  output$specialty_plot_2 <- renderPlot({
    validate(
      need(nrow(speciality_tab_df()) != 0,
           "No data found that meet your search criteria"),
    )
    speciality_tab_df() %>%
      ggplot(aes(x=quarter, y=mean_spell,
                 colour=specialty_name_top, group=specialty_name_top))+
      geom_line(linewidth=1)+
      labs(x = "Quarter/Year",
           y = "Mean of length of spell", 
           title="Mean of length of spell per quarter per year")+
      scale_colour_manual(values = phs_colours)+
      quarter_annual_marker()+
      my_theme()
  })

  
  
  
  #####
  # ALL TABS
  output$data_source_text <- renderText({
    "Data Source: https://www.opendata.nhs.scot/"
  })
}