
library(plotly)
library(dplyr)

multivariate_server <- function(input, output, session, df) {

  # Variable choices mapping
  var_choices <- c(
    "Education Expenditure" = "edu_exp",
    "Youth Unemployment Rate" = "unemp_youth_rate",
    "Life Expectancy" = "life_exp",
    "Population Growth Rate" = "pop_growth_rate",
    "Net Migration Rate" = "net_migr_rate",
    "Electricity Fossil Fuel" = "electricity_fossil_fuel"
  )

  # Size choices
  size_choices <- c(
    "Population" = "pop",
    "Area" = "area"
  )

  # Reactive data for analysis
  analysis_data <- reactive({
    df %>%
      select(country, continent, edu_exp, unemp_youth_rate, life_exp,
             pop_growth_rate, net_migr_rate, electricity_fossil_fuel,
             area, pop) %>%
      distinct() %>%
      filter(!is.na(country)) %>%
      filter(!is.na(continent))
  })

  # Interactive scatterplot
  output$multivariateScatter <- renderPlotly({
    data <- analysis_data()

    # Get variable labels
    var1_label <- names(var_choices)[var_choices == input$var1]
    var2_label <- names(var_choices)[var_choices == input$var2]
    size_label <- names(size_choices)[size_choices == input$size_var]

    # Create the plot
    p <- ggplot(data, aes(x = .data[[input$var1]],
                         y = .data[[input$var2]])) +

      # Add points with size and color aesthetic
      geom_point(aes(color = continent,
                     size = .data[[input$size_var]]),
                 alpha = 0.7) +

      # Add smooth lines for each continent
      geom_smooth(aes(color = continent),
                  method = "loess",
                  se = FALSE,
                  size = 1) +

      # Labels and theme
      labs(x = var1_label,
           y = var2_label,
           color = "Continent",
           size = size_label) +
      theme_minimal() +

      # Adjust size scale for better visibility
      scale_size_continuous(range = c(1, 10))

    # Convert to plotly
    ggplotly(p)
  })
}