# generate group with levels
#' @export gen_grp
gen_grp <- function(var_name, var_levels, units=NULL) {
  if(is.null(units)) {
    units <- rep("", length(var_levels))
  }
  group <- NA
  attr(group, "levels") <- var_levels
  attr(group, "names") <- var_name
  attr(group, "n_title") <- rep("N = ##", nlevels(group))
  attr(group, "unit") <- units
  group
}

arms <- gen_grp("Treatment", c("SAR1234", "Placebo"), rep("mg", 2))
attributes(arms)
