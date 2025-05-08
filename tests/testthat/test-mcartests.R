test_that("mcar: input check test", {
  vector <- c(1, 2)
  matrix <- matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2)
  expect_error(mcar(vector), "Expected a data.frame object.")
  expect_error(mcar(matrix), "Expected a data.frame object.")
})
