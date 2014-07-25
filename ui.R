library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("National Science Foundation Funding Breakdown"),
  sidebarPanel(
    h3('Select a year'),
    sliderInput('y', '',value = 2008, min = 2005, max = 2014, step = 1, format="####")
    
  ),
  mainPanel(
    h3('Geographic Funding Breakdown'),
    p('Below you can view how the location of funding from the National Science Foundation (NSF) changes by year.
      NSF Funding can be seen as a source of upcoming technologies that will likely be in industry in the next 
      5 to 10 years.  Therefore, by viewing the data below, you may be able to predict the location of the next big
      trend.'),
    plotOutput('nsfMap', height = 800, width = 800)
  )
))