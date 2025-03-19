# Unit tests for sections.R

# Load necessary libraries and source files
library(testthat)
source("R/sections.R")
source("R/gen_num.R")
source("R/gen_cat.R")
source("R/gen_list.R")
source("R/gen_grp.R")
source("R/gen_chg.R")
source("R/gen_mtx.R")
source("R/get_attr.R")
source("R/format_dummy.R")

# Test section_num
test_that("section_num generates correct matrix", {
  arms <- gen_grp("Treatment", c("SAR1234", "ABC", "Placebo"))
  result <- section_num("fAAT", arms)

  # Check dimensions
  expect_equal(nrow(result), 3)
  expect_equal(ncol(result), 4)

  # Check column names (first column is row names)
  expect_equal(colnames(result)[1], "")
  expect_equal(colnames(result)[2:4], c("SAR1234", "ABC", "Placebo"))

  # Check row names
  expect_equal(result[1,1], "fAAT")
  expect_equal(result[2,1], "N")
  expect_equal(result[3,1], "Mean (SD)")

  # Check content (can be more specific if needed)
  expect_true(all(result[1, 2:4] == ""))
  expect_true(all(result[2:3, 2:4] %in% c(count_fmt, mean.sd)))
})

# Test section_cat
test_that("section_cat generates correct matrix", {
  arms <- gen_grp("Treatment", c("SAR1234", "ABC", "Placebo"))
  result <- section_cat("BMI", c("Underweight", "Normal", "Overweight", "Obese"), arms)

  # Check dimensions
  expect_equal(nrow(result), 5)
  expect_equal(ncol(result), 4)

  # Check column names
  expect_equal(colnames(result)[1], "")
  expect_equal(colnames(result)[2:4], c("SAR1234", "ABC", "Placebo"))

  # Check row names
  expect_equal(result[1,1], "BMI")
  expect_equal(result[2:5,1], c("Underweight", "Normal", "Overweight", "Obese"))

  # Check content
  expect_true(all(result[1, 2:4] == ""))
  expect_true(all(result[2:5, 2:4] %in% count_fmt))

  result2 <- section_cat("Sex", c("Male", "Female"), arms)
  expect_equal(nrow(result2), 3)
  expect_equal(ncol(result2), 4)
  expect_equal(result2[1,1], "Sex")
  expect_equal(result2[2:3,1], c("Male", "Female"))
  expect_true(all(result2[1, 2:4] == ""))
  expect_true(all(result2[2:3, 2:4] %in% count_fmt))
})

# Test section_list
test_that("section_list generates correct matrix", {
  arms <- gen_grp("Treatment", c("SAR1234", "ABC", "Placebo"))
  result <- section_list("Patient", 3, arms)

  # Check dimensions
  expect_equal(nrow(result), 4)
  expect_equal(ncol(result), 4)

  # Check column names
  expect_equal(colnames(result)[1], "")
  expect_equal(colnames(result)[2:4], c("SAR1234", "ABC", "Placebo"))

  # Check row names
  expect_equal(result[1,1], "Patient")
  expect_equal(result[2:4,1], c("1", "2", "3"))

  # Check content
  expect_true(all(result[1, 2:4] == ""))
  expect_true(all(result[2:4, 2:4] %in% subjid))
})

# Test section_grp
test_that("section_grp generates correct matrix", {
  result <- section_grp("Treatment", c("SAR1234", "ABC", "Placebo"),
                        units = rep("ng", 3), select = "unit")

  # Check dimensions
  expect_equal(nrow(result), 2)
  expect_equal(ncol(result), 4)

  # Check column names
  expect_equal(colnames(result)[1], "")
  expect_equal(colnames(result)[2:4], c("SAR1234", "ABC", "Placebo"))

  # Check row names
  expect_equal(result[1,1], "")
  expect_equal(result[2,1], "")

  # Check content
  expect_true(all(result[1, 2:4] == c("SAR1234", "ABC", "Placebo")))
  expect_true(all(result[2, 2:4] == c("ng", "ng", "ng")))

  result2 <- section_grp("Treatment", c("SAR1234", "ABC", "Placebo"), select = "n_title")
  expect_equal(nrow(result2), 2)
  expect_equal(ncol(result2), 4)
  expect_equal(result2[1,1], "")
  expect_equal(result2[2,1], "")
  expect_true(all(result2[1, 2:4] == c("SAR1234", "ABC", "Placebo")))
  expect_true(all(result2[2, 2:4] == "n_title"))
})

# Test section_chg
test_that("section_chg generates correct matrix", {
  arms <- gen_grp("Treatment", c("SAR1234", "ABC", "Placebo"))
  result <- section_chg("Change from baseline to Week 12", "SAR1234", arms)

  # Check dimensions
  expect_equal(nrow(result), 7)
  expect_equal(ncol(result), 4)

  # Check column names
  expect_equal(colnames(result)[1], "")
  expect_equal(colnames(result)[2:4], c("SAR1234", "ABC", "Placebo"))

  # Check row names
  expect_equal(result[1,1], "Change from baseline")
  expect_equal(result[2,1], "N")
  expect_equal(result[3,1], "LS Mean (SE)")
  expect_equal(result[4,1], "95% CI")
  expect_equal(result[5,1], "")
  expect_equal(result[6,1], "LS Mean difference (SE) vs. ABC")
  expect_equal(result[7,1], "LS Mean difference (SE) vs. Placebo")

  # Check content
  expect_true(all(result[1, 2:4] == ""))
  expect_true(all(result[2, 2:4] %in% count_fmt))
  expect_true(all(result[3, 2:4] %in% mean.sd))
  expect_true(all(result[4, 2:4] %in% ci95))
  expect_true(all(result[5, 2:4] == ""))
  expect_true(all(result[6, 2:4] %in% c(mean.sd, ci95, pval, blanks)))
  expect_true(all(result[7, 2:4] %in% c(mean.sd, ci95, pval, blanks)))
})
