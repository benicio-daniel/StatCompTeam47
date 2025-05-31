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
source(here("src", "Case_Study_4", "R", "plot_helpers.R"))
source(here("src", "Case_Study_4", "R", "ui_univariate.R"))
source(here("src", "Case_Study_4", "R", "server_univariate.R"))
source(here("src", "Case_Study_4", "R", "data_prep.R"))

# ----------------------------------------------
# Load data
# ----------------------------------------------
df <- prepare_data()  # cleaned and merged dataset

# ----------------------------------------------
# Define UI
# ----------------------------------------------
ui <- fluidPage(
  titlePanel("World Facts App"),
  tabsetPanel(
    univariate_tab()
    # multivariate_tab()  # Uncomment when ready
  )
)

# ----------------------------------------------
# Define server logic
# ----------------------------------------------
server <- function(input, output, session) {
  univariate_server(input, output, session, df)
  
  # Closes App when R Studio is closed
  session$onSessionEnded(function() {
    stopApp()
  })
}

# ----------------------------------------------
# Run the app
# ----------------------------------------------
shinyApp(ui = ui, server = server)