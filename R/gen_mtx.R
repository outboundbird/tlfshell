# bmk
mtx_num <- function(bmk, group) {
  bmk_attr <- get_attr(bmk)
  bmk_rows <- c(bmk_attr("names"), bmk_attr("summary"))
  bmk_cols <- matrix(
    rep(c(blanks, bmk_attr("table_txt")), nlevels(group)),
    ncol = nlevels(group)
  )
  cbind(bmk_rows, bmk_cols)
}

mtx_cat <- function(var, group){
  # var
  var_attr <- get_attr(var)
  vars_rows <- c(var_attr("names"), levels(var))
  var_cols <- matrix(
    rep(c(blanks, var_attr("table_txt")), nlevels(group)),
    ncol=nlevels(group))
  cbind(vars_rows, var_cols)
}

mtx_chg <- function(chg, group){
  chg_attr <- get_attr(chg)
  chg_rows <- c(chg_attr("names"), chg_attr("summary"))
  chg_cols <- matrix(
    rep(c(blanks, chg_attr("table_txt")), nlevels(group)),
    ncol = nlevels(group)
  )
  cbind(chg_rows, chg_cols)
}


mtx_grp <- function(group) {
  c(blanks, levels(group))
}


gen_mtx <- function(..., col_groups) {
  rbind(...) %>%
    data.frame() %>%
    setNames(col_groups)
}

# example
faat <- gen_num("fAAT")
aaat <- gen_num("aAAT")
bmi <- gen_cat("BMI", c("Underweight", "Normal", "Overweight", "Obese"))
sex <- gen_cat("Sex", c("Male", "Female"))
arms <- gen_grp("Treatment", c("SAR1234", "ABC","Placebo"))
faat_chg <- gen_chg("Change from baseline to Week 12", "SAR1234", arms)

part_num <- mtx_num(faat, arms)
part_aat <- mtx_num(aaat, arms)
part_cat <- mtx_cat(bmi, arms)
part_sex <- mtx_cat(sex, arms)
part_faatchg <- mtx_chg(faat_chg, arms)
col_groups <- mtx_grp(arms)
gen_mtx(part_num, part_aat, part_cat,part_sex, part_faatchg,col_groups = col_groups)
