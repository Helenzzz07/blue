#' @title Plot Medal Counts
#' @description
#' `plot_medal_counts()` retrieves Olympic medal counts and displays them as a bar chart by country.
#'
#' @param medal_data A data frame containing columns: country, gold, silver, bronze.
#' @param top_n Integer. The number of top countries to display based on total medals. Default is 10.
#'
#' @returns A ggplot object showing the medal counts per country.
#'
#' @examples
#' sample_data <- data.frame(
#'   country = c("USA", "China", "France"),
#'   gold = c(10, 8, 6),
#'   silver = c(5, 7, 4),
#'   bronze = c(2, 3, 5)
#' )
#' plot_medal_counts(sample_data)
#'
#' @import ggplot2
#' @export
plot_medal_counts <- function(medal_data, top_n = 10) {
  medal_data$total <- medal_data$gold + medal_data$silver + medal_data$bronze
  medal_data <- medal_data[order(-medal_data$total), ][1:top_n, ]

  medal_long <- tidyr::pivot_longer(
    medal_data,
    cols = c("gold", "silver", "bronze"),
    names_to = "medal",
    values_to = "count"
  )

  ggplot(medal_long, aes(x = reorder(country, -count), y = count, fill = medal)) +
    geom_bar(stat = "identity", position = "stack") +
    labs(
      title = paste("Top", top_n, "Countries by Medal Count"),
      x = "Country",
      y = "Number of Medals"
    ) +
    theme_minimal()
}
