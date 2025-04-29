find_athlete_url <- function(athlete_name) {

  file_path <- system.file("results.csv", package = "blue")

  if (file_path == "") {
    stop("results.csv not found in the installed blue package.")
  }


  data <- read.csv(file_path, stringsAsFactors = FALSE)


  match_row <- data[data$name == athlete_name, ]

  if (nrow(match_row) == 0) {
    warning("Athlete not found.")
    return(NA)
  }
  return(match_row$results_url)
}

athlete_data <- data[data$name == athlete_name, ]
