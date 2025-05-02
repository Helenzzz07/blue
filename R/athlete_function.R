#' @title Find Athlete URL
#'
#' @description
#' Given an athlete's full name, this function retrieves the results URL from the
#' `olympic_results` dataset included in the `blue` package. It performs an exact match on the name,
#' and returns the first matching URL. If no match is found, it returns `NA` and issues a warning.
#' @param athlete_name A character string representing the full name of the athlete whose
#' results URL is to be retrieved.
#'
#' @return A character string containing the URL to the athlete's results. If the athlete is not found, returns `NA`.
#'
#' @details
#' The function uses the `olympic_results.rda` dataset (saved with `usethis::use_data()`) as the lookup source.
#' This is the preferred method for accessing embedded package data rather than reading from a raw CSV file.
#'
#' @examples
#' find_athlete("Álvaro MARTÍN")
#' find_athlete("Massimo STANO")
#' find_athlete("Jane Doe")  # Will return NA and issue a warning

#' @export

find_athlete <- function(athlete_name) {
  # Load the embedded dataset (stored as .rda)
  data("olympic_results", package = "blue")

  # Search for an exact match
  match_row <- olympic_results[olympic_results$name == athlete_name, ]

  if (nrow(match_row) == 0) {
    warning("Athlete not found.")
    return(NA)
  }

  return(match_row$results_url)
}
