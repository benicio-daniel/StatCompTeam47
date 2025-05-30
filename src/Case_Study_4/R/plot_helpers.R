# ----------------------------------------------
# Add plot functions
# ----------------------------------------------
render_basic_map <- function(df, var = "pop") {
  ggplot(df, aes(x = long, y = lat, group = group, fill = .data[[var]])) +
    geom_polygon(color = "white", size = 0.1) +
    scale_fill_viridis_c(option = "C", na.value = "lightgrey") +
    coord_equal() +
    theme_void()
}