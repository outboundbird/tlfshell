install.packages("flextable", dependencies = TRUE)

library(magrittr)
library(flextable)

# source R package

source("R/gen_num.R")
source("R/get_attr.R")


for(f in list.files("R",   full.names = TRUE)) {print(f); source(f)}

visit <- gen_grp(
    var_name = "Visit",
    var_levels = c(
        "Screening", "W24 (D2168)",
        "Screening", "W24 (D2168)",
        "Screening", "W24 (D2168)"
    )
)
section_grp(visit, "n_title")

arms <- gen_grp("Treatment", c("SAR1234", "ABC", "Placebo"))
section_grp(arms)

output <- gen_mtx(
    section_grp(visit),
    section_list("Patients", 5, visit),
    section_num("Summary", visit)
)

trt <- names(output) <- c(
    " ",
    "", "SAR447537 120mg/kg",
    "", "SAR447537",
    "", "Zemaira 60mg/kg QD"
)
# names <- sapply(
#     1:ncol(output),
#     function(j) paste(output[1,j], output[2, j], sep = "\n")
# )
names(output) <- trt
output <- tibble::repair_names(output)

# output <- flextable(output[-c(1, 2), ])
output <- flextable(output)
output <- bold(output, part = "header")

idx <- which(sapply(seq(2, nrow(output$body$dataset)),
    function(i) all(unlist(output$body$dataset[i,])[-1] == "")
))

 output <- output |>
    flextable::hline(idx) |>
    flextable::border(
         i = 1,
        border.bottom = fp_border_default(
            width = 1,
            color = "#000000"
        ),
        border.top = fp_border_default(
            width = 1,
            color = "#000000"
        ),
        border.left = fp_border_default(width = 0),
        border.right = fp_border_default(width = 0), part = "header"
    ) |>
    flextable::fontsize(size = 10, part = "all") |>
    flextable::fontsize(size = 9, part = "footer")  |>
    flextable::font(fontname = "Arial Narrow", part = "footer") |>
    flextable::font(fontname = "Times New Roman", part = "body")

save_as_docx(output, "Individual and summary of serum urea concentration.docx", path = "test.docx")
