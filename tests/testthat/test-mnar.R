test_that("mnar() accepts as input a `data.frame` only", {
  expect_error(mnar(c(1, 2)), "Expected a data.frame object.")
  expect_error(mnar(matrix(c(1, 2))), "Expected a data.frame object.")
})

test_that("mnar() accepts data with missing values only", {
  expect_error(
    mnar(testscores),
    "There is no missing data in this dataset."
  )
})

test_that("mnar() warns users of non-numeric encoding", {
  expect_warning(mnar(animalhealth), "Non-numeric columns encoded - verify
    interpretable.")
})

test_that("mnar() calculates correct MCAR statistics", {
  testthat::skip_on_cran()
  output <- mnar(companydata)
  expect_equal(output$mcar$statistic, 22.6702661)
  expect_equal(output$mcar$degrees_freedom, 11)
  expect_equal(output$mcar$p_val, 0.019665507)
  expect_equal(output$mcar$missing_patterns, 4)
})


test_that("mnar() calculates correct MAR statistics", {
  testthat::skip_on_cran()
  output <- mnar(companydata)
  expect_equal(output$mar$missing, c("product_rating", "employees"))
  expect_equal(output$mar$p_value, c(0.11, 0.01), tolerance = 1e-1)
  expect_equal(output$mar$explanatory, c("product_rating", "gross_profit"))
  expect_equal(output$mar$p_values$product_rating,
    c(0.61, 0.93, 0.11, 0.76, 0.26),
    tolerance = 1e-1
  )
  expect_equal(output$mar$p_values$employees,
    c(0.89, 0.01, 0.80, 0.86, 0.01),
    tolerance = 1e-1
  )
})
