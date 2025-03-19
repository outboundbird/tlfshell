# generate listing
gen_list <- function(var_name = "Patient", n) {
  structure(
    var_name,
    names = var_name,
    id = rep(subjid, n),
    table_txt = rep(numeric_fmt, n),
    type = "listing"
  )
}

gen_list("Patient", 3)

gen_plain_list <- function(
    var_name = "Patient", n, num_cols = NULL, cat_cols = NULL, date_cols = NULL) { # nolint
  col_num <- length(num_cols)
  col_cat <- length(cat_cols)
  col_date <- length(date_cols)
  structure(
    var_name,
    names = var_name,
    col_names = c(num_cols, cat_cols, date_cols),
    id = rep(subjid, n),
    num_txt = matrix(rep(numeric_fmt, n*col_num ), ncol = col_num),
    cat_txt = matrix(rep("xx",  n*col_cat), ncol = col_cat),
    date_txt = matrix(rep(date.time, col_date * n), ncol = col_date),
    type = "listing"
  )
}
lst <- gen_plain_list("Patient", 5,
  num_cols = c("Age", "Weight", "Height"),
  cat_cols = c("Sex", "BMI"), date_cols = c("DOB", "Visit")
)
