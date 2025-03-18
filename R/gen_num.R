# continous variable
# bmk
gen_num <- function(var_name = "Biomarker") {
  bmk <- NA
  attr(bmk, "names") <- var_name
  attr(bmk, "summary") <- c("N", "Mean (SD)", "Median", "Q1:Q3", "Min: Max")
  attr(bmk, "table_txt") <- c(
    "#",
    "##.## (##.##)",
    "##.##",
    "##.##: ##.##",
    "##.##: ##.##"
  )
  attr(bmk, "type") <- "numeric"
  bmk
}
aat <- gen_num('fAAT')
attributes(aat)
