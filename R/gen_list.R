# generate listing
gen_list <- function(var_name = "Patient", n) {
  n_pt <- n
  pt <- NA
  attr(pt, "names") <- var_name
  attr(pt, "id") <- rep(subjid, n_pt)
  attr(pt, "table_txt") <- rep(numeric_fmt, n_pt)
  attr(pt, "type") <- "numeric"
  pt
}

gen_list("Patient", 2)
