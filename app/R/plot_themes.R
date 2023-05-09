phs_colours <- c("#3F3685", "#9B4393", "#0078D4", "#83BB26", "#948DA3",
                 "#1E7F84", "#6B5C85", "#C73918", "#655E9D", "#AF69A9",
                 "#3393DD", "#9CC951", "#A9A4B5", "#4B999D", "#897D9D",
                 "#D26146")

my_theme <- function() {
  theme(
    panel.border = element_rect(colour = "lightgrey", fill = NA, linetype = 2),
    panel.background = element_rect(fill = "white"),
    panel.grid.major = element_line(colour = "lightgrey", linewidth = 0.2),
    panel.grid.minor = element_blank(),
    text = element_text(size = 16),
    plot.title = element_text(size = 18, hjust = 0.5),
    plot.subtitle = element_text(size = 14, hjust = 0.5),
    plot.caption = element_text(size = 10, hjust = 0.5),
    axis.title = element_text(size = 18),
    axis.text.x = element_text(angle = 90, hjust = 1, size = 5),
    legend.title = element_blank(),
    legend.position = "right"
  )
}

annual_marker <- function(){
  list(geom_vline(xintercept = c("2018Q1", "2019Q1", "2020Q1", "2021Q1", "2022Q1", "2023Q" ), linetype = 'dashed'),
       annotate("text", x = "2017Q3", y = 15, label = "2017"),
       annotate("text", x = "2018Q3", y = 15, label = "2018"),
       annotate("text", x = "2019Q3", y = 15, label = "2019"),
       annotate("text", x = "2020Q3", y = 15, label = "2020"),
       annotate("text", x = "2021Q3", y = 15, label = "2021"),
       annotate("text", x = "2022Q3", y = 15, label = "2022")
  )
}
