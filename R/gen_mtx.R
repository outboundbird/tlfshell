#' Generate a Numeric Matrix Based on Biomarker and Group
#'
#' This function creates a numeric matrix using the provided biomarker (`bmk`)
#' and group information (`group`).
#'
#' @param bmk A vector or data structure representing the biomarker data.
#' @param group A group object indicating the group assignments.
#' @return A numeric matrix generated based on the input biomarker and group.
#' @examples
#' # Example usage:
#' # bmk <- c(1.2, 3.4, 5.6)
#' # group <- c("A", "B", "A")
#' # result <- mtx_num(bmk, group)
mtx_num <- function(bmk, group) {
  bmk_attr <- get_attr(bmk)
  bmk_rows <- c(bmk_attr("names"), bmk_attr("summary"))
  bmk_cols <- matrix(
    rep(c(blanks, bmk_attr("table_txt")), nlevels(group)),
    ncol = nlevels(group)
  )
  cbind(bmk_rows, bmk_cols)
}

mtx_cat <- function(var, group) {
  # var
  var_attr <- get_attr(var)
  vars_rows <- c(var_attr("names"), levels(var))
  var_cols <- matrix(
    rep(c(blanks, var_attr("table_txt")), nlevels(group)),
    ncol = nlevels(group)
  )
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


mtx_list <- function(list, group){
  list_attr <- get_attr(list)
  list_rows <- c(list_attr("names"), list_attr("id"))
  list_cols <- matrix(
    rep(c(blanks, list_attr("table_txt")), nlevels(group)),
    ncol = nlevels(group)
  )
  cbind(list_rows, list_cols)
}

#' Generate a Plain List Matrix
#'
#' This function takes a listing object and converts it into a plain matrix format.
#'
#' @param list A listing object to be converted into a matrix.
#' @return A matrix representation of the input list.
#' @examples
#' # Example usage:
#' lst <- gen_plain_list("Patient", 5,
#'   num_cols = c("Age", "Weight", "Height"),
#'   cat_cols = c("Sex", "BMI"), date_cols = c("DOB", "Visit")
#' )
#' mtx_plain_list(lst)
#' @export
mtx_plain_list <- function(list) {
  list_attr <- get_attr(list)
  list_rows <- c(list_attr("id"))
  col_names <- c(list_attr("names"), list_attr("col_names"))
  cols <- list( # keep the same order as in gen_plain_list
    list_attr("num_txt"), list_attr("cat_txt"), list_attr("date_txt")
  )

  list_cols <- Filter(length, cols) %>%
    do.call(cbind, .)
  mtx <- cbind(list_rows, list_cols)
  colnames(mtx) <- col_names
  mtx
}



mtx_grp <- function(group, select = NULL) {
  group_attr <- get_attr(group)
  subline <- group_attr(select)
  rbind(
    c(blanks, levels(group)),
    c(blanks, subline)
  )
}



#' Generate a Table Matrix
#'
#' This function generates a matrix based on the provided aruments.
#'
#' @param ... sections to be put in the table
#' @param col_groups A vector or list specifying header group. Defalt is `NULL`, which will leave table header empty.
#'
#' @return A matrix object generated based on the input parameters.
#' @export
gen_mtx <- function(..., col_groups =NULL){
  rbind(...) %>%
    data.frame() %>%
    setNames(col_groups)
}

# example
arms <- gen_grp("Treatment", c("SAR1234", "ABC","Placebo"))
faat <- gen_num("fAAT")
aaat <- gen_num("aAAT")
pt <- gen_list("Patient", 3)
bmi <- gen_cat("BMI", c("Underweight", "Normal", "Overweight", "Obese"))
sex <- gen_cat("Sex", c("Male", "Female"))
faat_chg <- gen_chg("Change from baseline to Week 12", "SAR1234", arms)

part_num <- mtx_num(faat, arms)
part_aat <- mtx_num(aaat, arms)
part_cat <- mtx_cat(bmi, arms)
part_sex <- mtx_cat(sex, arms)
part_faatchg <- mtx_chg(faat_chg, arms)
part_list <- mtx_list(pt, arms)
col_groups <- mtx_grp(arms, "n_title")
gen_mtx(
  col_groups, part_list, part_num, part_aat, part_cat, part_sex, part_faatchg
)
