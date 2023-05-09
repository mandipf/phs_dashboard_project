server <- function(input, output) {

  # health board selection button
  health_board_update <- eventReactive(
    eventExpr = input$hb_update,
    valueExpr = {
      input$hb_input
    })
  
  home_tab_1 <- eventReactive(
    eventExpr = input$field_update,
    valueExpr = {
    })
    
  home_tab_2 <- eventReactive(
    eventExpr = input$field_update,
    valueExpr = {
    })
  
  age_gender_tab_1 <- eventReactive(
    eventExpr = input$field_update,
    valueExpr = {
    })
  
  age_gender_tab_2 <- eventReactive(
    eventExpr = input$field_update,
    valueExpr = {
    })
  
  simd_tab_1 <- eventReactive(
    eventExpr = input$field_update,
    valueExpr = {
    })
  
  simd_tab_2 <- eventReactive(
    eventExpr = input$field_update,
    valueExpr = {
    })
  
  speciality_tab_1 <- eventReactive(
    eventExpr = input$field_update,
    valueExpr = {
    })
  
  speciality_tab_2 <- eventReactive(
    eventExpr = input$field_update,
    valueExpr = {
    })
  
  covid_tab_1 <- eventReactive(
    eventExpr = input$field_update,
    valueExpr = {
    })
  
  covid_tab_2 <- eventReactive(
    eventExpr = input$field_update,
    valueExpr = {
    })

  # # filter genre if single option or do not filter if "All" selected
  # if (input$genre_input != "All") {
  #   genre_filtered_sales <- game_sales %>% 
  #     filter(genre == input$genre_input)
  # } else {
  #   genre_filtered_sales <- game_sales
  # }
  # 
  # # filter everything else
  # filtered_data <- genre_filtered_sales %>%
  #   filter(platform == input$platform_input,
  #          year_of_release >= input$year_input[1],
  #          year_of_release <= input$year_input[2],
  #          rating %in% input$rating_input,
  #          critic_score >= input$critic_score_input[1],
  #          critic_score <= input$critic_score_input[2], 
  #          user_score >= input$user_score_input[1],
  #          user_score <= input$user_score_input[2]) 
  # 
  # filtered_data
  
  
 
  output$home_plot_1 <- renderPlot({
    # validate(
    #   need(filtered_data() != "",
    #        "No data found that meet your search criteria"),
    # )
    ggplot(mtcars, aes(x=mpg, y=wt, fill = as.character(cyl))) + 
      geom_col()+
      my_theme()+
      scale_fill_manual(values = phs_colours)
  })
  
  output$home_plot_2 <- renderPlot({
    # validate(
    #   need(filtered_data() != "",
    #        "No games found that meet your search criteria"),
    # )
    ggplot(mtcars, aes(x=mpg, y=wt, fill = cyl)) + 
      geom_col()+
      my_theme()
  })
  
  output$ae_plot_1 <- renderPlot({
    ggplot(mtcars, aes(x=mpg, y=wt, fill = cyl)) + 
      geom_point()
  })
  
  output$ae_plot_2 <- renderPlot({
    ggplot(mtcars, aes(x=mpg, y=wt, fill = cyl)) + 
      geom_point()
  })
  
  output$age_gender_plot_1 <- renderPlot({
    ggplot(mtcars, aes(x=mpg, y=wt, fill = cyl)) + 
      geom_col()
  })
  
  output$age_gender_plot_2 <- renderPlot({
    ggplot(mtcars, aes(x=mpg, y=wt, fill = cyl)) + 
      geom_col()
  })
  
  output$simd_plot_1 <- renderPlot({
    ggplot(mtcars, aes(x=mpg, y=wt)) + 
      geom_point()
  })
  
  output$simd_plot_2 <- renderPlot({
    ggplot(mtcars, aes(x=mpg, y=wt)) + 
      geom_point()
  })
  
  output$specialty_plot_1 <- renderPlot({
    ggplot(mtcars, aes(x=mpg, y=wt)) + 
      geom_col()
  })
  
  output$specialty_plot_2 <- renderPlot({
    ggplot(mtcars, aes(x=mpg, y=wt)) + 
      geom_col()
  })
  
  output$covid_plot <- renderPlot({
    ggplot(mtcars, aes(x=mpg, y=wt)) + 
      geom_point()
  })
  
  output$data_source_text <- renderText({
    "Data Source: https://www.opendata.nhs.scot/"
  })
}