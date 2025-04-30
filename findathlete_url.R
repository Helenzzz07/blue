#' @title Find Athlete URL
#' @description
#' This function finds an athlete's results URL in a case-insensitive manner from the
#' `results.csv` file bundled in the **blue** package. If multiple matches are found,
#' it returns the first and issues a warning.
#'
#' @param athlete_name A character string. The athlete’s name (case-insensitive).
#' @returns A character string containing the athlete’s results URL, or NA if not found.
#'
#' @examples
#' find_athlete_url("john doe")
#'
#' @importFrom utils read.csv
#' @export
find_athlete_url <- function(athlete_name) {
  results <- read.csv(system.file("extdata", "results.csv", package = "blue"))

  # Case-insensitive exact match
  row <- results[tolower(results$Name) == tolower(athlete_name), ]

  # Handle no match
  if (nrow(row) == 0) {
    return(NA_character_)
  }

  # Warn on multiple matches
  if (nrow(row) > 1) {
    warning("Multiple matches found; returning the first.")
  }

  return(as.character(row$URL[1]))
}
