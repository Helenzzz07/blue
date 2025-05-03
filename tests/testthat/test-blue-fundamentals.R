test_that("find_athlete returns correct type and handles missing names", {
  url <- find_athlete("Álvaro MARTÍN")
  expect_type(url, "character")        # Should return a character string
  expect_true(!is.na(url))             # Should not return NA for valid athlete

  missing_url <- find_athlete("Nonexistent Name")
  expect_true(is.na(missing_url))      # Should return NA for missing athlete
})
