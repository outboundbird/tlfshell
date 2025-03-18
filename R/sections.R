# use a bigger function or a class to generate tables

section_num <- function(varname, group) {
  var <- gen_num(varname)
  mtx_num(var, group)
}

arms <- gen_grp("Treatment", c("SAR1234", "ABC","Placebo"))
section_num("fAAT", arms)

section_cat <- function(varname, var_levels, group) {
  var <- gen_cat(varname, var_levels)
  mtx_cat(var, group)
}

section_cat("BMI", c("Underweight", "Normal", "Overweight", "Obese"), arms)
section_cat("Sex", c("Male", "Female"), arms)

section_list <- function(varname, n, group) {
  var <- gen_list(varname, n)
  mtx_list(var, group)
}

section_list("Patient", 3, arms)

section_grp <- function(varname, var_levels, units = NULL, select = NULL) {
  var <- gen_grp(varname, var_levels, units)
  mtx_grp(var, select = select)
}

section_grp("Treatment", c("SAR1234", "ABC", "Placebo"),
units = rep("ng", 3), select = "unit")

# bug here see gen_chg to automate number of comparison groups
section_chg <- function(varname, ref_grp, group) {
  var <- gen_chg(varname, ref_grp, group)
  mtx_chg(var, group)
}

section_chg("Change from baseline to Week 12", "SAR1234", arms)
