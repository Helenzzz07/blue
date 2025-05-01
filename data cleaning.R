#' @title Clean Olympic Results Data
#' @description Cleans and standardizes the Olympic results data for consistent analysis.
#'
#' @param df A data.frame containing Olympic results.
#'
#' @return A cleaned data.frame with trimmed strings, standardized column names,
#'         and removed NA or duplicate rows.
#'
#' @export
clean_results_data <- function(df) {
  # Ensure required columns exist
  required_cols <- c("name", "country", "event", "result", "Event")
  missing_cols <- setdiff(required_cols, names(df))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
  }

  # Convert column names to lowercase
  names(df) <- tolower(names(df))

  # Trim whitespace in character columns
  df[] <- lapply(df, function(col) {
    if (is.character(col)) trimws(col) else col
  })

  # Remove rows with NA in key columns
  df <- df[complete.cases(df$name, df$event, df$result), ]

  # Remove duplicates
  df <- unique(df)

  # Optional: standardize country names or codes
  # df$country <- toupper(df$country)

  return(df)
}
