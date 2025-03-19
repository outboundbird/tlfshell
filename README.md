# tlfshell
Automatically generate TLF tables and figures
https://pharmaverse.org/e2eclinical/tlg/

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

## Other R packages
- [R for Clinical Study Reports and Submission](https://r4csr.org/)
- [`tidytlg`](https://pharmaverse.github.io/tidytlg/main/articles/tidytlg.html)
- [TLG Catalog](https://insightsengineering.github.io/tlg-catalog/stable/)
- [Pharmaverse](https://pharmaverse.org/e2eclinical/tlg/)
- [Tables in Clinical Trials with R](https://rconsortium.github.io/rtrs-wg/)