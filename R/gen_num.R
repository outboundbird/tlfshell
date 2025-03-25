# continous variable
gen_num <- function(var_name = "Biomarker", extra_setup = list(fmt = NULL, params = NULL)) {
  extra_fmt <- extra_setup$fmt
  extra_params <- extra_setup$params
  extra <- ifelse(is.null(extra_fmt) , 1, 2)
  basic_params <- c("N", "Mean (SD)", "Median", "Q1:Q3", "Min: Max")
  basic_fmts <- c(
    n_obs,
    mean.sd,
    numeric_fmt,
    ci95,
    ci95
  )
  table_text <- switch(extra,
    `1` = basic_fmts,
    `2` = c(basic_fmts, extra_fmt),
  )

  sum_params <- switch(as.character(extra),
    `1` = basic_fmts,
    `2` = c(basic_params, extra_params),
    "Invalid extra argument. Must be TRUE or FALSE."
  )

  structure(
    var_name,
    names = var_name,
    summary = sum_params,
    table_txt = table_text,
    type = "numeric"
  )
}
gen_num("fAAT")

gen_num("fAAT", extra_setup = list(
  fmt = c(numeric_fmt, numeric_fmt),
  params = c("Geometric Mean", "CV%")
))
gen_num("fAAT", extra_setup = list(
  fmt = c("####", "##**"),
  params = c("Geometric Mean", "CV%")
))

