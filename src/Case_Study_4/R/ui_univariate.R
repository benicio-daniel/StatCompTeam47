library(DT)
library(plotly)
# Mapping of display names to column names
var_choices <- c(
  "Education Expenditure" = "edu_exp",
  "Youth Unemployment Rate" = "unemp_youth_rate",
  "Life Expectancy" = "life_exp",
  "Population Growth Rate" = "pop",
  "Net Migration Rate" = "net_migr_rate",
  "Electricity Fossil Fuel" = "electricity_fossil_fuel"
)
univariate_tab <- function() {
  tabPanel("Univariate Analysis",
           sidebarLayout(
             sidebarPanel(
               selectInput("var1", "Variable:", choices = var_choices),
               actionButton("show_table", "View Raw Data"),
               DTOutput("dynamicTable")
             ),
             mainPanel(
               tabsetPanel(
                 tabPanel("Map", plotlyOutput("mapPlot")),
                 
                 tabPanel("Global Analysis",
                          fluidRow(
                            column(6, plotlyOutput("globalBoxplot")),
                            column(6, plotlyOutput("globalDensity"))
                          )
                 ),
                 
                 tabPanel("Analysis per Continent",
                          fluidRow(
                            column(6, plotlyOutput("continentBoxplot")),
                            column(6, plotlyOutput("continentDensity"))
                          )
                 )
               )
             )
           )
  )
}