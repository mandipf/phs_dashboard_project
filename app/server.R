server <- function(input, output) {
  
  # filter all of the data based on user selections
  health_board_update <- eventReactive(
    eventExpr = input$hb_update,
    valueExpr = {
      
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
    })
  
  filtered_data <- eventReactive(
    eventExpr = input$field_update,
    valueExpr = {
    })
 
  output$home_plot <- renderPlot({
    # validate(
    #   need(filtered_data() != "",
    #        "No games found that meet your search criteria"),
    # )
    ggplot(mtcars, aes(x=mpg, y=wt, fill = cyl)) + 
      geom_col()+
      my_theme()
  })
  
  output$ae_plot <- renderPlot({
    ggplot(mtcars, aes(x=mpg, y=wt, fill = cyl)) + 
      geom_point()
  })
  
  output$age_gender_plot <- renderPlot({
    ggplot(mtcars, aes(x=mpg, y=wt, fill = cyl)) + 
      geom_col()
  })
  
  output$simd_plot <- renderPlot({
    ggplot(mtcars, aes(x=mpg, y=wt)) + 
      geom_point()
  })
  
  output$specialty_plot <- renderPlot({
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