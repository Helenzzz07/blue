find_athlete_url <- function(athlete_name) {

  file_path <- system.file("olympic_results.rda", package = "blue")

  if (file_path == "") {
    stop("results.csv not found in the installed blue package.")
  }


  match_row <- olympic_results[olympic_results$name == athlete_name, ]

  if (nrow(match_row) == 0) {
    warning("Athlete not found.")
    return(NA)
  }
  return(match_row$results_url)
}
