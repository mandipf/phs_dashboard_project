phs_colours <- c("#3F3685", "#9B4393", "#0078D4", "#83BB26", "#948DA3",
                 "#1E7F84", "#6B5C85", "#C73918")

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
    legend.title = element_blank(),
    legend.position = "bottom",
  )
}