# continous variable
gen_num <- function(var_name = "Biomarker") {
  structure(
    var_name,
    names = var_name,
    summary = c("N", "Mean (SD)", "Median", "Q1:Q3", "Min: Max"),
    table_txt = c(
      n_obs,
      mean.sd,
      numeric_fmt,
      ci95,
      ci95
    ),
    type = "numeric"
  )
}
aat <- gen_num('fAAT')
attributes(aat)
