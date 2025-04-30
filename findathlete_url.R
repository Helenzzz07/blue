#' @title Find Athlete URL
#' @description
#' Given an athlete's name, this function finds the athlete's results URL
#' from the results.csv file included in the blue package.
#'
#' @param athlete_name A character string specifying the athlete's name.
#' @return The URL (as a string) to the athlete's results, or NA if not found.
#' @importFrom utils read.csv
#' @export
find_athlete_url <- function(athlete_name) {
  results <- read.csv(system.file("extdata", "results.csv", package = "blue"))
  row <- results[results$Name == athlete_name, ]
  if (nrow(row) == 0) {
    return(NA)
  } else {
    return(row$URL[1])
  }
}
