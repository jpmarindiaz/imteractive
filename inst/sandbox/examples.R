
library(devtools)
document()
#load_all()
devtools::install()

library(imteractive)

# Mapa Colombia
img <- system.file("htmlwidgets/samples/colombia_map.svg", package = "imteractive")
imteractive(img, debug = TRUE, maxWidth = 1440)

e <- imteractive(img, debug = TRUE, maxWidth = 400)
saveWidget(e,"~/Desktop/tmp.html")

d <- data_frame(
  id = c("CO-SAP", "CO-LAG", "CO-CUN"),
  number = c(10,20, 30),
  text = c("C1","C2","C3"),
  color = c("#AA4032","#46FF32","#3490AA")
)
tpl <- "<h1>{id}</h1><h2>{number}</h2>"
imteractive(img, d = d, debug = TRUE, template = tpl, maxWidth = 400)

imteractive(img, d = d, debug = TRUE, template = tpl, maxWidth = 400, clickable = TRUE)
imteractive(img, d = d, debug = TRUE, template = tpl, maxWidth = 400, clickable = FALSE, pointer = TRUE)
imteractive(img, d = d, debug = TRUE, template = tpl, maxWidth = 400, clickable = FALSE, pointer = TRUE, fill = FALSE)


imteractive(img, maxWidth = 500)





# Audios Cocina
img <- system.file("htmlwidgets/samples/alacena-audios.svg", package = "imteractive")
imteractive(img, debug = TRUE)

#svg
img <- system.file("htmlwidgets/samples/cocina.svg", package = "imteractive")
imteractive(img, debug = TRUE)

d <- data_frame(
  id = c("info_circle1", "info_circle2", "info_rect1", "info_rect2"),
  number = c(10,20, 30, 40),
  text = c("C1","C2","R1","R2")
)
tpl <- "<h1>{id}</h1><h2>{number}</h2>"
imteractive(img, d = d, debug = TRUE, template = tpl)
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
    #countries <- read.csv(system.file("data/countries.csv", package = "d3plus"))
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








