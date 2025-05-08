test_that("find_athlete returns correct type and handles missing names", {
  url <- find_athlete("Álvaro MARTÍN")
  expect_type(url, "character")        # Should return a character string
  expect_true(!is.na(url))

  missing_url <- find_athlete("Nonexistent Name")
  expect_true(is.na(missing_url))
})


test_that("plot_event_top10 produces a consistent plot for 100 metres", {
  vdiffr::expect_doppelganger(
    title = "Top 10 in 100 metres",
    fig = plot_event_top10("100 metres")
  )
})
