# ----------------------------------------------
# Ich habe hier schon mal einen Test eingefügt, obs funktioniert, drück mal oben auf "Run App" :)
#
# Load required packages
# ----------------------------------------------
library(shiny)
library(ggplot2)

# ----------------------------------------------
# Load prepared data from external script
# ----------------------------------------------
source("R/data_prep.R")   # provides prepare_data()
df <- prepare_data()      # cleaned and merged dataset
glimpse(df)               # zeigt Daten, einfach löschen 

# ----------------------------------------------
# Define UI (minimal layout)
# ----------------------------------------------
ui <- fluidPage(
  titlePanel("Test World Map – Population"),
  mainPanel(
    plotOutput("basicMap")
  )
)

# ----------------------------------------------
# Define server logic
# ----------------------------------------------
server <- function(input, output, session) {
  output$basicMap <- renderPlot({
    ggplot(df, aes(x = long, y = lat, group = group, fill = pop)) +
      geom_polygon(color = "white", size = 0.1) +
      scale_fill_viridis_c(option = "C", na.value = "lightgrey") +
      coord_equal() +
      theme_void()
  })
}

# ----------------------------------------------
# Run the app
# ----------------------------------------------
shinyApp(ui, server)