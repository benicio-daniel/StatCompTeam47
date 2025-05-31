multivariate_tab <- function() {
  tabPanel("Multivariate Analysis",
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