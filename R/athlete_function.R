#' @title Find Athlete Results URL
#'
#' @description
#' Given an athlete's name, this function finds their results URL from the
#' `olympic_results` dataset.
#'
#' @param athlete_name A character string representing the athlete's full name.
#' @return A character string with the URL of the athlete's results, or NA if not found.
#'
#' @examples
#' find_athlete("Álvaro MARTÍN")
#' find_athlete("Usain BOLT")
#' find_athlete("Unknown Athlete")
#'
#' @export
find_athlete <- function(athlete_name) {
  data("olympic_results", package = "blue")
  match_row <- olympic_results[olympic_results$name == athlete_name, ]
  if (nrow(match_row) == 0) {
    warning("Athlete not found.")
    return(NA)
  }
  return(match_row$results_url)
}


#' @title Plot Top 10 Athletes in Original Time Format
#'
#' @description
#' For a given event, this function shows the top 10 fastest athletes
#' based on their raw `mark` times (cleaned to remove non-numeric parts),
#' and plots a bar chart with their original time strings.
#'
#' @param event_name A character string, the event to plot.
#' @return A ggplot2 plot object.
#'
#' @examples
#' plot_event_top10("20 Kilometres Race Walk")
#'
#' @importFrom dplyr filter mutate arrange slice
#' @importFrom stringr str_trim str_detect str_split str_extract fixed
#' @importFrom ggplot2 ggplot aes geom_col geom_text labs theme_minimal theme element_text
#' @export
plot_event_top10 <- function(event_name) {
  data("olympic_results", package = "blue")

  library(dplyr)
  library(stringr)
  library(ggplot2)

  # Helper: convert to numeric for sorting
  extract_numeric <- function(mark) {
    mark <- str_trim(mark)
    if (str_detect(mark, ":")) {
      parts <- str_split(mark, ":")[[1]]
      nums <- as.numeric(str_extract(parts, "\\d+"))
      if (length(nums) == 2) return(nums[1]*60 + nums[2])
      if (length(nums) == 3) return(nums[1]*3600 + nums[2]*60 + nums[3])
      return(NA_real_)
    }
    as.numeric(str_extract(mark, "^[0-9]+\\.?[0-9]*"))
  }

  clean_data <- olympic_results %>%
    filter(str_detect(event, fixed(event_name, ignore_case = TRUE))) %>%
    mutate(
      numeric_mark = sapply(mark, extract_numeric),
      display_mark = str_trim(str_extract(mark, "[0-9:\\.]+"))
    ) %>%
    filter(!is.na(numeric_mark)) %>%
    arrange(numeric_mark) %>%
    slice(1:5)

  if (nrow(clean_data) == 0) {
    warning("No valid data found for event: ", event_name)
    return(NULL)
  }

  # Plot
  ggplot(clean_data, aes(x = reorder(name, numeric_mark), y = numeric_mark)) +
    geom_col(fill = "steelblue") +
    geom_text(aes(label = display_mark), vjust = -0.5, size = 3.5) +
    scale_y_continuous(
      labels = function(x) {
        ifelse(x >= 60,
               sprintf("%d:%02d", floor(x / 60), round(x %% 60)),
               sprintf("%.2f", x))
      },
      expand = expansion(mult = c(0, 0.1))
    ) +
    labs(
      title = paste("Top 5 Fastest Athletes in", event_name),
      x = "Athlete",
      y = "Performance"
    ) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}
