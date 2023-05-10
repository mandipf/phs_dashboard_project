server <- function(input, output) {
  
  #####
  # HOME TAB
  home_tab_df <- eventReactive(
    eventExpr = input$update_home,
    valueExpr = {
      if (input$hb_input_home != "All"){
        age_sex_df <- age_sex_df %>%
          filter(hb == input$hb_input_home)
      }
      age_sex_df %>%
        filter(hb != "Scotland") %>% 
        # group_by(Quarter, HB) %>%
        summarise(no_episodes = round(mean(episodes , na.rm = TRUE),0),
                  avg_length_of_stay = round(mean(length_of_stay , na.rm = TRUE),0),
                  .by = c(quarter, hb))
    })

  # home_tab_2 <- eventReactive(
  #   eventExpr = input$update_home,
  #   valueExpr = {
  # #     if (input$hb_input_home != "All"){
  # #       home_hb_admissions_df <- home_hb_admissions_df %>% 
  # #         filter(hb == input$hb_input_home)
  # #     }
  # #     home_hb_admissions %>%   
  # #       # group_by(Quarter, HB) %>% 
  # #       summarise(avg_length_of_stay = round(mean(LengthOfStay , na.rm = TRUE),0),
  # #                 .by = c(Quarter, HB))
  #   })
  
  output$home_plot_1 <- renderPlot({
    validate(
      need(nrow(home_tab_df()) != 0,
           "No data found that meet your search criteria"),
    )
    home_tab_df() %>% 
      ggplot(aes(x = quarter, y = no_episodes, group = hb, colour = hb)) + 
      geom_line() +
      geom_point(shape = 21, size = 2) + 
      labs(title = "Number of Episodes 2017 - 2023",
           x = "Health Board", 
           y = "Number of Episodes")+
      scale_colour_manual(values = phs_colours)+
      annual_marker()+
      my_theme()
  })
  
  output$home_plot_2 <- renderPlot({
    validate(
      need(nrow(home_tab_df()) != 0,
           "No data found that meet your search criteria"),
    )
    home_tab_df() %>% 
      ggplot(aes(x = quarter, y = avg_length_of_stay, group = hb, colour = hb)) + 
      geom_line() +
      geom_point(shape = 21, size = 2) + 
      labs(title = "Average Length of Stay 2017 - 2023",
           x = "Health Board", 
           y = "Average Length of Stay")+
      scale_colour_manual(values = phs_colours)+
      annual_marker()+
      my_theme()
  })
  
  
  
  
  #####
  # A&E TAB
  ae_tab_df <- eventReactive(
    eventExpr = input$update_ae,
    valueExpr = {
      if (input$hb_input_ae != "All"){
        ae_df <- ae_df %>%
          filter(HBT == input$hb_input_ae)
      }
      ae_df %>% 
        #group_by(Year, HBT) %>%
        summarise(no_admissions = sum(NumberOfAttendancesAggregate, na.rm = TRUE),
                  no_stay = sum(DischargeDestinationAdmissionToSame, na.rm = TRUE), 
                  no_discharge = sum(DischargeDestinationResidence, na.rm = TRUE),
                  .by = Year)
      # summarise(no_admissions = sum(NumberOfAttendancesAggregate, na.rm = TRUE),
      #           .by = c(Year, HBT))
    })
  
  # ae_tab_2 <- eventReactive(
  #   eventExpr = input$update_ae,
  #   valueExpr = {
  #     if (input$hb_input_ae != "All"){
  #       ae_df <- ae_df %>%
  #         filter(HBT == input$hb_input_ae)
  #     }
  #     ae_df %>% 
  #       # filter(HBT == "Highland") %>% 
  #       # group_by(Year) %>%
  #       summarise(no_stay = sum(DischargeDestinationAdmissionToSame, na.rm = TRUE), 
  #                 no_discharge = sum(DischargeDestinationResidence, na.rm = TRUE),
  #                 .by = Year)
  #     
  #   })
  
  output$ae_plot_1 <- renderPlot({
    validate(
      need(nrow(ae_tab_df()) != 0,
           "No data found that meet your search criteria"),
    )
    ae_tab_df() %>% 
      # ggplot(aes(x = Year, y = no_admissions,
      #            colour = HBT, group = HBT)) + 
      # geom_line() +
      ggplot(aes(x = Year, y = no_admissions)) + 
      geom_line(group = 1) +
      geom_point(shape = 21, size = 2) +
      scale_colour_manual(values = phs_colours)+
      my_theme()
  })
  
  output$ae_plot_2 <- renderPlot({
    validate(
      need(nrow(ae_tab_df()) != 0,
           "No data found that meet your search criteria"),
    )
    ae_tab_df() %>% 
      ggplot(aes(x = Year)) + 
      geom_line(aes(y= no_stay), group = 1, colour = "#3F3685") +
      geom_point(aes(y= no_stay), shape = 21, size = 2) +
      geom_line(aes(y= no_discharge), group = 1, colour = "#9B4393") +
      geom_point(aes(y= no_discharge), shape = 21, size = 2) +
      scale_y_continuous(labels = scales::comma) +
      scale_colour_manual(values = phs_colours)+
      my_theme()
  })
  
  
  
  
  #####  
  # AGE_SEX TAB
  age_gender_tab_1 <- eventReactive(
    eventExpr = input$update_age_sex,
    valueExpr = {
      if (input$hb_input_age_sex != "All"){
        age_sex_df <- age_sex_df %>% 
          filter(hb == input$hb_input_age_sex)
      }
      age_sex_df %>%
        mutate(pre_covid = case_when(str_detect(quarter, "^201") ~ "pre_covid",
                                     TRUE ~ "post_covid")) %>%
        filter(age %in% input$age_input) %>%
        # group_by(quarter, sex) %>%
        summarise(mean_episodes = mean(episodes, na.rm = TRUE),
                  mean_covid = mean(episodes, na.rm = TRUE),
                  .by = c(quarter, sex))
    })
  
  age_gender_tab_2 <- eventReactive(
    eventExpr = input$update_age_sex,
    valueExpr = {
      if (input$hb_input_age_sex != "All"){
        age_sex_df <- age_sex_df %>% 
          filter(hb == input$hb_input_age_sex)
      }
      age_sex_df %>%
        mutate(pre_covid = case_when(str_detect(quarter, "^201") ~ "pre_covid",
                                     TRUE ~ "post_covid")) %>%
        filter(age %in% input$age_input) %>%
        #mutate(), .by = pre_covid) %>%
        #group_by(quarter, sex) %>%
        summarise(mean_length_stay = mean(length_of_stay, na.rm = TRUE),
                  mean_covid = mean(length_of_stay, na.rm = TRUE),
                  .by = c(quarter, sex))
    })
  
  output$age_gender_plot_1 <- renderPlot({
    validate(
      need(nrow(age_gender_tab_1()) != 0,
           "No data found that meet your search criteria"),
    )
    age_gender_tab_1() %>% 
      ggplot(aes(x = quarter, y = mean_episodes,
                 group = sex, color = sex))+
      geom_point()+
      geom_line()+
      geom_hline(aes(yintercept = mean(mean_covid)), linetype = "dotted")+
      geom_ribbon(aes(y = mean(mean_covid), ymin = mean(mean_covid) - sd(mean_covid), ymax = mean(mean_covid) + sd(mean_covid)), alpha = 0.1) +
      scale_colour_manual(values = phs_colours)+
      annual_marker()+
      my_theme()
  })
  
  output$age_gender_plot_2 <- renderPlot({
    validate(
      need(nrow(age_gender_tab_2()) != 0,
           "No data found that meet your search criteria"),
    )
    age_gender_tab_2() %>% 
      ggplot(aes(x = quarter, y = mean_length_stay, group = sex))+
      geom_point(aes(color = sex))+
      geom_line(aes(color = sex))+
      geom_hline(aes(yintercept = mean(mean_covid)), linetype = "dotted")+
      geom_ribbon(aes(y = mean(mean_covid), ymin = mean(mean_covid) - sd(mean_covid), ymax = mean(mean_covid) + sd(mean_covid)), alpha = 0.2) +
      scale_colour_manual(values = phs_colours)+
      annual_marker()+
      my_theme()
  })
  
  
  
  
  #####
  # SIMD TAB
  simd_tab_df <- eventReactive(
    eventExpr = input$update_simd,
    valueExpr = {
      # if (input$hb_input_simd != "All"){
      #   simd_df <- simd_df %>% 
      #     filter(hb %in% input$hb_input_simd)
      # }
      simd_df %>% 
        filter(hb %in% input$hb_input_simd) %>% 
        filter(simd %in% input$simd_input) %>% 
        summarise(mean_episodes = mean(episodes, na.rm = TRUE),
                  mean_length_of_stay = mean(length_of_stay, na.rm = TRUE),
                  .by = c(quarter, simd))
    })
  
  # simd_tab_2 <- eventReactive(
  #   eventExpr = input$update_simd,
  #   valueExpr = {
  #     if (input$hb_input_simd != "All"){
  #       simd_df <- simd_df %>% 
  #         filter(hb == input$hb_input_simd)
  #     }
  #     simd_df %>%
  #       filter(simd %in% input$simd_input) %>% 
  #       summarise(mean_length_of_stay = mean(length_of_stay, na.rm = TRUE),
  #                 .by = c(quarter, simd))
  #   })
  
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
      annual_marker()+
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
      #geom_hline(aes(yintercept = mean(mean_length_of_stay)), linetype = "dotted")+
      labs(x = "Quarter/Year",
           y = "Mean number of episodes")+
      scale_colour_manual(values = phs_colours)+
      annual_marker()+
      my_theme()
  })
  
  
  
  
  #####
  # SPECIALTY TAB
  speciality_tab_1 <- eventReactive(
    eventExpr = input$update_specialty,
    valueExpr = {
      
      # if (hb_input_specialty != "All"){
      #   specialty_episode <- specialty_episode %>% 
      #     filter(hb == hb_input_specialty)
      # }
      
      specialty_episode %>%
        filter(specialty_name_top %in% input$specialty_input)
    })
  
  speciality_tab_2 <- eventReactive(
    eventExpr = input$update_specialty,
    valueExpr = {
      
      # if (hb_input_specialty != "All"){
      #   specialty_spell <- specialty_spell %>% 
      #     filter(hb == hb_input_specialty)
      # }
      
      specialty_spell %>% 
        filter(specialty_name_top %in% input$specialty_input)
    })
  
  output$specialty_plot_1 <- renderPlot({
    validate(
      need(nrow(speciality_tab_1()) != 0,
           "No data found that meet your search criteria"),
    )
    speciality_tab_1() %>%
      ggplot(aes(x=quarter, y=mean,
                 colour=specialty_name_top, group=specialty_name_top))+
      geom_point()+
      geom_line(linewidth=1)+
      labs(x = "Quarter/Year",
           y = "Mean number of episodes", 
           title="Mean number of episodes per quarter per year")+
      scale_colour_manual(values = phs_colours)+
      annual_marker()+
      my_theme()
  })
  
  output$specialty_plot_2 <- renderPlot({
    validate(
      need(nrow(speciality_tab_2()) != 0,
           "No data found that meet your search criteria"),
    )
    speciality_tab_2() %>%
      ggplot(aes(x=quarter, y=mean,
                 colour=specialty_name_top, group=specialty_name_top))+
      geom_point()+
      geom_line(linewidth=1)+
      labs(x = "Quarter/Year",
           y = "Mean of length of spell", 
           title="Mean of length of spell per quarter per year")+
      scale_colour_manual(values = phs_colours)+
      annual_marker()+
      my_theme()
  })
  
  
  
  
  #####  
  # COVID TAB
  # covid_tab_1 <- eventReactive(
  #   eventExpr = input$update,
  #   valueExpr = {
  #   })
  # 
  # covid_tab_2 <- eventReactive(
  #   eventExpr = input$update,
  #   valueExpr = {
  #   })
  #   #  
  #  
  # output$covid_plot <- renderPlot({
  #   ggplot(mtcars, aes(x=mpg, y=wt)) + 
  #     geom_point()
  # })
  
  
  
  
  #####
  # ALL TABS
  output$data_source_text <- renderText({
    "Data Source: https://www.opendata.nhs.scot/"
  })
}