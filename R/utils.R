
#' Get value returned from a R process and set the default return value if
#' nothing is returned
#'
#' @param x any R object.
#' @param default object returned if x is empty.
#'
#' @return either x or default value
#' @export
#' @examples
#' # ADD_EXAMPLES_HERE
#' retrive(NA, 1)
retrive <- function(x, default = "") {
  if (any(is.na(x), is.null(x), x == "")) {
    return(default)
  }
  x
}


#' get keyword argument values
#'
#' retreive the value from of list of key word arguments
#'
#' @param kwarg char with length of 1.
#' @param kwargs list object, usually passed from ...in a function.
#' @param default default value if no matching. default is NULL.
#'
#' @return value of either matched argument or default value if no match.
#' @export
#' @examples
#' # foo <- function(...){
#'   params <- list(...)
#'   c <- get_kwargs("c", params, NULL)
#'   d <- get_kwargs("d", params, NULL)
#'   print(c)
#'   print(d)
#' }
#' foo(a = 1,c=4 ,b=2)

get_kwargs <- function(kwarg, kwargs, default = NULL) {
  stopifnot(is.character(kwarg))
  stopifnot(is.list(kwargs))
  pos <- match(kwarg, names(kwargs))
  if (!is.na(pos)) {
    return(kwargs[[pos]])
  }
  default
}


#' Remove Empty Elements from a Vector
#'
#' This function removes empty elements (e.g., `""`) from a character vector.
#'
#' @param x A character vector from which empty elements should be removed.
#' @return A character vector with empty elements removed.
#' @examples
#' rm_empty(c("a", "", "b", ""))
#' # [1] "a" "b"
#' @export
rm_empty <- function(x) {
  x[x != ""]
}
