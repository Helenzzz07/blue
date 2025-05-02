## code to prepare `data` dataset goes here
#'@title Olympic Race Walk Results
#'
#' @format A data frame with the following columns:
#' \describe{
#'   \item{local_time}{The local time at which the athlete competed in the event round.}
#'   \item{sex}{The sex of the athlete ("W" for women; "M" for men).}
#'   \item{event}{The name of the event in which the athlete competed.}
#'   \item{round}{The name of the round in which the athlete competed.}
#'   \item{startlist_url}{The URL of the round startlist.}
#'   \item{results_url}{The URL of the round results.}
#'   \item{summary_url}{The URL of the round summary.}
#'   \item{points_url}{The URL of the round points.}
#'   \item{pos}{The final placement of the athlete in the round (e.g., "1" if they placed first).}
#'   \item{bib}{The number on the athlete's bib during the round.}
#'   \item{name}{The athlete's name with surname in all caps (e.g., "Jane DOE" for Jane Doe).}
#'   \item{country}{A three-letter acronym representing the athlete's country (e.g., "JPN").}
#'   \item{mark}{The athlete's mark during the round, i.e., their best time or score.}
#' }
#' @source \url{https://github.com/Kaggle/kagglehub/blob/main/README.md#kaggledatasetadapterpandas}
"olympic_results"

usethis::use_data(data, overwrite = TRUE)
olympic_results <- read.csv("results.csv", stringsAsFactors = FALSE)
usethis::use_data(olympic_results, overwrite = TRUE)

