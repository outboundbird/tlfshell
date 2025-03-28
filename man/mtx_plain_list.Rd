% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gen_mtx.R
\name{mtx_plain_list}
\alias{mtx_plain_list}
\title{Generate a Plain List Matrix}
\usage{
mtx_plain_list(list)
}
\arguments{
\item{list}{A listing object to be converted into a matrix.}
}
\value{
A matrix representation of the input list.
}
\description{
This function takes a listing object and converts it into a plain matrix format.
}
\examples{
# Example usage:
lst <- gen_plain_list("Patient", 5,
  num_cols = c("Age", "Weight", "Height"),
  cat_cols = c("Sex", "BMI"), date_cols = c("DOB", "Visit")
)
mtx_plain_list(lst)
}
