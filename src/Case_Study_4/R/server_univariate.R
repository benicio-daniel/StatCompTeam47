library(plotly)
library(viridis)

univariate_server <- function(input, output, session, df) {
  
  var_choices <- c(
    "Education Expenditure" = "edu_exp",
    "Youth Unemployment Rate" = "unemp_youth_rate",
    "Life Expectancy" = "life_exp",
    "Population Growth Rate" = "pop_growth_rate",
    "Net Migration Rate" = "net_migr_rate",
    "Electricity Fossil Fuel" = "electricity_fossil_fuel"
  )
  # 1. Map Plot
  output$mapPlot <- renderPlotly({
    label <- names(var_choices)[var_choices == input$var1]
    
    p <- ggplot(df, aes(
      x = long, y = lat, group = group,
      fill = .data[[input$var1]],
      text = paste0("Country: ", country, "<br>",
                    label, ": ", round(.data[[input$var1]], 2))
    )) +
      geom_polygon(color = "white") +
      scale_fill_viridis_c(option = "plasma") +
      theme_void()
    
    ggplotly(p, tooltip = "text")
  })
  
  # 2. Global Boxplot
  output$globalBoxplot <- renderPlotly({
    label <- names(var_choices)[var_choices == input$var1]
    
    p <- ggplot(df, aes(
      y = .data[[input$var1]],
      text = paste0(label, ": ", round(.data[[input$var1]], 2))
    )) +
      geom_boxplot(fill = "skyblue") +
      theme_minimal() +
      labs(y = label)
    
    ggplotly(p, tooltip = "text")
  })
  # 3. Global Density Plot
  output$globalDensity <- renderPlotly({
    label <- names(var_choices)[var_choices == input$var1]
    
    p <- ggplot(df, aes(x = .data[[input$var1]])) +
      geom_histogram(aes(y = ..density..), 
                     bins = 30, fill = "grey", color = "black", alpha = 0.4) +
      geom_density(fill = "blue", alpha = 0.4) +
      labs(x = label, y = "Density") +
      theme_minimal()
    
    ggplotly(p, tooltip = c("x", "y"))
  })
  # 4. Continent Boxplot
  output$continentBoxplot <- renderPlotly({
    label <- names(var_choices)[var_choices == input$var1]
    
    p <- ggplot(df, aes(
      x = continent, y = .data[[input$var1]],
      fill = continent,
      text = paste0("Continent: ", continent, "<br>",
                    label, ": ", round(.data[[input$var1]], 2))
    )) +
      geom_boxplot() +
      theme_minimal() +
      labs(y = label)
    
    ggplotly(p, tooltip = "text")
  })
  
  # 5. Continent Density
  output$continentDensity <- renderPlotly({
    label <- names(var_choices)[var_choices == input$var1]
    
    p <- ggplot(df, aes(x = .data[[input$var1]], fill = continent, color = continent)) +
      geom_density(alpha = 0.4, size = 1) +  # alpha for fill, size=1 for outline
      theme_minimal() +
      labs(x = label, y = "Density")
    
    ggplotly(p, tooltip = c("x", "fill"))
  })
  
  # Table
  observeEvent(input$show_table, {
    output$dynamicTable <- renderDT({
      df_subset <- df[, c("country", "continent", input$var1), drop = FALSE]
      df_subset <- head(df_subset, 15)
      
      datatable(
        df_subset,
        options = list(
          pageLength = 15,
          lengthChange = FALSE,
          searching = FALSE,
          paging = FALSE
        )
      )
    })
  })
}