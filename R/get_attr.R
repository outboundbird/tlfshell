#' Get Attribute from an Object
#'
#' This is cloture function to generate a function that retrieves a specific attribute from a given object.
#'
#' @param x An object from which the attribute will be retrieved.
#' @return The value of the attribute if it exists, or `NULL` if the attribute is not found.
#' @export
#' @examples
#' obj <- structure(1:5, my_attr = "example")
#' get_attr(obj) # Retrieves the "my_attr" attribute
get_attr <- function(x){
  function(name){
    attr(x, name)
  }
}

