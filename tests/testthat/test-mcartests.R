test_vector <- c(1, 2)
test_no_miss_matrix <- matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2)
test_num_matrix <- matrix(c(1, NA, 3, 4), nrow = 2, ncol = 2)
test_mix_matrix <- matrix(c(1, NA, "Viola", "Guitar"), nrow = 2, ncol = 2)
test_num_df <- as.data.frame(test_num_matrix)
test_no_miss_df <- as.data.frame(test_no_miss_matrix)
test_mix_df <- as.data.frame(test_mix_matrix)

test_that("mcar() accepts as input a data.frame only", {
  expect_error(mcar(test_vector), "Expected a data.frame object.")
  expect_error(mcar(test_num_matrix), "Expected a data.frame object.")
})

test_that("mcar() accepts data with missing values only", {
  expect_error(mcar(test_no_miss_df), "There is no missing data in this dataset.")
})

test_that("mcar() warns users of non-numeric encoding", {
  expect_warning(mcar(test_mix_df), "Non-numeric columns encoded - verify
    interpretable.")
})

test_that("mcar() computes correct number of variables", {
  mcar(test_num_df, debug = TRUE)
  debug_p <- getOption("p")
  expect_equal(debug_p, 2)
})
