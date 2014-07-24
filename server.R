library(shiny)


shinyServer(
  function(input,output){
    #x <- reactive({as.numeric(input$text1)+100})
    y <- reactive(input$y)
    output$text1 <- renderText(y())
    
    
  }
  
  
  
)