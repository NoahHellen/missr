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
  expect_equal(output$mcar$statistic, 23.1052711)
  expect_equal(output$mcar$degrees_freedom, 11)
  expect_equal(output$mcar$p_val, 0.017080522)
  expect_equal(output$mcar$missing_patterns, 4)
})

test_that("mnar() calculates correct MAR statistics", {
  output <- mnar(companydata)
  expect_equal(output$mar$missing, c("product_rating", "employees"))
  expect_equal(output$mar$p_value, c(0.264449722, 0.004426023))
  expect_equal(output$mar$explanatory, c("sales", "marketing_spend"))
  expect_equal(
    output$mar$p_values$product_rating,
    c(0.264449722, 0.440849734, 0.651517513, 0.860523549, 0.787753424)
  )
  expect_equal(
    output$mar$p_values$employees,
    c(0.071826853, 0.004426023, 0.061064328, 0.432772060, 0.152164590)
  )
})
