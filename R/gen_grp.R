# generate group with levels
gen_grp <- function(var_name, var_levels){
  group <- NA
  attr(group, "levels") <- var_levels
  attr(group, "names") <- var_name
  attr(group, "n_title") <- rep("N = ##", nlevels(group))
  group
}

arms <- gen_grp("Treatment", c("SAR1234", "Placebo"))
attributes(arms)
