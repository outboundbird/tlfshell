
#' Apply Text Styling
#'
#' This function applies styling to the table text based on the provided arguments.
#'
#' @param x A character vector or text input to be styled.
#' @param ... Additional arguments for styling options.
#'  - `font_size` (default = 10): The font size for the text.
#' - `header_font_size` (default = 10): The font size for the header text.
#'  - `footer_font_size` (default = 9): The font size for the footer text.
#'  - `footer_font` (default = "Arial Narrow"): The font for the footer text.
#'  - `body_font` (default = "Times New Roman"): The font for the body text.
#' @return A styled text object or character vector.
#' @export
#'
#' @examples
#' # Example usage:
#' tab <- data.frame(A= rep(c("A", "B"), 5), B = rep(c("C", "D"), 5))
#' output <- flextable(tab)
#' output %>%
#' text_styler(font_size = 12, body_font = "Arial Narrow")
text_styler <- function(x, ...) {
  stopifnot(class(x) == "flextable")

  params <- list(...)

  font_size <- get_kwargs("font_size", params, default = 10)
  header_font_size <- get_kwargs("header_font_size", params, default = 10)
  footer_font_size <- get_kwargs("footer_font_size", params, default = 9)
  footer_font <- get_kwargs("footer_font", params, default = "Arial Narrow")
  body_font <- get_kwargs("body_font", params, default = "Times New Roman")

  flextable::fontsize(x, size = font_size, part = "all") |>
    flextable::fontsize(size = header_font_size, part = "header") |>
    flextable::fontsize(size = footer_font_size, part = "footer") |>
    flextable::font(fontname = body_font, part = "header") |>
    flextable::font(fontname = footer_font, part = "footer") |>
    flextable::font(fontname = body_font, part = "body")
}
