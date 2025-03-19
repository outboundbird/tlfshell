#' Generate Group Variable
#'
#' This function creates a group variable with specified levels and optional units.
#'
#' @param var_name A character vector specifying the name(s) of the variable(s).
#' @param var_levels A character vector specifying the levels of the variable.
#' @param units Optional. A character vector specifying the units of the variable.
#'
#' @return A group variable with the specified properties.
#' @export
#'
#' @examples
#' gen_grp(var_name = "Group", var_levels = c("A", "B", "C"))
#' gen_grp(var_name = "Temperature", var_levels = c("Low", "Medium", "High"), units = "Celsius")
#' arms <- gen_grp("Treatment", c("SAR1234","ABC", "Placebo"), rep("mg", 2))
#' attributes(arms)
#' class(arms)
gen_grp <- function(var_name = character(), var_levels = character(), units = NULL) {
  if (is.null(units)) {
    units <- rep("", length(var_levels))
  }
  structure(
    var_name,
    levels = var_levels,
    names = var_name,
    n_title = rep("N = ##", length(var_levels)),
    unit = units,
    class = "group"
  )
}
