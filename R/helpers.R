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

get_styles <- function(styles){
    dft_styles <- "
body {
  margin: 0;
  position: fixed;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
}

#modal {
position: fixed;
left: 150px;
top: 20px;
z-index: 1;
background: white;
border: 1px black solid;
box-shadow: 10px 10px 5px #888888;
display: none;
}

#content {
max-height: 400px;
overflow: auto;
}

#modalClose {
position: absolute;
top: -0px;
right: -0px;
z-index: 1;
}

.clickable {
cursor: pointer;
}

svg image {
opacity: 0.5;
transition: 1s opacity;
}

svg:hover image {
opacity: 1;
}
"
  if(is.null(styles))
    return(dft_styles)
  paste(dft_styles, styles,collapse = "\n")
}


