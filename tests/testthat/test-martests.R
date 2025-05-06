test_that("mar: input check test", {
  vector <- c(1, 2)
  matrix <- matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2)
  expect_error(mar(vector), "Expected a data.frame object.")
  expect_error(mar(matrix), "Expected a data.frame object.")
})
