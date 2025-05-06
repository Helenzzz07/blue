#' @title Load Olympic Results
#' @description
#' This function loads the Olympic results data from the BLUE JSON API and
#' stores it in a `data.frame` for further analysis.
#'
#' @param api_url The URL of the BLUE API endpoint to retrieve the results from.
#' @param year The year of the Olympic Games (default is 2024).
#'
#' @return
#' A `data.frame` containing the Olympic results data. The data will include details
#'   such as athlete names, events, and results.
#'
#' @details
#' The function makes a GET request to the specified `api_url` and processes the returned
#' JSON data into a `data.frame`. The default year is set to 2024, but users can specify
#' a different year if needed.
#'
#' @examples
#' # Load results for 2024 Olympics:
#' results <- load_results("https://api.blue.com/olympics", year = 2024)
#'
#' # Load results for another year (e.g., 2020 Olympics):
#' results_2020 <- load_results("https://api.blue.com/olympics", year = 2020)
#'
#' @seealso
#' `find_athlete_url()`
#'
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @export
load_results <- function(api_url, year = 2024) {
  # Construct the full URL for the API request
  full_url <- paste0(api_url, "?year=", year)

  # Make a GET request to fetch the data
  response <- GET(full_url)

  # Check if the request was successful
  if (status_code(response) != 200) {
    stop("Failed to retrieve data from the API. Status code: ", status_code(response))
  }

  # Parse the JSON content from the response
  results_data <- fromJSON(content(response, "text"))

  # Convert the results into a data frame
  results_df <- as.data.frame(results_data)

  return(results_df)
}


