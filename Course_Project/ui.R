library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage (
  
  titlePanel("College Scorecard"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Ranking of Mean Earnings and Debt data for 7804 U.S.Colleges, 6 years after completion of
               undergraduate degree. Select an input from the dropdown box below to see the results"), 
  
      selectInput("var", 
                  label = "Choose data to display",
                  choices = list("Top 25 colleges for earnings",
                                 "Bottom 25 Colleges for earnings",
                                 "% students earning > $25K among top 25 Colleges",
                                 "% students earning > $25K among bottom 25 Colleges",
                                 "Average Debt among Low, Medium and High Income families"),
                  selected = 1)),
    
    mainPanel(
      h3(textOutput("text1"),align = "center"),
      tableOutput("school_table")
    )
  )
))

