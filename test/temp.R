install.packages("flextable")

library(magrittr)
library(flextable)

# source R package

source("R/gen_num.R")
source("R/get_attr.R")

for(f in list.files("R",   full.names = TRUE)) {print(f); source(f)}

output <-   gen_mtx(
    section_grp(arms, "n_title"),
    section_cat("BMI", c("Underweight", "Normal", "Overweight", "Obese"), arms),
    section_cat("Sex", c("Male", "Female"), arms),
    section_cat("Genotype", c("AA", "Aa", "aa"), arms),
    section_num("fAAT", arms),
    section_num("aAAT", arms)
  )



names <- sapply(
    1:ncol(output),
    function(j) paste(output[1,j], output[2, j], sep = "\n")
)
names(output) <- names
output <- tibble::repair_names(output)

output <- flextable(output[-c(1,2),]) 

output <- bold(output, part = "header")

idx <- which(sapply(seq(2, nrow(output$body$dataset)),
    function(i) all(unlist(output$body$dataset[i,])[-1] == "")
))

output |>
    hline(idx) |>
    flextable::border( i = 1, border.bottom = fp_border_default(width = 1, 
            color = "#000000"), border.top = fp_border_default(width = 1, 
            color = "#000000"), border.left = fp_border_default(width = 0), 
            border.right = fp_border_default(width = 0), part = "header") |>

     flextable::fontsize(size = 10, part = "all") |>
    flextable::fontsize(size = 9, part = "footer")  |>
    flextable::font(fontname = "Arial Narrow", part = "footer") |>
    flextable::font(fontname = "Times New Roman", part = "body")
