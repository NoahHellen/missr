test_that("mnar() accepts as input a `data.frame` only", {
  expect_error(mcar(c(1, 2)), "Expected a data.frame object.")
  expect_error(mcar(matrix(c(1, 2))), "Expected a data.frame object.")
})

test_that("mnar() accepts data with missing values only", {
  expect_error(
    mcar(testscores),
    "There is no missing data in this dataset."
  )
})

test_that("mnar() warns users of non-numeric encoding", {
  expect_warning(mcar(animalhealth), "Non-numeric columns encoded - verify
    interpretable.")
})

test_that("mnar() calculates correct MCAR statistics", {
  output <- mnar(companydata)
  expect_equal(output$mcar$statistic, 22.6702661)
  expect_equal(output$mcar$degrees_freedom, 11)
  expect_equal(output$mcar$p_val, 0.019665507)
  expect_equal(output$mcar$missing_patterns, 4)
})

test_that("mnar() calculates correct MAR statistics", {
  output <- mnar(companydata)
  expect_equal(output$mar$missing, c("product_rating", "employees"))
  expect_equal(output$mar$p_value, c(0.106108131, 0.012842060))
  expect_equal(output$mar$explanatory, c("product_rating", "gross_profit"))
})
