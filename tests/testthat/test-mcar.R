test_that("mcar() accepts as input a data.frame only", {
  expect_error(mcar(c(1, 2)), "Expected a data.frame object.")
  expect_error(mcar(matrix(1, 2)), "Expected a data.frame object.")
})

test_that("mcar() accepts data with missing values only", {
  expect_error(
    mcar(testscores),
    "There is no missing data in this dataset."
  )
})

test_that("mcar() warns users of non-numeric encoding", {
  expect_warning(mcar(animalhealth), "Non-numeric columns encoded - verify
    interpretable.")
})

test_that("mcar() computes correct number of variables", {
  mcar(pollutionlevels, debug = TRUE)
  p <- getOption("p")
  expect_equal(p, 4)
})

test_that("mcar() computes correct indicator matrix", {
  mcar(pollutionlevels, debug = TRUE)
  ind <- getOption("ind")
  expected <- 1 * !is.na(pollutionlevels)
  colnames(expected) <- colnames(ind)
  expect_equal(ind, expected)
})

test_that("mcar() computes correct total missing patterns", {
  mcar(pollutionlevels, debug = TRUE)
  total_miss <- getOption("total_miss")
  expect_equal(total_miss, 2)
})

test_that("mcar() calculates correct statistics", {
  testthat::skip_on_cran()
  output <- mcar(pollutionlevels)
  expect_equal(output$statistic, 1.4909763)
  expect_equal(output$degrees_freedom, 3)
  expect_equal(output$p_val, 0.684354552)
  expect_equal(output$missing_patterns, 2)
})
