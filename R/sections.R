# use a bigger function or a class to generate tables
# write roxygen comments
#' Generate Numeric Section
#'
#' This function generates a section of numeric variables based on the provided variable name and group.
#'
#' @param varname A character string representing the variable name.
#' @param group A group object.
#' @return section content for numeric variables
#' @examples
#' arms <- gen_grp("Treatment", c("SAR1234", "ABC", "Placebo"))
#' section_num("fAAT", arms)
#' @export
section_num <- function(varname, group) {
  var <- gen_num(varname)
  mtx_num(var, group)
}


#' Create a Section for Categorical Variables
#'
#' This function generates a section for categorical variables in a report or analysis.
#'
#' @param varname A character string representing the name of the variable.
#' @param var_levels A vector of levels for the categorical variable.
#' @param group A group object.
#'
#' @return A structured section for the categorical variable.
#' @examples
#' section_cat("BMI", c("Underweight", "Normal", "Overweight", "Obese"), arms)
#' section_cat("Sex", c("Male", "Female"), arms)
#' @export
section_cat <- function(varname, var_levels, group) {
  var <- gen_cat(varname, var_levels)
  mtx_cat(var, group)
}


#' Generate a listing sections.
#'
#' This function creates a listing section using the provided variable name,
#' number of subjects, and group information.
#'
#' @param varname A character string representing the name of the variable.
#' @param n An integer specifying the number of items to generate.
#' @param group A group object.
#'
#' @return A listing section.
#' @export
#'
#' @examples
#' # generate listing for 3 sections for trial arm groups
#' section_list("Patient", 3, arms)
#' section_list("example_var", 5, group = c("A", "B", "C"))
section_list <- function(varname, n, group) {
  var <- gen_list(varname, n)
  mtx_list(var, group)
}




section_grp <- function(group, select = NULL) {
  mtx_grp(group, select = select)
}


#' Create a Change from baseline Section
#'
#' This function generates a section for comparing a variable across two time points.
#'
#' @param varname A character string specifying the name of the variable to analyze.
#' @param ref_grp A character string specifying the reference group for comparison.
#' @param group A group object.
#'
#' @return A section of change from baseline.
#' @export
#'
#' @examples
#' # Example usage:
#' section_chg("Change from baseline to Week 12", "SAR1234", arms)
section_chg <- function(varname, ref_grp, group) {
  var <- gen_chg(varname, ref_grp, group)
  mtx_chg(var, group)
}

