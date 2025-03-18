gen_chg <- function(varname, ref_grp, group) {
  chg <- NA
  ref <- ref_grp
  chg_summary <- c("N", "LS Mean (SE)", "95% CI")
  other_groups <- levels(group)[levels(group) != ref]

  chg_compare_l <- lapply(other_groups, function(x) {
    c(paste0("LS Mean difference (SE) vs. ", x), "95% CI", "p-value", blanks)
  })

  chg_compare <- do.call(c, chg_compare_l) %>%
    .[-length(.)]

  chg_compare_txt <- rep(c(mean.sd, ci95, pval, blanks), length(chg_compare_l))
  last <- length(chg_compare_txt)
  if(chg_compare_txt[last]=='') chg_compare_txt <- chg_compare_txt[1:last-1]
  attr(chg, "names") <- "Change from baseline"
  attr(chg, "summary") <- c(chg_summary, blanks, chg_compare)
  attr(chg, "table_txt") <- c(
    count_fmt, mean.sd, ci95, blanks,
    chg_compare_txt
  )
  attr(chg, "type") <- "numeric"
  chg
}

grp <- gen_grp("Treatment", c("SAR1234", "Placebo"))
gen_chg("Change from baseline", "SAR1234", grp)
