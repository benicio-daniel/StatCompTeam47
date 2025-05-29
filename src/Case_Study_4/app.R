# kurze Beschreibung:
# Anscheined müssen wir ein .R file machen, dann kann so auf Funktionen eines Dokuments zugegriffen werden.
# .Rmd anscheindend nicht Empfolen

source("R/data_prep.R")
df <- prepare_data()

# app.R  (liegt im Projekt-Wurzelverzeichnis)
library(shiny)
library(tidyverse)
library(plotly)

## ---- Daten laden --------------------------------------------------------
source("Try_and_Error.R")           # ruft Funktion aus dem Helferskript
world_full <- prepare_data()

## ---- UI -----------------------------------------------------------------
ui <- fluidPage(
  titlePanel("CIA World Facts – Shiny Demo"),
  tabsetPanel(
    tabPanel("Univariate",
             sidebarLayout(
               sidebarPanel(
                 selectInput("var1", "Variable:",
                             choices = c("pop", "gdp_pc", "area", "life_exp")),
                 actionButton("show_table", "Tabelle anzeigen")
               ),
               mainPanel(
                 tabsetPanel(
                   tabPanel("Map",   plotlyOutput("mapPlot")),
                   tabPanel("Global", plotlyOutput("boxPlot")),
                   tabPanel("Continent", plotlyOutput("contBoxPlot"))
                 )
               )
             )
    ),
    tabPanel("Multivariate",
             sidebarLayout(
               sidebarPanel(
                 selectInput("xvar", "x-Achse:", choices = c("gdp_pc", "life_exp")),
                 selectInput("yvar", "y-Achse:", choices = c("pop", "area")),
                 selectInput("sizevar", "Punktgröße:", choices = c("pop", "area"))
               ),
               mainPanel(plotlyOutput("scatterPlot"))
             )
    )
  )
)

## ---- Server -------------------------------------------------------------
server <- function(input, output, session) {
  
  ## Reaktive Datengrundlage (wird nur gefiltert, nicht neu eingelesen)
  data_reactive <- reactive({
    world_full   # hier könntest du künftig Filter einbauen
  })
  
  # Beispiel-Map
  output$mapPlot <- renderPlotly({
    df <- data_reactive()
    gg <- ggplot(df, aes(long, lat, group = group,
                         fill = .data[[input$var1]])) +
      geom_polygon(color = "grey30", size = 0.1) +
      scale_fill_viridis_c(option = "C") +
      coord_equal() +
      theme_void()
    ggplotly(gg)
  })
  
  # … (weitere Outputs analog)
}

## ---- App starten --------------------------------------------------------
shinyApp(ui, server)
