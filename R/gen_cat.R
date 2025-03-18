# generate categorical data with levels
# SEX, F, M
gen_cat <- function(var_name, var_levels) {
  var <- NA
  attr(var, "levels") <- var_levels
  attr(var, "names") <- var_name
  attr(var, "table_txt") <- rep(count_fmt, nlevels(var))
  var
}

bmi <- gen_cat("BMI",c("Underweight", "Normal", "Overweight", "Obese"))
attributes(bmi)
