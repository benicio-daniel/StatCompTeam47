# ----------------------------------------------
# Load required packages
# ----------------------------------------------
# install.packages(c("shiny","ggplot2", "here"))
library(shiny)
library(ggplot2)
library(here)

# ----------------------------------------------
# Our Files
# ----------------------------------------------
source(here("src", "Case_Study_4", "R", "plot_helpers.R"))
source(here("src", "Case_Study_4", "R", "ui_univariate.R"))
#source(here("src", "Case_Study_4", "R", "server_univariate.R"))  laden erst, wenn da funktionen drin sind!
#source(here("src", "Case_Study_4", "R", "ui_multivariate.R"))
#source(here("src", "Case_Study_4", "R", "server_multivariate.R"))

# ----------------------------------------------
# Load prepared data from external script
# ----------------------------------------------
source(here("src", "Case_Study_4", "R", "data_prep.R"))   # provides prepare_data()
df <- prepare_data()                                      # cleaned and merged dataset

glimpse(df)               # zeigt Daten, einfach löschen 

# ----------------------------------------------
# Define UI
# ----------------------------------------------
ui <- fluidPage(
  titlePanel("World Facts App"),
  tabsetPanel(
    univariate_tab()
  )
)

# ----------------------------------------------
# Define server logic
# ----------------------------------------------
server <- function(input, output, session) {
  output$basicMap <- renderPlot({
    render_basic_map(df, input$var1)
  })
  
  # Closes App when R Studion is closed
  session$onSessionEnded(function() {
    stopApp()
  })
}

# ----------------------------------------------
# Run the app (in extern browser)
# ----------------------------------------------
shiny::runApp(list(ui = ui, server = server), launch.browser = TRUE)