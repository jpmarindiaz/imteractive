#' imteractive
#' @import htmlwidgets
#' @export
imteractive <- function(img, d = NULL,
                        template = NULL,
                        styles = NULL,
                        width = NULL, height = NULL,...) {

  args <- list(...)

  img <- make_image(img, d = d)

  styles <- get_styles(styles)

  settings <- list(
    maxWidth = args$maxWidth,
    template = template,
    styles = styles,
    debug = TRUE,
    fill = TRUE,
    clickable = TRUE,
    pointer = TRUE,
    modal = TRUE
  )
  settings <- modifyList(settings, args)
  x <- list(
    image = img$image,
    type = img$type,
    data = d,
    settings = settings
  )
  if(!is.null(args$debug)) str(x)

  htmlwidgets::createWidget(
    name = "imteractive",
    x,
    width = width,
    height = height,
    package = 'imteractive',
    sizingPolicy = htmlwidgets::sizingPolicy(
      padding = 0,
      viewer.padding = 0,
      browser.fill = TRUE
    )
  )
}

#' Widget output function for use in Shiny
#'
#' @export
imteractiveOutput <- function(outputId, width = '100%', height = '500px'){
  shinyWidgetOutput(outputId, 'imteractive', width, height, package = 'imteractive')
}

#' Widget render function for use in Shiny
#'
#' @export
renderImteractive <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, imteractiveOutput, env, quoted = TRUE)
}
