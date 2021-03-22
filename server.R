library(shiny)
library(ggplot2)

shinyServer(function(input, output){
  
  output$dplot <- renderPlot({
    
    nsamp <- input$sampleSize
    my_diamonds <- diamonds[sample(nrow(diamonds), nsamp), ]
    
    
    if (input$selection == "cut")
      g <- ggplot(my_diamonds, aes(x=carat, y=price, color=cut))
    else if (input$selection == "color")
      g <- ggplot(my_diamonds, aes(x=carat, y=price, color=color))
    else
      g <- ggplot(my_diamonds, aes(x=carat, y=price, color=clarity))
    
    g <- g + geom_point() + ggtitle("Plot of price vs carat") +
      ylab("Price (US $)") +
      theme(plot.title = element_text(size=16,face="bold", hjust=0.5),
            axis.title.x = element_text(size=14, face="bold"),
            axis.title.y = element_text(size=14, face="bold")
      )
    g
  })
  
  output$table <- renderTable({
    nsamp <- input$sampleSize
    my_diamonds <- diamonds[sample(nrow(diamonds), nsamp), ]
    most_exp <- max(my_diamonds$price)
    info <- my_diamonds[my_diamonds$price == most_exp,]
    info 
    }, bordered = TRUE, hover = TRUE, align="c")
})