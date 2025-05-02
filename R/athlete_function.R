#' Find Athlete's Results URL
#'
#' Returns the results URL for a given athlete from the olympic_results dataset.
#'
#' @param athlete_name A character string, the athlete's full name.
#' @return A character string: the URL to the athlete's results, or NA if not found.
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
