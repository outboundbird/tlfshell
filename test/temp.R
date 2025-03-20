library(magrittr)
library(flextable)

install.packages("flextable")
source("R/gen_num.R")
source("R/get_attr.R")
for(f in list.files("R",   full.names = TRUE)) {print(f); source(f)}

  gen_mtx(

    section_grp(arms, "n_title"),
    section_cat("BMI", c("Underweight", "Normal", "Overweight", "Obese"), arms),
    section_cat("Sex", c("Male", "Female"), arms),
    section_cat("Genotype", c("AA", "Aa", "aa"), arms),
    section_num("fAAT", arms),
    section_num("aAAT", arms)
  )
