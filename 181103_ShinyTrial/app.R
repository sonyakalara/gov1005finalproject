#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
raw <- readRDS("rdsObject.rds")

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("UC Berkeley Disaggregated Enrollment Statistics"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        selectInput("choice",
                    label = "Choose your Fighter", 
                    choices = c("Percent", "Total Enrollment"))
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
  output$distPlot <- renderPlot({
      
      data <- switch(input$choice, 
                     "Total Enrollment" = raw$total, 
                     "Percent" = raw$perc_stripped)
      
      ggplot(raw, aes(x = year, y = data, color = ethnicity)) + geom_line() +
      xlab("Percent / Total") +
      ylab("Year") +
      ggtitle("Enrollment by Race, Percentage vs. Total")
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

