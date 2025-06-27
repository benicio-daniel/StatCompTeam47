# ----------------------------------------------
# Load required packages
# ----------------------------------------------
library(shiny)
library(ggplot2)
library(here)
library(DT)
library(plotly)
library(viridis)

# ----------------------------------------------
# Source project files
# ----------------------------------------------
source(here("R", "plot_helpers.R"))
source(here("R", "ui_univariate.R"))
source(here("R", "server_univariate.R"))
source(here("R", "ui_multivariate.R"))
source(here("R", "server_multivariate.R"))
source(here("R", "data_prep.R"))

# ----------------------------------------------
# Load data
# ----------------------------------------------
df <- prepare_data()  # cleaned and merged dataset

# ----------------------------------------------
# Define UI
# ----------------------------------------------
ui <- fluidPage(
  titlePanel("CIA World Factbook 2020"),
  
  # Subtitle
  tags$h5(
    tags$em("Welcome to my shiny app, which allows you to visualize variables from the CIA 2020 factbook on the world map, generate descriptive statistics and statistical graphics.")
  ),
  
  tabsetPanel(
    univariate_tab(),
    multivariate_tab()
  )
)
# ----------------------------------------------
# Define server logic
# ----------------------------------------------
server <- function(input, output, session) {
  univariate_server(input, output, session, df)
  multivariate_server(input, output, session, df)
  
  # Closes App when R Studio is closed
  session$onSessionEnded(function() {
    stopApp()
  })
}

# ----------------------------------------------
# Run the app
# ----------------------------------------------
shinyApp(ui = ui, server = server)