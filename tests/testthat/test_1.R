context("images")

test_that("Prep Images",{

  #svg
  img <- system.file("htmlwidgets/samples/cocina.svg", package = "imteractive")
  make_image(img)
  imteractive(img)

  #png
  img <- system.file("htmlwidgets/samples/cocina.png", package = "imteractive")
  d <- data_frame(
    x = c(10,20),
    y = c(50,90)
  )
  data <- make_image(img, d = d)


  })
