  #' @title Get Event Results
  #' @description
  #' Retrieve results for a specific event from the Paris 2024 Olympic Games dataset.
  #'
  #' @param results A dataframe containing the Paris 2024 Olympic Games results.
  #' @param event_name A string indicating the event name to retrieve results for (e.g., "Men's 100m").
  #'
  #' @return A subset of the dataframe with only the rows matching the event name.
  #' @export
  get_event_results <- function(results, event_name) {
    subset(results, Event == event_name)
  }
