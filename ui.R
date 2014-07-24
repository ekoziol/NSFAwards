library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("National Science Foundation Funding Breakdown"),
  sidebarPanel(
    h3('Select a year'),
    sliderInput('y', 'Pick a year',value = 2008, min = 2005, max = 2015, step = 1)
    
  ),
  mainPanel(
    h3('Geographic Monetary Breakdown'),
    p('some test text'),
    textOutput('text1')
  )
))