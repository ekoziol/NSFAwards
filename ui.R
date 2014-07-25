library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("National Science Foundation Funding Breakdown"),
  sidebarPanel(
    p('The purpose of this data application is to explore how funding allocations from 
      the NSF across the United States change with time.  To interact with the app just change the slider to 
      the year you wish to view.  The map will then change to show you how funds were distributed for that year.
      Below you will find a list of the top ten cities based on funding for that year.'),
    h3('Select a year'),
    sliderInput('y', '',value = 2010, min = 2006, max = 2014, step = 1, format="####"),
    dataTableOutput('top10'),
    tags$style(type="text/css", '#top10 tfoot {display:none;}')
    
  ),
  mainPanel(
    h3('Geographic Funding Breakdown'),
    p('Below you can view how the location of funding from the National Science Foundation (NSF) changes by year.
      NSF Funding can be seen as a source of upcoming technologies that will likely be in industry in the next 
      5 to 10 years.  Therefore, by viewing the data below, you may be able to predict the location of the next big
      trend.  The locations of the largest funding tend to be major universities but it is interesting to note how their
      total funding changes from year to year.  The data was taken courtesy of http://www.research.gov/research-portal/appmanager/base/desktop?_nfpb=true&_eventName=viewQuickSearchFormEvent_so_rsr
      which was found on www.data.gov.'),
    plotOutput('nsfMap', height = 800, width = 800)
  )
))