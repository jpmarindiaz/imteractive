library(shiny)
library(imteractive)

app <- shinyApp(
  ui = bootstrapPage(
    verbatimTextOutput("debug"),
    checkboxInput("color","Color?", value = TRUE),
    imteractiveOutput("viz")
  ),
  server = function(input, output, session) {
    output$debug <- renderPrint({
      input$viz_clicked_id
    })
    output$viz <- renderImteractive({
      img <- system.file("htmlwidgets/samples/colombia_map.svg", package = "imteractive")
      d <- data_frame(
        id = c("CO-SAP", "CO-LAG", "CO-CUN"),
        number = c(10,20, 30),
        text = c("C1","C2","C3"),
        color = c("#AA4032","#46FF32","#3490AA")
      )
      imteractive(img, d = d, debug = TRUE, maxWidth = 400,
                  clickable = TRUE, pointer = TRUE, modal = TRUE,
                  fill = input$color)
    })
  }
)
runApp(app)
