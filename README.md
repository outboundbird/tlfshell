# tlfshell
Automatically generate TLF tables and figures
https://pharmaverse.org/e2eclinical/tlg/

[TLG catalog](https://insightsengineering.github.io/tlg-catalog/stable/tables/lab-results/lbt01.html)
## to do
### Listing
- biomarker listing
### Tables
Descriptives
- demographic
- dosage groups: baseline, follow-up, change from baseline
- tissue site groups + dose group:

examples:
```r
  gen_mtx(
    section_grp(arms, "n_title"),
    section_cat("BMI", c("Underweight", "Normal", "Overweight", "Obese"), arms),
    section_cat("Sex", c("Male", "Female"), arms),
    section_cat("Genotype", c("AA", "Aa", "aa"), arms),
    section_num("fAAT", arms),
    section_num("aAAT", arms)
  )
```

There are severa templates available for illustration:
```r
# demographic table
template.demo()
# change from baseline table
template.chg()
# listing table
template.lst()
```