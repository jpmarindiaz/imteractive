make_image <- function(img, d = NULL){
  if(!file.exists(img)) stop("image not found")
  ext <- file_ext(img)
  type <- ifelse(ext %in% c("png","jpg","jpeg"), "image",ifelse(ext == "svg", "vector", NULL))
  if(is.null(type))
    stop("Supported image files are png, jpg, jpeg, svg")

  if(type == "image"){
    if(is.null(d))
      stop("for non vector images please provide the positions of the clickable area")
    if(!all(c("x","y") %in% names(d)))
      stop("need to provide x and y coordinates of clickable area")
    image <- image_uri(img)
  }
  if(type == "vector"){
    image <- paste(readLines(img),collapse = "\n")
  }
  list(type = type, image = image)
}
