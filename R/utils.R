
fct_to_chr <- function(d) map_if(d,is.factor,as.character) %>% as_data_frame
num_to_chr <- function(d) map_if(d,is.numeric,as.character) %>% as_data_frame



make_dft_tpl <- function(d, rowSep = "\n", exclude = NULL){
  nms <- names(d)
  if(!is.null(exclude)) nms <- nms[!nms %in% exclude]
  tpl <- unlist(lapply(names(d),function(nm){
    paste0(nm,": ","{",nm,"}")
  }))
  paste(tpl, collapse=rowSep)
}

str_tpl_format <- function(tpl, l){
  if("list" %in% class(l)){
    listToNameValue <- function(l){
      mapply(function(i,j) list(name = j, value = i), l, names(l), SIMPLIFY = FALSE)
    }
    f <- function(tpl,l){
      gsub(paste0("{",l$name,"}"), l$value, tpl, fixed = TRUE)
    }
    return( Reduce(f,listToNameValue(l), init = tpl))
  }
  if("data.frame" %in% class(l)){
    myTranspose <- function(x) lapply(1:nrow(x), function(i) lapply(l, "[[", i))
    return( unlist(lapply(myTranspose(l), function(l, tpl) str_tpl_format(tpl, l), tpl = tpl)) )
  }
}

# file_ext <- function (x){
#   pos <- regexpr("\\\\.([[:alnum:]]+)$", x)
#   ifelse(pos > -1L, substring(x, pos + 1L), "")
# }

#https://stackoverflow.com/questions/7779037/extract-file-extension-from-file-path
file_ext <- function (fn) {
  # remove a path
  splitted    <- strsplit(x=fn, split='/')[[1]]
  # or use .Platform$file.sep in stead of '/'
  fn          <- splitted [length(splitted)]
  ext         <- ''
  splitted    <- strsplit(x=fn, split='\\.')[[1]]
  l           <-length (splitted)
  if (l > 1 && sum(splitted[1:(l-1)] != ''))  ext <-splitted [l]
  # the extention must be the suffix of a non-empty name
  ext
}

#' @export
`%||%` <- function (x, y)
{
  if (is.empty(x))
    return(y)
  else if (is.null(x) || is.na(x))
    return(y)
  else if (class(x) == "character" && nchar(x) == 0)
    return(y)
  else x
}

is.empty <- function (x)
{
  !as.logical(length(x))
}
