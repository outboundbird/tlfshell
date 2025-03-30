# demo

template.demo <- function() {
  arms <- gen_grp("Treatment", c("SAR123", "Placebo"))
  gen_mtx(
    section_grp(arms, "n_title"),
    section_cat("BMI", c("Underweight", "Normal", "Overweight", "Obese"), arms),
    section_cat("Sex", c("Male", "Female"), arms),
    section_cat("Genotype", c("AA", "Aa", "aa"), arms),
    section_num("fAAT", arms),
    section_num("aAAT", arms)
  )
}

template.demo()


# change fro baseline

template.chg <- function() {
  arms <- gen_grp("Treatment", c("SAR123", "SAR345", "Placebo"))
  bsln <- section_num("Baseline", arms)
  wk24 <- section_num("Week 24", arms)
  chg <- section_chg("Change from Baseline to Week 24", "Placebo", arms)

  gen_mtx(
    section_grp(arms, "n_title"),
    bsln,
    wk24,
    chg
  )
}

template.chg()


# listing
template.lst <- function() {
  lobeloc <- gen_grp(
    "Lobe Location",
    c("RUA", "RML/RMM", "LS", "AVG", "RUA", "RML/RMM", "LS", "AVG"),
    units = rep("ng/mL", 8)
  )

  gen_mtx(
    section_grp(lobeloc, select = "unit"),
    section_num("fAAT", lobeloc),
    section_list("Patient", 10, lobeloc),
    col_groups = c(rep("", 4), "Baseline", rep("", 3), "Week 24")
  )
}

template.lst()

# PD