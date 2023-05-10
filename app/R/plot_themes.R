phs_colours <- c("#3F3685", "#9B4393", "#0078D4", "#83BB26", "#948DA3",
                 "#1E7F84", "#6B5C85", "#C73918", "#655E9D", "#AF69A9",
                 "#3393DD", "#9CC951", "#A9A4B5", "#4B999D", "#897D9D",
                 "#D26146", "#9F9BC2", "#CDA1C9", "#80BCEA", "#C1DD93")

my_theme <- function() {
  theme(
    panel.border = element_rect(colour = "lightgrey", fill = NA, linetype = 2),
    panel.background = element_rect(fill = "white"),
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_line(colour = "lightgrey", linewidth = 0.2),
    panel.grid.minor = element_blank(),
    text = element_text(size = 16),
    plot.title = element_text(size = 22, hjust = 0.5),
    plot.subtitle = element_text(size = 18, hjust = 0.5),
    plot.caption = element_text(size = 10, hjust = 0.5),
    axis.title = element_text(size = 18),
    axis.text.y = element_text(size = 16),
    axis.text.x = element_text(angle = 0, hjust = 0.5, size = 16),
    legend.title = element_blank(),
    legend.position = "right"
  )
}

quarter_annual_marker <- function(){
  list(geom_vline(xintercept = c("2018Q1", "2019Q1", "2020Q1", "2021Q1",
                                 "2022Q1", "2023Q"),
                  linetype = 'dashed'),
       scale_x_discrete(breaks = c("2017Q3", "2018Q3", "2019Q3", "2020Q3",
                                   "2021Q3", "2022Q3", "2023Q3"),
                        labels = c("2017Q3" = "2017",
                                   "2018Q3" = "2018",
                                   "2019Q3" = "2019",
                                   "2020Q3" = "2020",
                                   "2021Q3" = "2021",
                                   "2022Q3" = "2022",
                                   "2023Q3" = "2023"))
  )
}

month_annual_marker <- function(){
  list(geom_vline(xintercept = c("201701", "201801", "201901", "202001",
                                 "202101", "202201", "202301"),
                  linetype = 'dashed'),
       scale_x_discrete(breaks = c("201706", "201806", "201906", "202006",
                                   "202106", "202206", "202306"),
                        labels = c("201706" = "2017",
                                   "201806" = "2018",
                                   "201906" = "2019",
                                   "202006" = "2020",
                                   "202106" = "2021",
                                   "202206" = "2022",
                                   "202306" = "2023"))
  )
}
