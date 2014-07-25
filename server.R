library(shiny)
library(ggmap)
library(zipcode)

zipcode <- zipcode
data(zipcode)
load("map.Rda")
gmap <- ggmap(map)
nsfd <- read.csv("process/processedData.csv")
nsfd$fundsMil <- nsfd$funds/1000000
y <- 2008

currentMap <- function(y){
  return(gmap + geom_point(data = nsfd[nsfd$year== y,], aes(x=long, y=lat, color=fundsMil, size=fundsMil), na.rm=TRUE))
}

findCity <- function(z){
  cityState <- zipcode[zipcode$zip == z, c("city", "state")]
  return(paste(cityState[1], cityState[2], sep = ", "))
}

shinyServer(
  function(input,output){
    #x <- reactive({as.numeric(input$text1)+100})
    y <- reactive(as.numeric(input$y))
    output$text1 <- renderText(y())
    output$nsfMap <- renderPlot({
      currentMap(y())
    })
    
  }
  
  
  
)