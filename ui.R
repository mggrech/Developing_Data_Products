library (shiny)
library (ggplot2)
library(plotly)

data <- diamonds
options <- c("color", "cut","clarity")


shinyUI(fluidPage(
  titlePanel(
     h1("Play with Diamonds!", align = "center")
  ),
  
  tags$style(HTML("
      #first {
          border: 2px solid blue;
      }
      #second {
          border: 2px solid red;
      }
      #third {
        border: 2px solid green;
      }
    ")),
  br(),
  fluidRow(id="first",
    column(4,
      sliderInput('sampleSize', 'Move the slider to select the number of diamonds to plot', 
                   min=100, max=500, value=min(100, 1000), 
                   step=1, round=0),
      br(),
      radioButtons("selection", "Which diamond attribute would you like the color of the points to represent?", options), 
    ),
    column(8,
           plotOutput("dplot", hover=TRUE)
    )
  ),
  
  br(),
  fluidRow(id="second", 
           h5(strong("Attributes for the most expensive diamond in the above selection:"),style="padding:15px"),
           column(1, 
                  tableOutput("table"),
           )
  ),
  
  br(),
  fluidRow(id="third",
           p(strong("Documentation:"), "This application randomly selects a certain number of diamonds 
             chosen by the user from R's inbuilt package", em("diamonds"), "and creates a plot of price versus 
             carat for the selected diamonds. The user specifies the number of diamonds 
             using the slider. The user can also choose which diamond attribute (clarity, color, or cut)
             is used to color the plotted points by clicking the respective radio button. 
             The plot's legend changes to reflect the attribute that has been selected. 
             All the attributes (10 in total) of the most expensive diamond in the current 
             selection are shown in the table every time the slider is moved to select a 
             new set of diamonds for analysis.", 
              br(), 
              br(), strong("Explanation of the attributes shown in the table:"), 
              br(), strong("price:"), "US dollars ($326-$18,823)",
              br(), strong("carat:"), "weight of the diamond (0.2-5.01)",
              br(), strong("cut:"),"quality of the cut (Fair, Good, Very Good, Premium, Ideal)",
              br(), strong("color:"), "diamond color (D = best to J = worst)",
              br(), strong("clarity:"), "a measurement of how clear the diamond is (I1 (worst), SI2, SI1, VS2, VS1, VVS2, VVS1, IF (best))",
              br(), strong("x:"), "length in mm (0-10.74)",
              br(), strong("y:"), "width in mm (0-58.9)",
              br(), strong("z:"), "depth in mm (0-31.8)",
              br(), strong("depth:"), "total depth percentage = z / mean(x, y) = 2 * z / (x + y) (43-79)",
              br(), strong("table:"), "width of top of diamond relative to widest point (43-95)",
              br(),
              br(), "More information about the", em("diamonds"), "data set can be found in the", em("R Documentation."),
             style="text-align:justify; padding:15px")
  )
))