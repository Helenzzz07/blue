#' @title Find Athlete Results URL
#'
#' @description
#' Given an athlete's name, this function finds their results URL from the
#' `olympic_results` dataset.
#'
#' @param athlete_name A character string representing the athlete's full name.
#' @return A character string containing the athlete’s results URL. Returns `NA` with a warning if no match is found.
#' @examples
#' find_athlete("Álvaro MARTÍN")
#' find_athlete("Unknown Athlete")
#' @export
find_athlete <- function(athlete_name) {
  match_row <- blue::olympic_results[blue::olympic_results$name == athlete_name, ]
  if (nrow(match_row) == 0) {
    warning("Athlete not found.")
    return(NA)
  }
  return(match_row$results_url)
}

#' @title Plot Top 10 Athletes in Final Round
#'
#' @description
#' For a given event, this function shows the top 10 fastest athletes in final round
#' based on their raw `mark` times (cleaned to remove non-numeric parts),
#' and plots a bar chart with their time strings.
#'
#' @param event_name A character string, the event to plot.
#' @return A ggplot2 plot object showing top athletes' performance. Returns NULL with a warning if no valid data is found.
#' @examples
#' plot_event_top10("20 Kilometres Race Walk")
#' @importFrom dplyr filter mutate arrange slice left_join if_else desc
#' @importFrom magrittr %>%
#' @importFrom stringr str_trim str_detect str_split str_extract fixed str_replace
#' @importFrom ggplot2 ggplot aes geom_col geom_text labs theme_minimal theme element_text
#' @importFrom stats reorder
#' @importFrom rlang .data
#' @export
plot_event_top10 <- function(event_name) {
  extract_numeric <- function(mark) {
    mark <- str_trim(mark)
    if (str_detect(mark, ":")) {
      parts <- str_split(mark, ":")[[1]]
      nums <- suppressWarnings(as.numeric(parts))
      if (any(is.na(nums))) return(NA_real_)
      if (length(nums) == 2) return(nums[1] * 60 + nums[2])
      if (length(nums) == 3) return(nums[1] * 3600 + nums[2] * 60 + nums[3])
      return(NA_real_)
    }
    as.numeric(str_extract(mark, "^[0-9]+\\.?[0-9]*"))
  }

  event_type_info <- tibble::tibble(
    event = c(
      "10,000 Metres", "100 Metres", "100 Metres Hurdles", "110 Metres Hurdles",
      "1500 Metres", "20 Kilometres Race Walk", "200 Metres", "3000 Metres Steeplechase",
      "400 Metres", "400 Metres Hurdles", "4x100 Metres Relay", "4x400 Metres Relay",
      "5000 Metres", "800 Metres", "Discus Throw", "Hammer Throw", "High Jump",
      "Javelin Throw", "Long Jump", "Marathon", "Marathon Race Walk Mixed Relay",
      "Pole Vault", "Shot Put", "Triple Jump"
    ),
    better_when = c(
      "shorter", "shorter", "shorter", "shorter",
      "shorter", "shorter", "shorter", "shorter",
      "shorter", "shorter", "shorter", "shorter",
      "shorter", "shorter", "longer", "longer",
      "longer", "longer", "longer", "shorter",
      "shorter", "longer", "longer", "longer"
    )
  )

  clean_data <- blue::olympic_results %>%
    filter(
      str_detect(.data$event, fixed(event_name, ignore_case = TRUE)),
      round == "Final"
    ) %>%
    mutate(
      numeric_mark = sapply(.data$mark, extract_numeric),
      display_mark = str_trim(str_extract(.data$mark, "[0-9\\.]+$"))
    ) %>%
    left_join(event_type_info, by = "event") %>%
    filter(!is.na(.data$numeric_mark)) %>%
    arrange(if_else(.data$better_when == "shorter", .data$numeric_mark, -.data$numeric_mark)) %>%
    slice(1:10)

  if (nrow(clean_data) == 0) {
    warning("No valid data found for event: ", event_name)
    return(NULL)
  }

  ggplot(clean_data, aes(x = reorder(.data$name, .data$numeric_mark), y = .data$numeric_mark)) +
    geom_col(fill = "steelblue") +
    geom_text(aes(label = .data$display_mark), vjust = -0.5, size = 3.5) +
    labs(
      title = paste("Top 10 Athletes in", event_name),
      x = "Athlete",
      y = "Performance"
    ) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}
