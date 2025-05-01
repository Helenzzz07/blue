#' @title Find Athlete URL
#' @description
#' Given an athlete's name, this function finds the athlete's results URL
#' from the results.csv file included in the blue package. It uses a case-insensitive
#' search and returns the URL if the athlete is found. Otherwise, it returns NA and issues a warning.
#' @param athlete_name A character string representing the name of the athlete whose
#'   results URL is to be retrieved.
#' @return
#' A character string representing the URL to the athlete's results. If not found, returns NA.
#' @details
#' This function checks the `results.csv` file in the installed `blue` package for a matching athlete
#' and retrieves their URL.
#' @examples
#' find_athlete_url("Michael Phelps")
#' find_athlete_url("Usain Bolt")
#' find_athlete_url("John Doe")  # This will return NA and issue a warning.
#' @seealso
#' `load_results()`
#' @importFrom utils read.csv
#' @importFrom stringr str_detect
#' @export
find_athlete_url <- function(athlete_name) {
  # Check if the results.csv file exists
  file_path <- system.file("results.csv", package = "blue")
  # Stop if the file is not found
  if (file_path == "") {
    stop("results.csv not found in the installed blue package.")
  }
  # Read the CSV file into a data frame
  data <- read.csv(file_path, stringsAsFactors = FALSE)
  # Match the row corresponding to the athlete's name (case-insensitive search)
  match_row <- data[str_detect(data$name, fixed(athlete_name, ignore_case = TRUE)), ]
  # If a match is found, return the URL; otherwise, issue a warning
  if (nrow(match_row) > 0) {
    return(match_row$url[1])  # Assuming the 'url' column contains the URLs
  } else {
    warning("Athlete '", athlete_name, "' not found.")
    return(NA)
  }
}

