library(tlfshell)
library(flextable)
library(dplyr)

arms <- gen_grp("Treatment", c("BIV020+SOC","SOC", "BIV020+SOC", "SOC"))
header_row <- c("Visit", "Cohort A",  "Cohort B")
# CH 50
ch50_d1pre <- section_num("CH50 D1 Pre-dose", arms)
ch50_d1pst1 <- section_num("CH50 D1 Post-dose", arms)
ch50_d2_7.prePP <- section_num("CH50 Week 1 D2-D7 Pre-plasmapheresis", arms)
ch50_d2_7.pstPP <- section_num(
  "CH50 Week 1 D2-D7 Post-plasmapheresis", arms,
  extra_setups = list(params = "N under LLOQ", fmt = count_fmt)
)
ch50_d2_7.pstsoi <- section_num("CH50 Week 1 D2-D7 1hr post-intervention ", arms)
ch50_d8_14.prePP <- section_num("CH50 Week 2 D8-D14 Pre-plasmapheresis", arms)
ch50_d8_14.pstPP <- section_num(
  "CH50 Week 2 D8-D14 Post-plasmapheresis", arms,
  extra_setups = list(params = "N under LLOQ", fmt = count_fmt)
)
ch50_d8_14.pstsoi <- section_num("CH50 Week 2 D8-D14 1hr post-intervention ", arms)

ch50_2w <- gen_mtx(
  section_grp(arms, "n_title"),
  ch50_d1pre,
  ch50_d1pst1,
  ch50_d2_7.prePP,
  ch50_d2_7.pstPP,
  ch50_d2_7.pstsoi,
  ch50_d8_14.prePP,
  ch50_d8_14.pstPP,
  ch50_d8_14.pstsoi
) %>%
data.frame()



table_ch50_2w <- flextable(ch50_2w) %>%
  delete_rows(1, part = "header") %>%
  add_header_row(values = header_row, colwidths = c(1, 2, 2)) %>%
  theme_booktabs() %>%
  empty_blanks() %>%
  hline(2) %>%
  hline(1, part = "header") %>%
  add_footer_lines("For the plasmapheresis performed in W1-W2 (BIVV020 + SOC arm only), complement classical pathway activity samples (CP and CH50) were collected before (within 1 hour) and after each plasmapheresis session (within 1 hour after PP; or specifically ≤1 h before BIVV020 IV supplemental dose administration) and at 1 h after BIVV020 supplemental dose start of infusion (±10 min). ; LLOQ – lower limit of quantification") %>%
  autofit() %>%
  text_styler()

# listing for the first two weeks
visits <-  c(
  "D1 Pre-dose",
  "D1 Post-dose",
  "Week1 D2-D7 Pre-plasmapheresis",
  "Week 1 D2-D7 Post-plasmapheresis",
  "Week 1 D2-D7 1hr post-intervention",
  "Week2 D8-D14 Pre-plasmapheresis",
  "Week2 D8-D14 Post-plasmapheresis",
  "Week2 D8-D14 1hr post-intervention"
)

lst <- gen_plain_list("Patient", 5,
  num_cols = visits,
  cat_cols = "Treatment", date_cols = c("Visit Date time")
)

listing_wk12 <- mtx_plain_list(lst) %>%
  data.frame(check.names = FALSE) %>%
  select(c("Patient", "Treatment", "Visit Date time"), everything())

list_wk12 <- flextable(listing_wk12) %>%
add_footer_lines("LLOQ - lower limit of quantification. Detection limit xx Eq/mL") %>%
  # autofit() %>%
  text_styler()



# week 4
ch50_d22 <- section_num("CH50 Week 4", arms)
ch50_d85 <- section_num("CH50 Week 13", arms)
ch50_d169 <- section_num("CH50 Week 25", arms)
ch50_d253 <- section_num("CH50 Week 37", arms)
ch50_d337 <- section_num("CH50 Week 49", arms)
ch50_ed <- section_num("CH50 End of Study", arms)
ch50_fu <- section_num("CH50 Follow-up", arms)

ch50_fu <- gen_mtx(
  section_grp(arms, "n_title"),
  ch50_d1pre,
  ch50_d22,
  ch50_d85,
  ch50_d169,
  ch50_d253,
  ch50_d337,
  ch50_ed
) %>%
  data.frame()

table_ch50_fu <- flextable(ch50_fu) %>%
  delete_rows(1, part = "header") %>%
  add_header_row(values = header_row, colwidths = c(1, 2, 2)) %>%
  theme_booktabs() %>%
  empty_blanks() %>%
  hline(2) %>%
  hline(1, part = "header") %>%
  add_footer_lines("For the plasmapheresis performed in W1-W2 (BIVV020 + SOC arm only), complement classical pathway activity samples (CP and CH50) were collected before (within 1 hour) and after each plasmapheresis session (within 1 hour after PP; or specifically ≤1 h before BIVV020 IV supplemental dose administration) and at 1 h after BIVV020 supplemental dose start of infusion (±10 min). ; LLOQ - lower limit of quantification") %>% #nolint
  autofit() %>%
  text_styler()

# CP

# change from baseline ---------------------------
arms_b <- gen_grp("Treatment", c("BIV020+SOC", "SOC"))
colhead <- data.frame(
  col_keys = paste0("X", 1:3),
  what = c(c(" ", levels(arms_b)))
)
chg_2w <- gen_mtx(
    section_chg("Change from baseline to Week 1 D2-D7 Post-plasmapheresis", "SOC", arms_b), #nolint
    section_chg("Change from baseline to Week 1 D2-D7 1hr post-intervention ", "SOC", arms_b), # nolint
    section_chg("Change from baseline to Week 2 D8-D14 Pre-plasmapheresis", "SOC", arms_b), #nolint
    section_chg("Change from baseline to Week 2 D8-D14 Post-plasmapheresis", "SOC", arms_b), # nolint
    section_chg("Change from baseline to Week 2 D8-D14 1hr post-intervention ", "SOC", arms_b) #nolint
) %>%
data.frame()


tab_chg_2w <- flextable(chg_2w) %>%
  set_header_df(mapping = colhead, key = 'col_keys') %>%
  theme_booktabs() %>%
  empty_blanks() %>%
  autofit() %>%
  add_footer_lines("Based on an ANCOVA model after adjusting baseline value. Values below detection limit were imputed with d/\U221A; ANCOVA = Analysis of Covariance, CI = Confidence Interval, LS = Least Squares, SD = Standard Deviation")  %>% #nolint
  # footnote(i=8*(1:5), j=1, ref_symbols = "\U002A",value = as_paragraph())
  text_styler()

chg_fu <- gen_mtx(
  section_chg("Change from baseline to Week 4", "SOC", arms_b),
  section_chg("Change from baseline to Week 13", "SOC", arms_b),
  section_chg("Change from baseline to Week 25", "SOC", arms_b),
  section_chg("Change from baseline to Week 37", "SOC", arms_b),
  section_chg("Change from baseline to Week 49", "SOC", arms_b)
) %>%
data.frame()

tab_chg_fu <- flextable(chg_fu) %>%
  set_header_df(mapping = colhead, key = 'col_keys') %>%
  theme_booktabs() %>%
  empty_blanks() %>%
  add_footer_lines("Based on an ANCOVA model after adjusting baseline value. Values below detection limit were imputed with d/\U221A; ANCOVA = Analysis of Covariance, CI = Confidence Interval, LS = Least Squares, SD = Standard Deviation")  %>% #nolint
  autofit() %>%
  text_styler()



# change in cohort A
arms_a <- gen_grp("Treatment", c("BIV020+SOC", "SOC"))

chg_2w_a <- gen_mtx(
  section_num(
    "Change from baseline to Week 1 D2-D7 Postdose", arms_a,
    extra_setups = list(params = "N under LLOQ", fmt = count_fmt)
  ),
  section_num(
    "Change from baseline to Week 1 D2-D7 Pre-plasmapheresis", arms_a,
    extra_setups = list(params = "N under LLOQ", fmt = count_fmt)
  ),
  section_num(
    "Change from baseline to Week 1 D2-D7 1hr Post-plasmapheresis", arms_a,
    extra_setups = list(params = "N under LLOQ", fmt = count_fmt)
  ),
  section_num(
    "Change from baseline to Week 1 D2-D7 1hr Post-intervention", arms_a,
    extra_setups = list(params = "N under LLOQ", fmt = count_fmt)
  ),
  section_num(
    "Change from baseline to Week 2 D8-D14 Pre-plasmapheresis", arms_a,
    extra_setups = list(params = "N under LLOQ", fmt = count_fmt)
  ),
  section_num(
    "Change from baseline to Week 2 D8-D14 1hr Post-plasmapheresis", arms_a,
    extra_setups = list(params = "N under LLOQ", fmt = count_fmt)
  ),
  section_num(
    "Change from baseline to Week 2 D8-D14 1hr Post-intervention", arms_a,
    extra_setups = list(params = "N under LLOQ", fmt = count_fmt)
  )
) %>%
  data.frame()

tab_chg_2w_a <- flextable(chg_2w_a) %>%
  set_header_labels(values = c("Visits", levels(arms_a))) %>%
  autofit() %>%
  add_footer_lines("Values below detection limit were imputed with d/\U221A 2; due the small sample size the test between two groups are not provided.") %>% #nolint
  theme_booktabs() %>%
  empty_blanks() %>%
  autofit() %>%
  text_styler()

ch_fu_a <- gen_mtx(
  section_num("Change from baseline to Week 4", arms_a),
  section_num("Change from baseline to Week 13", arms_a),
  section_num("Change from baseline to Week 25", arms_a),
  section_num("Change from baseline to Week 37", arms_a),
  section_num("Change from baseline to Week 49", arms_a)
) %>%
  data.frame()

tab_chg_fu <- flextable(ch_fu_a) %>%
  set_header_labels(values = c("Visits", levels(arms_a))) %>%
  autofit() %>%
  text_styler()


save_as_docx(
  `CH50 (Week 1-2)` = list_wk12,
  `CH50 (Week 4-49)` = table_ch50_fu,
  # `CP (Week 1-2)` = table_cp_2w,
  # `CP (Week 4-49)` = table_cp_fu,
  `CH50 Change from baseline cohort A (Week 1-2)` = tab_chg_2w_a,
  `CH50 Change from baseline cohort A (Week 4-49)` = tab_chg_fu,
  `CH50 Change from baseline Cohort B(Week 1-2)` = tab_chg_2w,
  `CH50 Change from baseline (Week 4-49)` = tab_chg_fu,
  # `CP Change from baseline (Week 1-2)` = tab_chg_2w,
  # `CP Change from baseline (Week 4-49)` = tab_chg_fu,
  path = "test/ch50.docx"
)

