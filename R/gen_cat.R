#' Generate a Categorical Variable Object
#'
#' This function generates a categorical variable object with specified levels.
#'
#' @param var_name A character string specifying the name of the variable.
#' @param var_levels A vector of levels for the categorical variable.
#'
#' @return A categorical variable with the specified levels.
#' @export
#' @examples
#' gen_cat("gender", c("male", "female"))
#' bmi <- gen_cat("BMI", c("Underweight", "Normal", "Overweight", "Obese"))
#' attributes(bmi)
gen_cat <- function(var_name, var_levels) {
  structure(var_name,
    levels = var_levels,
    names = var_name,
    table_txt = rep(count_fmt, length(var_levels))
  )
}
