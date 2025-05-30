# ----------------------------------------------
# Add plot functions
# ----------------------------------------------
univariate_tab <- function() {
  tabPanel("Univariate",
           sidebarLayout(
             sidebarPanel(
               selectInput("var1", "Variable:", choices = c("pop", "area", "life_exp")),
               actionButton("show_table", "Tabelle anzeigen")
             ),
             mainPanel(
               tabsetPanel(
                 tabPanel("Map", plotOutput("basicMap"))
               )
             )
           )
  )
}