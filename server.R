library(shiny)
library(ggmap)
#library(zipcode)

# zipcode <- zipcode
# data(zipcode)
load("map.Rda")
gmap <- ggmap(map)
nsfd <- read.csv("process/processedData.csv", colClasses=c(zip="character"))
#nsfd$fundsMil <- nsfd$funds/1000000
#nsfd$cityState <- sapply(nsfd$zip, findCity)
y <- 2008

currentMap <- function(y){
  return(gmap + geom_point(data = nsfd[nsfd$year== y,], aes(x=long, y=lat, color=fundsMil, size=fundsMil), 
                           na.rm=TRUE, name = "Funds Awarded($M)") + scale_size(guide = 'none')
         + scale_colour_gradientn(colours=c("blue","purple","red"), name = "Funds Awarded($M)")
         + theme(axis.line=element_blank(),axis.text.x=element_blank(),
                  axis.text.y=element_blank(),axis.ticks=element_blank(),
                  axis.title.x=element_blank(),
                  axis.title.y=element_blank())
  )
}

# findCity <- function(z){
#   cityState <- zipcode[zipcode$zip == z, c("city", "state")]
#   return(paste(cityState[1], cityState[2], sep = ", "))
# }

findTop10 <- function(y){
  nsfdtemp <- nsfd[nsfd$year == y,]
  top <- head(nsfdtemp[with(nsfdtemp, order(-fundsMil)),c("cityState", "fundsMil")], 10)
  names(top) <- c("City, State", "Funds Awarded ($Millions)")
  return(top)
}


shinyServer(
  function(input,output){
    #x <- reactive({as.numeric(input$text1)+100})
    y <- reactive(as.numeric(input$y))
    output$text1 <- renderText(y())
    output$nsfMap <- renderPlot({
      currentMap(y())
    })
    output$top10 <- renderDataTable({
      findTop10(y())},options = list(bFilter=0, bSort=0, bProcessing=0, bPaginate=0, bInfo=0))
    
  }
  
  
  
)