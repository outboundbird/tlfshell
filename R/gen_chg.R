#' Generate Change from Baseline Variable
#'
#' This function calculates the change from baseline for a specified variable.
#'
#' @param varname A character string specifying the name of the variable to be generated.
#'   Defaults to "Change from baseline".
#' @param ref_grp A character vector specifying the reference group for comparison.
#'   Defaults to an empty character vector.
#' @param group A group object.
#' @importFrom magrittr %>%
#' @return A variable representing the change from baseline.
#' @export
#' @examples
#' # Example usage:
#' grp <- gen_grp("Treatment", c("SAR1234", "Placebo"))
#' gen_chg("Change from baseline", "SAR1234", grp)
gen_chg <- function(varname = "Change from baseline", ref_grp = character(), group) { # nolint
  stopifnot(class(group) == "group")
  chg_summary <- c("N", "Mean (SD)", "LS Mean (95% CI)")
  other_groups <- levels(group)[levels(group) != ref_grp]

  chg_compare_l <- lapply(other_groups, function(x) {
    c(paste0("LS Mean difference ",x ," vs. ", ref_grp), "95% CI", "p-value", blanks)
  })

  chg_compare <- do.call(c, chg_compare_l) %>%
    .[-length(.)]

  chg_compare_txt <- rep(c(mean.sd, ci95, pval, blanks), length(chg_compare_l))
  last <- length(chg_compare_txt)
  if (chg_compare_txt[last] == "") {
    chg_compare_txt <- chg_compare_txt[1:last - 1]
  }

  structure(
    varname,
    names = varname,
    summary = c(chg_summary, blanks, chg_compare),
    table_txt = c(
      n_obs, mean.sd, mean.sd, blanks,
      chg_compare_txt
    ),
    ref_grp = ref_grp,
    compare_grp = other_groups,
    type = "numeric"
  )
}

