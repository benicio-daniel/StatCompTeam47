
library(plotly)

multivariate_tab <- function() {
  
  # Variable choices from univariate analysis
  var_choices <- c(
    "Education Expenditure" = "edu_exp",
    "Youth Unemployment Rate" = "unemp_youth_rate",
    "Life Expectancy" = "life_exp",
    "Population Growth Rate" = "pop",
    "Net Migration Rate" = "net_migr_rate",
    "Electricity Fossil Fuel" = "electricity_fossil_fuel"
  )
  
  # Size choices
  size_choices <- c(
    "Population" = "pop",
    "Area" = "area"
  )
  
  tabPanel("Multivariate Analysis",
           sidebarLayout(
             sidebarPanel(
               selectInput("var1", "Select variable 1:", choices = var_choices),
               selectInput("var2", "Select variable 2:", choices = var_choices, selected = var_choices[2]),
               selectInput("size_var", "Scale points by:", choices = size_choices)
             ),
             
             mainPanel(
               plotlyOutput("multivariateScatter", height = "600px")
             )
           )
  )
}