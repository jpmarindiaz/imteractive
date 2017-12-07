
library(devtools)
document()
#load_all()
devtools::install()

library(imteractive)

#svg
img <- system.file("htmlwidgets/samples/cocina.svg", package = "imteractive")
imteractive(img)
imteractive(img, maxWidth = 500)


#png
img <- system.file("htmlwidgets/samples/cocina.png", package = "imteractive")
d <- data_frame(
  x = c(10,20),
  y = c(50,90)
)
imteractive(img, d = d)
imteractive(img, d = d, maxWidth = 700)



# A nice shiny app
library(shiny)
app <- shinyApp(
  ui = bootstrapPage(
    checkboxInput("swapNCols","Swap columns",value=FALSE),
    d3plusOutput("viz")
  ),
  server = function(input, output) {
    countries <- read.csv(system.file("data/countries.csv", package = "d3plus"))
    output$viz <- renderD3plus({
      d <- countries
      if(input$swapNCols){
        d <- d[c(1,3,2)]
      }
      d3plus(d,"tree")
    })
  }
)
runApp(app)








